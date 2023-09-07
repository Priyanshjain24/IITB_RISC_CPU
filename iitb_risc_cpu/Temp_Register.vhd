library std;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity Temp_reg is
port(
  clk, rst, wr: in std_logic;
  Din: in std_logic_vector(15 downto 0);
  Dout: out std_logic_vector(15 downto 0));
end entity;

architecture reg1 of Temp_reg is
  signal reg: std_logic_vector(15 downto 0) := "0000000000000000";
  
function add(A : in std_logic_vector (15 downto 0);
					 B : in std_logic_vector (15 downto 0);
					 C_in : in std_logic)
	return std_logic_vector is
		variable sum : std_logic_vector (15 downto 0);
		variable carry : std_logic_vector (16 downto 0);
	
	begin
	
   carry(0) := C_in;
		
		L1 : for i in 0 to 15 loop
			sum(i) := A(i) xor B(i) xor carry(i);
         carry(i+1) := (A(i) and B(i)) or (carry(i) and (A(i) or B(i)));
      end loop L1 ;
   return sum ;
	end add;
  
  
begin
process(clk,rst,wr,Din,reg)
  begin
  
      if(rst = '1') then
          reg <= "0000000000000000";
      else
			 if(rising_edge(clk) and wr = '1') then
				reg <= add(Din, "0000000000000010", '0');
          end if;
		end if;
		
	 Dout <= reg;

	 end process;

end reg1;