library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.subprog_pck.all;


entity tb_hex2seg7 is 

end tb_hex2seg7;

 

architecture TestBench of tb_hex2seg7 is 

	signal output 		: std_logic_vector(7 downto 0);
	
	signal SEL			: std_logic;
	signal indata       : std_logic_vector(3 downto 0);
	
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

		signal a_n           : std_logic_vector(3 downto 0);
		--signal abcdefgdec_n  : std_logic_vector(7 downto 0);
		signal disp3         : std_logic_vector(3 downto 0);
		signal disp2         : std_logic_vector(3 downto 0);
		signal disp1         : std_logic_vector(3 downto 0);
		signal disp0         : std_logic_vector(3 downto 0);
	
begin
	
	--variable indata       :  std_logic_vector(3 downto 0) := "0001";
	--variable SEL			: std_logic := '0';			
	--variable output 		: std_logic_vector(7 downto 0);
	
	
	
			
	--kalle hex2seg7(SIGNAL, SEL), returnerer char og send det inn i seg7model_beh

 SEL <= '0';
  
  indata <= "0000",
             "0001" after 100 ns,
             "0011" after 200 ns,		
             "0111" after 300 ns,
             "1111" after 400 ns, 
             "0000" after 500 ns,
             "0001" after 600 ns,
             "0011" after 700 ns,
             "0111" after 800 ns,
             "1111" after 900 ns;
	
	output <= hex2seg7(indata, SEL);	
	a_n <= "0000"; --hvilken skjerm
	
	G1: seg7model port map (a_n, output, disp3, disp2, disp1, disp0);

end;
