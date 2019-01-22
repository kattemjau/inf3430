library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity cru is
  port (
    arst         : in  std_logic; -- Asynch. reset
	  refclk       : in  std_logic; --Reference clock
	  rst          : out  std_logic; --Synchronized arst_ for mclk
	  rst_div      : out  std_logic; --Synchronized arst_ for mclk_div
	  mclk         : out  std_logic; -- Master clock
	  mclk_div     : out  std_logic -- Master clock div. by 128
  
    );
end cru;
