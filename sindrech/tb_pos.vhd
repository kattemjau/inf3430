library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb is 

end tb;

architecture tb_pos of tb is

 component pos_meas_beh is
    port (a : in std_logic;
	 b : in std_logic;
	 sync_rst : in std_logic;
	 clk : in std_logic;
	 rst : in std_logic;
	 pos : out signed(7 downto 0));
  end component pos_meas_beh;
  
	signal a : std_logic;
	signal b : std_logic;
	signal sync_rst : std_logic;
	signal clk : std_logic;
	signal rst : std_logic;
	signal pos : signed(7 downto 0);
	
begin

Q: entity work.pos_meas
    port map (sync_rst => sync_rst,   
            clk => clk,    
            a => a, 
            b => b,
			rst => rst,
            pos => pos);

P_CLK_0: process
  begin
    clk <= '0';
    wait for 50 ns;
    clk <= '1';
    wait for 50 ns;    
  end process P_CLK_0;
  
  P_a_0: process
  begin
    a <= '0';
    wait for 20 ns;
	b <= '0';
	wait for 20 ns;
    a <= '1';
    wait for 20 ns;    
	b <= '1';
	wait for 20 ns;
  end process P_a_0;
  
  rst <= '0', '1' after 100 ns;
  sync_rst <= '0', '1' after 100 ns;
  
  
  
 end architecture;