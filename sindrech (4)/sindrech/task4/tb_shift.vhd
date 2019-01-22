library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity tb_shift is
--  Port ( );
end tb_shift;

architecture Behavioral of tb_shift is

  Component shift8 
    port
    (
        rst_n     : in  std_logic;   -- Reset
        mclk      : in  std_logic;   -- Clock
        -- Shifted data in and out
        din       : in  std_logic;   -- Data in
        dout      : out std_logic    -- Data out
    );
  end Component;
  Component shift32 
      port
      (
          rst_n     : in  std_logic;   -- Reset
          mclk      : in  std_logic;   -- Clock
          -- Shifted data in and out
          din       : in  std_logic;   -- Data in
          dout      : out std_logic    -- Data out
      );
    end Component;
    Component shiftn 
        port
        (
            rst_n     : in  std_logic;   -- Reset
            mclk      : in  std_logic;   -- Clock
            -- Shifted data in and out
            din       : in  std_logic;   -- Data in
            dout      : out std_logic    -- Data out
        );
      end Component;

  signal rst_n   : std_logic;
  signal mclk    : std_logic;
  signal din     : std_logic;
  signal dout    : std_logic;
  
  signal restulat : std_logic_vector(2 downto 0);

begin

  shift_8: shift8 port map (rst_n, mclk, din, restulat(0));
  shift_32: shift32 port map (rst_n, mclk, din, restulat(1));
  
  shift_n: shiftn
	generic map (N => 64)
	port map (rst_n, mclk, din, restulat(2));

  P_CLK_0: process
  begin
    mclk <= '0';
    wait for 50 ns; 
    mclk <= '1';
    wait for 50 ns;    
  end process P_CLK_0;
  
  rst_n  <= '0','1' after 100 ns;
  din <= '1', '0' after 150ns,'1' after 300ns;   
  
  dout <= (restulat(0) and restulat(1) and restulat(2));
end Behavioral;
