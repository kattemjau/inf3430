library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


	--rst       : in  std_logic;           -- Reset
    --clk       : in  std_logic;           -- Clock
    --sp        : in  signed(7 downto 0);  -- Set Point
    --pos       : in  signed(7 downto 0);  -- Measured position
    --motor_cw  : out std_logic;           --Motor Clock Wise direction
    --motor_ccw : out std_logic            --Motor Counter Clock Wise direction
	
architecture pos_ctrl of p_ctrl is
	TYPE State_type IS (idle_st, sampel_st, motor_st);
	Signal State : State_type;

	
begin

-- read pos from pos_meas_beh
-- make motor go to pos (SP) setpoint
	process (clk, rst, sp, pos) is
	variable err : signed(7 downto 0);
	begin
	if rst = '1' then
		motor_cw <= '0';
		motor_ccw <= '0';
		State <= idle_st;
	elsif rising_edge(clk) then
	
	case state is
		when idle_st => 
			motor_ccw <= '0';
			motor_cw <= '0';
			State <= sampel_st;
		when sampel_st =>
			err := sp - pos;
			State <= motor_st;
		when motor_st =>
			if err > 0 then
				motor_cw <= '1';
				motor_ccw <= '0';
				State <= sampel_st;
			elsif err < 0 then
				motor_cw <= '0';
				motor_ccw <= '1';
				State <= sampel_st;
			else
				State <= idle_st;
			end if;	
		end case;
	end if;
	
	end process;



end architecture pos_ctrl;