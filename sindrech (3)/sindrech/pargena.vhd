
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.subprog_pck.all;

entity pargen is 
  port (
    rst_n        : in  std_logic;
    mclk         : in  std_logic;
    indata1      : in  std_logic_vector(15 downto 0);
    indata2      : in  unsigned(15 downto 0);
    par          : out std_logic);  
end pargen;

  --signal parity1, parity2 : out std_logic;

architecture rtl1 of pargen is 

  signal B   : std_logic;
  signal A    : std_logic;
  
  begin  
  
  process (rst_n, mclk) is   
  
  begin
    if (rst_n = '0') then       
      par <= '0';
    elsif rising_edge(mclk) then
     foc(indata1, B);
	 foc(indata2, A);
	 
	 par <=  B xor A;
    end if;
  end process;
end rtl1;
