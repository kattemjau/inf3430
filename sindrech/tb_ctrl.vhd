library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity tb is 

end tb;

architecture tb_ctrl of tb is

 component p_ctrl is
    port (
	 clk : in std_logic;
	 rst : in std_logic;
	 sp : in signed(7 downto 0);
	 pos : in signed(7 downto 0);
	 motor_cw  : out std_logic;           --Motor Clock Wise direction
	 motor_ccw : out std_logic
	 );
  end component p_ctrl;

  
	signal clk : std_logic;
	signal rst : std_logic;
	signal pos : signed(7 downto 0);
	signal sp : signed(7 downto 0);
	signal motor_ccw : std_logic;
	signal motor_cw : std_logic;
	
begin

Q: entity work.p_ctrl
    port map (clk => clk,   
			motor_cw => motor_cw,
			motor_ccw => motor_ccw, 			
			rst => rst,
			sp => sp,
            pos => pos);
			
	
	P_CLK_0: process
  begin
    clk <= '0';
    wait for 50 ns;
    clk <= '1';
    wait for 50 ns;    
  end process P_CLK_0;
  
  
  rst <= '1', '0' after 100 ns;
  
	pos <= "00000000",
	"00001100" after 200 us,
	"00110000" after 300 us,
	"00000000" after 400 us,
	"00000000" after 500 us;

	sp <= "00001000",
	"00000000" after 200 us,
	"00000011" after 300 us,
	"00001000" after 400 us,
	"00000000" after 500 us;
  		
			

end architecture tb_ctrl;