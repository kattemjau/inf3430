library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.subprog_pck.all;

entity stopwatch is 
port (
mclk         : in std_logic; --100MHz, positive flank
reset        : in std_logic; --Asynchronous reset, activeh
SW			 : in std_logic_vector(7 downto 0);
BTNR		 : in std_logic;
BTNL		 : in std_logic;
BTNC		 : in std_logic
);
end stopwatch;

architecture thing of stopwatch is 

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
  variable counter : std_logic_vector(26 downto 0) := "000000000000000000000000000";
  variable running : std_logic := '0';
  begin
  if (reset ='1') or (BTNR = '1') then
	d0 <= "0000";
	d1 <= "0000";
	d2 <= "0000";
	d3 <= "0000";
	running := '0';
  
  end if;
  
  -- start = BTNL, STOp = BTNC
  if BTNL = '1' then
	running := '1';
  elsif BTNC = '1' then
	running := '0';
  end if;
  
  
  if rising_edge(mclk) and running = '1' then
	-- counter for ea second
	if counter = "101111101011110000100000000" then
		counter := "000000000000000000000000000";
		
	if d0 = "1111" then
		d0 <= "0000";
		if d1 = "1111" then
			d1 <= "0000";
			if d2 <= "1111" then 
				d2 <= "0000";
				if d3 <= "1111" then 
					d3 <= "0000";
				else
					d3 <= std_logic_vector(unsigned(d1) +1);
				end if;
			else
				d2 <= std_logic_vector(unsigned(d1) +1);
			end if;
		else
			d1 <= std_logic_vector(unsigned(d1) +1);	
		end if;
	else
		d0 <= std_logic_vector(unsigned(d0) +1);
	end if;
		
		
	else
		counter := std_logic_vector(unsigned(counter) + 1);
	end if;
  
  end if;
  
  dec <= "1111";
  end process;

  SEG: seg7ctrl port map (mclk, reset, d0, d1, d2, d3, dec, abcdefgdec_n, a_n);

end;