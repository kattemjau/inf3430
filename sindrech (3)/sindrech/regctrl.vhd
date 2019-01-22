library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.subprog_pck.all;

entity regctrl is 
port (
mclk         : in std_logic; --100MHz, positive flank
reset        : in std_logic; --Asynchronous reset, activeh
SW			 : in std_logic_vector(7 downto 0);
BTNR		 : in std_logic;
BTNL		 : in std_logic
);
end regctrl;

architecture thing of regctrl is 

component seg7ctrl is
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
end component seg7ctrl;

signal d0           : std_logic_vector(3 downto 0); -- first display?
signal d1           : std_logic_vector(3 downto 0); -- second display?
signal d2           : std_logic_vector(3 downto 0); -- third display?
signal d3           : std_logic_vector(3 downto 0); -- fourth display?
signal dec          : std_logic_vector(3 downto 0); -- pumktum
signal abcdefgdec_n : std_logic_vector(7 downto 0); -- what to be displayed inverted
signal a_n          : std_logic_vector(3 downto 0);


begin
  
  
  
  process (reset, mclk, BTNR) is
  begin
  if (reset ='1') or (BTNR = '1') then
	d0 <= "0000";
	d1 <= "0000";
	d2 <= "0000";
	d3 <= "0000";
  
  end if;
  
  if BTNL = '1' and rising_edge(mclk) then
	case SW(7 downto 6) is
		when "00" =>
	d0 <= SW(3 downto 0);
		when "01" =>
	d1 <= SW(3 downto 0);
		when "10" =>
	d2 <= SW(3 downto 0);
		when others =>
	d3 <= SW(3 downto 0);
		
	end case;
  end if;
  
  dec <= "1111";
  end process;

  SEG: seg7ctrl port map (mclk, reset, d0, d1, d2, d3, dec, abcdefgdec_n, a_n);

end;