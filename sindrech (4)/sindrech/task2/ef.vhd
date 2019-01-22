
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ef is
--  Port ( );
    port
    (
  --Signalname : <mode> <data_type>; mode: in, out or inout
    SW      : in  std_logic_vector(1 downto 0);
    --SW2      : in  std_logic; -- Clock from switch CLK1/INP1
    LD      : out std_logic_vector(3 downto 0) -- Global Asynchronous Reset

    );
end ef;

architecture Behavioral of ef is

begin

    EXAMPLE:
    process (SW)

    begin
     case SW is
        when "00" =>
            LD <= "1110";
        when "01" =>
            LD <= "1101";
        when "10" =>
            LD <= "1011";
        when others =>
            LD <= "0111";
      end case;

     end process EXAMPLE;
end Behavioral;
