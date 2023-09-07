library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Add_Imm is
  port ( clk, rst: in std_logic;
    PC, Imm: in std_logic_vector(15 downto 0);
    C: out std_logic_vector(15 downto 0));
end entity;

architecture Behavioral of Add_Imm is
signal temp1: std_logic_vector(16 downto 0) := "00000000000000000";



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
   return carry (16) & sum ;
	end add;


begin
process(rst, PC, Imm, temp1)
begin
		if (rst = '1') then
		C <= PC;
		else
		temp1 <= add(PC,Imm(14 downto 0) & '0','0');
		C <= temp1(15 downto 0);
		end if;
		end process;

	
--  C <= std_logic_vector(to_integer(unsigned(PC)) + to_integer(2*unsigned(Imm)));  
end Behavioral;