library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.subprog_pck.all;

entity seg7ctrl is
port
(
mclk         : in std_logic; --100MHz, positive flank
reset        : in std_logic; --Asynchronous reset, activeh
d0           : in std_logic_vector(3 downto 0); -- first display?
d1           : in std_logic_vector(3 downto 0); -- second display?
d2           : in std_logic_vector(3 downto 0); -- third display?
d3           : in std_logic_vector(3 downto 0); -- fourth display?
dec          : in std_logic_vector(3 downto 0); -- pumktum
abcdefgdec_n : out std_logic_vector(7 downto 0); -- what to be displayed inverted
a_n          : out std_logic_vector(3 downto 0) -- select display
);
end entity seg7ctrl;

architecture disp of seg7ctrl is

begin
	
	Process (mclk, reset)
	variable counter : std_logic_vector(1 downto 0) := "00";
	begin
	
	if reset = '1' then
		-- reset all
		counter := "00";
		abcdefgdec_n <= "00000000";
		a_n <= "0000";
		
		
	elsif rising_edge(mclk) then
		if (counter = "11") then
		counter := "00";
		else
		counter := std_logic_vector(unsigned(counter) + 1);
		end if;
		
		case counter is
			when "00" =>
				a_n <= "0001";
				abcdefgdec_n <= hex2seg7(d0, dec(0));
			when "01" =>
				a_n <= "0010";
				abcdefgdec_n <= hex2seg7(d1, dec(1));
			when "10" =>
				a_n <= "0011";
				abcdefgdec_n <= hex2seg7(d2, dec(2));
			when others =>
				a_n <= "0100";
				abcdefgdec_n <= hex2seg7(d3, dec(3));
		end case;

	end if;
	end process;
end;

