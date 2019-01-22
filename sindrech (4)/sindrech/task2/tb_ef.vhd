library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_ef is
--  Port ( );
end tb_ef;

architecture Behavioral of tb_ef is

component ef is
--  Port ( );
    port
    (
  --Signalname : <mode> <data_type>; mode: in, out or inout
    SW      : in  std_logic_vector(1 downto 0);
    --SW2      : in  std_logic; -- Clock from switch CLK1/INP1
    LD      : out std_logic_vector(3 downto 0) -- Global Asynchronous Reset

    );
end component;

  signal swit   : std_logic_vector(1 downto 0);

begin


  test: ef port map (swit, open);

  switch: process
  begin
    swit <= "00";
    wait for 100 ns; 
    swit <= "01";
    wait for 100 ns;  
	swit <= "10";
    wait for 100 ns; 
    swit <= "11";
    wait for 100 ns;	
  end process switch;
  
  

end Behavioral;
