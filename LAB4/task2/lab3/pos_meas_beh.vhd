library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


architecture pos_beh of pos_meas is

TYPE State_type IS (start_up_st, wait_a1_st, wait_a0_st, up_down_st, count_up_st, count_down_st);
	Signal State : State_type;

begin

	process(a, b, sync_rst, clk)
		variable posi : signed(7 downto 0) := "00000000";
		variable counter : unsigned(1 downto 0) := "00";
	begin
	
	if rst = '1' then
		posi := "00000000";
		State <= start_up_st;
		
	elsif rising_edge(clk) then
	if sync_rst = '1' then
		posi := "00000000";
		State <= start_up_st;
	end if;
	
	case state is
		when start_up_st =>
			if a = '1' then
				State <= wait_a0_st;
			else 
				State <= wait_a1_st;
			end if;
			
		when wait_a0_st =>
			if a='1' then 
				State <= wait_a0_st;
			else 
				State <= up_down_st;
			end if;
		when wait_a1_st => 
			if a='1' then
				State <= wait_a0_st;
			else
				State <= wait_a1_st;
			end if;
		when up_down_st =>
			if b='1' then
				State <= count_down_st;
			else
				State <= count_up_st;
			end if;
		when count_down_st =>
					if posi > 0 then	
						posi := posi - 1;
					end if;
			State <= wait_a1_st;
		when count_up_st =>
			
				if posi < 127 then	
						posi := posi + 1;
					end if;
			State <= wait_a1_st;

			
		end case;
	end if;
	pos <= posi;
	end process;
	
end architecture pos_beh;