library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

architecture pos_ctrl of pos_ctrl is

  signal cw : std_logic;
  signal ccw : std_logic;

 component p_ctrl is
    port (
	 clk : in std_logic;
	 rst : in std_logic;
	 sp : in signed(7 downto 0);
	 pos : in signed(7 downto 0);
	 cw  : out std_logic;           --Motor Clock Wise direction
	 ccw : out std_logic
	 );
  end component p_ctrl;
  
  component pos_meas_beh is
    port (a : in std_logic;
	 b : in std_logic;
	 sync_rst : in std_logic;
	 clk : in std_logic;
	 rst : in std_logic;
	 pos : out signed(7 downto 0));
  end component pos_meas_beh;
  
	signal sp1 : signed(7 downto 0 );
	signal postemp : signed(7 downto 0);
	
begin

--mask away sp bit
sp1 <= '0' & sp(6 downto 0);


	Q: entity work.pos_meas
    port map (sync_rst => sync_rst,   
            clk => mclk,    
            a => a, 
            b => b,
			rst => rst,
            pos => postemp);
			
	Q1: entity work.p_ctrl
    port map (clk => mclk_div,   -- implement its own clock
			motor_cw => cw,
			motor_ccw => ccw, 			
			rst => rst_div,
			sp => sp1,
            pos => postemp);

			
	process (mclk, rst)
	begin
	-- forced running of motor.	
	if force_cw = '1' then
		if force_ccw = '1' then
			motor_cw <= cw; -- from p_ctrl
			motor_ccw <= ccw;
		else
			motor_cw <= '1';
			motor_ccw <= '0';
		end if;
	else
		if force_ccw = '0' then
			motor_cw <= cw; -- from p_ctrl
			motor_ccw <= ccw;
		else
			motor_cw <= '0';
			motor_ccw <= '1';
		end if;
	end if;
	pos <= postemp;
	end process;
		

end architecture pos_ctrl;