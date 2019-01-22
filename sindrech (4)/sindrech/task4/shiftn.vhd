library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity shiftn is
  generic (N: integer := 64);
  port (
    rst_n     : in  std_logic;   -- Reset
    mclk      : in  std_logic;   -- Clock
    din       : in  std_logic; 
    dout      : out std_logic
    );
end shiftn;

architecture Behavioral of shiftn is


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
  
  signal SEL: std_logic_vector(N-1 downto 0);
  
begin

  F: for I in 0 to N-1 generate
            
    FIRSTBIT: if I=0 generate
      G1: dff port map (rst_n, mclk, din, SEL(0));
    end generate FIRSTBIT;
     
    MID: if I>0 generate
          G2: dff port map (rst_n, mclk, SEL(I-1), SEL(I));
    end generate MID;
        
           
  end generate F;
    
  
  dout <= SEL(N-1);
    
end Behavioral;
