library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

architecture pos_seg7_ctrl of pos_seg7_ctrl is

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


component cru is
port (
    arst         : in  std_logic;
    refclk : in std_logic;
    rst_div : out std_logic;
    rst   : out std_logic;
    mclk_div  : out std_logic;
    mclk  : out std_logic
);
end component cru;

	signal posi : signed(7 downto 0);
	signal rst	: std_logic;
	signal mclk	: std_logic;
	signal mclk_div	: std_logic;
	signal rst_div	: std_logic;
	signal sp1 : std_logic_vector(7 downto 0);


begin

sp1 <= '0' & sp(6 downto 0);

  O2: entity work.cru
      port map (
      arst          => arst,
      refclk => refclk,
      rst_div => rst_div,
      rst   => rst,
      mclk_div  => mclk_div,
      mclk  => mclk
      );

O: entity work.pos_ctrl
    port map (sync_rst => sync_rst,
			rst_div => rst_div,
			mclk_div => mclk_div,
			sp => signed(sp1),
			force_cw => force_cw,
			force_ccw => force_ccw,
			motor_cw => motor_cw,
			motor_ccw => motor_ccw,
            mclk => mclk,
            a => a,
            b => b,
			rst => rst,
            pos => posi);

O1: entity work.seg7ctrl
    port map (
	abcdefgdec_n => abcdefgdec_n,
	mclk => mclk,
	reset => rst,
	d0 => std_logic_vector(posi(3 downto 0)),
	d1 => std_logic_vector(posi(7 downto 4)),
	d2 => sp1(3 downto 0),
	d3 => sp1(7 downto 4),
	dec => "0000",
	a_n => a_n);





      --force_ccw <= BTNL;
      --force_cw <= BTNR;
      --sync_rst <= BTNC;




end architecture;
