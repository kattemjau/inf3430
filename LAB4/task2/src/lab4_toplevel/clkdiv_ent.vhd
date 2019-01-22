library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity clkdiv is
 port (
          rst      : in std_logic; -- Restet
	  mclk     : in std_logic; -- Master clock
	  mclk_div : out std_logic-- Master clock div. by 128 
     );

end clkdiv;
