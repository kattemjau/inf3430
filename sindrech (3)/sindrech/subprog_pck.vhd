library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package subprog_pck is
		function func (indata1 : in std_logic_vector(15 downto 0))
		return std_logic;
		function func (indata2 : in  unsigned(15 downto 0))
		return std_logic;	
		
		procedure foc (signal indata1 : in std_logic_vector; signal par : out std_logic);
		procedure foc (signal indata2 : in unsigned; signal par : out std_logic);
		
		function hex2seg7 (signal STATE : in std_logic_vector(3 downto 0); signal SEL : in std_logic)  
		return std_logic_vector;
end subprog_pck;
	
package body subprog_pck is 
	
	function func (indata1 : in std_logic_vector(15 downto 0))
	return std_logic is variable parity1 : std_logic;
		begin
		parity1 := '0';
		for i in indata1'range loop
			if indata1(i) = '1' then
			parity1 := not parity1;
			end if;        
		end loop;
			return parity1;	  	
		end;
	
	
	function func (indata2 : in  unsigned(15 downto 0))
	return std_logic is variable parity2 : std_logic;	
	begin
	parity2 := '0';
      for j in indata2'range loop
       parity2 := parity2 xor indata2(j); 
      end loop;
	return parity2;
	end;	
	
	
	function hex2seg7 (signal STATE : in std_logic_vector(3 downto 0); signal SEL : in std_logic)  
	return std_logic_vector is variable char : std_logic_vector(7 downto 0);
	begin
	  case STATE is
		when "0000" => char := "00000011";
		when "0001" => char := "10011111";
		when "0010" => char := "00100101";
		when "0011" => char := "00001101";
		when "0100" => char := "10011001";
		when "0101" => char := "01001001";
		when "0110" => char := "01000001";
		when "0111" => char := "00011111";
		when "1000" => char := "00000001";
		when "1001" => char := "00011001";
		when "1010" => char := "00010001";
		when "1011" => char := "11000001";
		when "1100" => char := "01100011";
		when "1101" => char := "10000101";
		when "1110" => char := "01100001";
		when "1111" => char := "01110001";
		
		when others => char := "00000000";
	
	  end case;
	  
	  if (SEL = '1' ) then
		char(0) := '0';
		
	  end if;
	  
	  return char;
	end;
	
	
	procedure foc (signal indata1 : in std_logic_vector; signal par : out std_logic) is
	variable parity1 : std_logic := '0';
	
	begin
	parity1 := '0';
      for i in indata1'range loop
        if indata1(i) = '1' then
          parity1 := not parity1;
        end if;        
      end loop;
	  par <= parity1;
  end procedure foc;

	procedure foc (signal indata2 : in unsigned; signal par : out std_logic) is
	variable parity2 : std_logic;
	begin
      parity2 := '0';
      for j in indata2'range loop
       parity2 := parity2 xor indata2(j); 
      end loop;
	  par <= parity2;
  end procedure foc;
	
	
end subprog_pck;