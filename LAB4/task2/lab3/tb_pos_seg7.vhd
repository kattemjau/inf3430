library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb is 

end tb;

architecture tb_pos_seg7 of tb is
  
 component pos_seg7_ctrl_ent is
  port (
    -- System Clock and Reset
    arst         : in  std_logic;       -- Reset
    sync_rst     : in  std_logic;       -- Synchronous reset 
    refclk       : in  std_logic;       -- Clock
    sp           : in  std_logic_vector(7 downto 0);  -- Set Point
    a            : in  std_logic;       -- From position sensor
    b            : in  std_logic;       -- From position sensor
    force_cw     : in  std_logic;       -- Force motor clock wise motion
    force_ccw    : in  std_logic;  		-- Force motor counter clock wise motion
    motor_cw     : out std_logic;       -- Motor clock wise motion
    motor_ccw    : out std_logic;       -- Motor counter clock wise motion
    -- Interface to seven segments
    abcdefgdec_n : out std_logic_vector(7 downto 0);
    a_n          : out std_logic_vector(3 downto 0)
    );
	end component;
	
component motor is
  port (
    motor_cw  : in  std_logic;
    motor_ccw : in  std_logic;
    a         : out std_logic;
    b         : out std_logic
    );      
end component motor;


component seg7model is 
  port
  (
    a_n           : in  std_logic_vector(3 downto 0);
    abcdefgdec_n  : in  std_logic_vector(7 downto 0);
    disp3         : out std_logic_vector(3 downto 0);
    disp2         : out std_logic_vector(3 downto 0);
    disp1         : out std_logic_vector(3 downto 0);
    disp0         : out std_logic_vector(3 downto 0)
  );
end component seg7model;
	
    signal refclk      :  std_logic;        -- Clock
    signal sync_rst  :  std_logic;          -- Synchronous reset
    signal sp2        :  signed(7 downto 0); -- Setpoint (wanted position)
    signal a         :  std_logic;          -- From position sensor
    signal b         :  std_logic;          -- From position sensor
    signal force_cw  :  std_logic;          -- Force motor clock wise motion
    signal force_ccw :  std_logic;  		-- Force motor counter clock wise motion
	signal arst : std_logic;
	signal abcdefgdec_n : std_logic_vector(7 downto 0);
	signal a_n          : std_logic_vector(3 downto 0);
	signal motor_ccw : std_logic;
	signal motor_cw : std_logic;
	
	begin
	
	O1: entity work.seg7model
	port map ( 
		a_n => a_n,
		abcdefgdec_n => abcdefgdec_n,
		disp0 => open, 
		disp1 => open,
		disp2 => open,
		disp3 => open
	);
	O2: entity work.motor
	port map ( 
		motor_cw => motor_cw,
		motor_ccw => motor_ccw,
		a => a,
		b => b
	);
	
	
	O: entity work.pos_seg7_ctrl
    port map (sync_rst => sync_rst,
			arst => arst,
			refclk => refclk,
			sp => std_logic_vector(sp2),
			force_cw => force_cw,
			force_ccw => force_ccw,
			motor_cw => motor_cw,
			motor_ccw => motor_ccw,
            --mclk => mclk,
            a => a,
            b => b,
			--rst => rst,
			a_n => a_n,
			abcdefgdec_n => abcdefgdec_n
            );
	
	force_ccw <= '0';
	force_cw <= '0';
	arst <= '1', '0' after 100 ns;
	sync_rst <= '1', '0' after 100 ns;
	
	P_CLK_0: process
  begin
    refclk <= '0';
	--mclk_div <= '0';
    wait for 50 ns;
    refclk <= '1';
	--mclk_div <= '1';
    wait for 50 ns;    
  end process P_CLK_0;
  

  
    sp2 <= "00001000",
	"00000000" after 1000 us,
	"00000011" after 2000 us,
	"00001000" after 3000 us,
	"00100000" after 4000 us,
	"00110011" after 5000 us;

	
	
end architecture tb_pos_seg7;