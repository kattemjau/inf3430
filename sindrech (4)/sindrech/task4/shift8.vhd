library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

   

entity shift8 is
  port (
    rst_n     : in  std_logic;   -- Reset
    mclk      : in  std_logic;   -- Clock
    din       : in  std_logic; 
    dout      : out std_logic
    );
end shift8;

architecture Behavioral of shift8 is


  Component dff 
    port
    (
        rst_n     : in  std_logic;   -- Reset
        mclk      : in  std_logic;   -- Clock
        -- Shifted data in and out
        din       : in  std_logic;   -- Data in
        dout      : out std_logic    -- Data out
    );
  end Component;


  --signal  RST      : std_logic := '0'; --:= initial value
  --signal  CLK      : std_logic := '0';
  --signal  DATAIN   : std_logic := '0';
  --signal  DATAOUT  : std_logic;

    
  signal SEL: std_logic_vector(6 downto 0);
    --signal SEL: std_logic_vector(n-1 downto 0);
    

begin


    G1: dff port map (rst_n, mclk, din, SEL(0));
    G2: dff port map (rst_n, mclk, SEL(0), SEL(1));
    G3: dff port map (rst_n, mclk, SEL(1), SEL(2));
    G4: dff port map (rst_n, mclk, SEL(2), SEL(3));
    G5: dff port map (rst_n, mclk, SEL(3), SEL(4));
    G6: dff port map (rst_n, mclk, SEL(4), SEL(5));
    G7: dff port map (rst_n, mclk, SEL(5), SEL(6));
    G8: dff port map (rst_n, mclk, SEL(6), dout);   
   
   -- G3: dff port map (rst => rst_n, clk => mclk, datain => SEL(0), dataout => SEL(1));
 
 
   -- G1: Df port map (rst => rst_n, clk => mclk, datain => din, dataout => SEL(0));

 --dout <= SEL(1);
 --B1: Df port map (SEL(0), din);
 --G2: Df port map (dout, SEL(1));
 --G3: Df port map (dout, SEL(2));


end Behavioral;
