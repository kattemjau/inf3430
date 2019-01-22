library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

   

entity shift32 is
  port (
    rst_n     : in  std_logic;   -- Reset
    mclk      : in  std_logic;   -- Clock
    din       : in  std_logic; 
    dout      : out std_logic
    );
end shift32;

architecture Behavioral of shift32 is


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


  --signal  RST      : std_logic := '0'; --:= initial value
  --signal  CLK      : std_logic := '0';
  --signal  DATAIN   : std_logic := '0';
  --signal  DATAOUT  : std_logic;

    
  signal SEL: std_logic_vector(2 downto 0);
    --signal SEL: std_logic_vector(n-1 downto 0);
    

begin


    G1: shift8 port map (rst_n, mclk, din, SEL(0));
    G2: shift8 port map (rst_n, mclk, SEL(0), SEL(1));
    G3: shift8 port map (rst_n, mclk, SEL(1), SEL(2));
    G4: shift8 port map (rst_n, mclk, SEL(2), dout);
   
   -- G3: dff port map (rst => rst_n, clk => mclk, datain => SEL(0), dataout => SEL(1));
 
 
   -- G1: Df port map (rst => rst_n, clk => mclk, datain => din, dataout => SEL(0));

 --dout <= SEL(1);
 --B1: Df port map (SEL(0), din);
 --G2: Df port map (dout, SEL(1));
 --G3: Df port map (dout, SEL(2));


end Behavioral;
