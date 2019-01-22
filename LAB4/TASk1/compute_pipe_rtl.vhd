library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 

architecture rtl of compute_pipelined is
    signal addresult_i  : unsigned(17 downto 0) := (others => '0');
	signal e_reg : std_logic_vector(15 downto 0) := (others => '0');
	signal dvalid_r : std_logic := '0';
	
begin
 
  process (rst, clk) is
    variable multresult_i : unsigned(33 downto 0) := (others => '0');
	
  begin
    if rst = '1' then
      result <= (others => '0');
      max    <= '0';
      rvalid <= '0';
	  addresult_i <= (others => '0');
	  e_reg <= (others => '0');
	  dvalid_r <= '0';
	  --multresult_i := (others => '0');
    elsif rising_edge(clk) then
	--rvalid <= '0'; -- prøver å sync
      if (dvalid = '1' or dvalid_r = '1') then
	    --multresult_i := addresult_i * unsigned(e);
        addresult_i <= (unsigned("00" & a) + unsigned("00" & b)) +
                       (unsigned("00" & c) + unsigned("00" & d));
		e_reg <= e; 
		
        multresult_i := addresult_i * unsigned(e_reg);
        if (multresult_i(33 downto 32) = "00") then
          result <= std_logic_vector(multresult_i(31 downto 0));
          max    <= '0';
        else
		  result <= (others => '1');
          max    <= '1';
        end if;
      else
	    result <= (others => '0');
        max    <= '0';
      end if;
	  dvalid_r <= dvalid;
	  rvalid <= dvalid_r;


    end if;
  end process;

end architecture rtl;
