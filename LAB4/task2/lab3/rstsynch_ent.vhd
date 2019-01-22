library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rstsynch is
  port (
    arst         : in  std_logic; -- Asynch. reset
	  mclk         : in  std_logic; -- Master clock
	  mclk_div     : in  std_logic; -- Master clock div. by 128
	  rst          : out  std_logic; --Synch. reset master clock
	  rst_div      : out  std_logic --Synch. reset div. by 128	
  
    );
end rstsynch;
