library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.subprog_pck.all;

entity tb_seg7ctrl is 

end tb_seg7ctrl;

architecture TestBench of tb_seg7ctrl is 

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

signal mclk         : std_logic; --100MHz, positive flank
signal reset        : std_logic; --Asynchronous reset, activeh
signal d0           : std_logic_vector(3 downto 0); -- first display?
signal d1           : std_logic_vector(3 downto 0); -- second display?
signal d2           : std_logic_vector(3 downto 0); -- third display?
signal d3           : std_logic_vector(3 downto 0); -- fourth display?
signal dec          : std_logic_vector(3 downto 0); -- pumktum
signal abcdefgdec_n : std_logic_vector(7 downto 0); -- what to be displayed inverted
signal a_n          : std_logic_vector(3 downto 0);


begin

  P_CLK_0: process
  begin
    mclk <= '0';
    wait for 5 ns;
    mclk <= '1';
    wait for 5 ns;    
  end process P_CLK_0;
  
  reset <= '1', '0' after 10 ns;
  d0 <= "0011";
  d1 <= "0001";
  d2 <= "1011";
  d3 <= "0111";
  
  dec <= "1111";

  G1: seg7ctrl port map (mclk, reset, d0, d1, d2, d3, dec, abcdefgdec_n, a_n);

end;