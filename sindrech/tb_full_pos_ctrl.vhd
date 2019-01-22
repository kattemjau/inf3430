library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb is 

end tb;

architecture tb_full of tb is

 component pos_ctrl is
    port (
	rst       : in  std_logic;          -- Reset
    rst_div   : in  std_logic;          -- Reset
    mclk      : in  std_logic;          -- Clock
    mclk_div  : in  std_logic;          -- Clock to p_reg
    sync_rst  : in  std_logic;          -- Synchronous reset
    sp        : in  signed(7 downto 0);  -- Setpoint (wanted position)
    a         : in  std_logic;          -- From position sensor
    b         : in  std_logic;          -- From position sensor
    pos       : out signed(7 downto 0);  -- Measured Position
    force_cw  : in  std_logic;          -- Force motor clock wise motion
    force_ccw : in  std_logic;  -- Force motor counter clock wise motion
    motor_cw  : out std_logic;          -- Motor clock wise motion
    motor_ccw : out std_logic           -- Motor counter clock wise motion
	);
  end component pos_ctrl;
  
	signal rst       :  std_logic;          -- Reset
    signal rst_div   :  std_logic;          -- Reset
    signal mclk      :  std_logic;          -- Clock
    signal mclk_div  :  std_logic;          -- Clock to p_reg
    signal sync_rst  :  std_logic;          -- Synchronous reset
    signal sp        :  signed(7 downto 0);  -- Setpoint (wanted position)
    signal a         :  std_logic;          -- From position sensor
    signal b         :  std_logic;          -- From position sensor
    signal pos       :  signed(7 downto 0);  -- Measured Position
    signal force_cw  :  std_logic;          -- Force motor clock wise motion
    signal force_ccw :  std_logic;  -- Force motor counter clock wise motion
    signal motor_cw  :  std_logic;          -- Motor clock wise motion
    signal motor_ccw :  std_logic;           -- Motor counter clock wise motion

component motor is
  port (
    motor_cw  : in  std_logic;
    motor_ccw : in  std_logic;
    a         : out std_logic;
    b         : out std_logic
    );      
end component motor;
	
 --signal sp        :  signed(7 downto 0); -- Setpoint (wanted position)
	
	begin

	O: entity work.pos_ctrl
    port map (sync_rst => sync_rst,   
				rst_div => rst_div,
				mclk_div => mclk_div,
				sp => sp, 
				force_cw => force_cw,
				force_ccw => force_ccw,
				motor_cw => motor_cw,
				motor_ccw => motor_ccw,
            mclk => mclk,    
            a => a, 
            b => b,
			rst => rst,
            pos => pos);
			
	O2: entity work.motor
	port map ( 
		motor_cw => motor_cw,
		motor_ccw => motor_ccw,
		a => a,
		b => b
	);
			
	
P_CLK_0: process
  begin
    mclk <= '0';
	mclk_div <= '0';
    wait for 50 ns;
    mclk <= '1';
	mclk_div <= '1';
    wait for 50 ns;    
  end process P_CLK_0;
  
  rst <= '1', '0' after 100 ns;
  rst_div <= '1', '0' after 100 ns;
  sync_rst <= '1', '0' after 100 ns;
  
  
  	sp <= "00001000",
	"00000000" after 200 us,
	"00000011" after 300 us,
	"00001000" after 400 us,
	"00000000" after 500 us;
	force_cw <= '0';
	force_ccw <= '0';


end architecture tb_full;