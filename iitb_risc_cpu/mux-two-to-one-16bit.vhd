library ieee;
use ieee.std_logic_1164.all;
 
entity mux_two_to_one_16bit is
	port(A,B: in std_logic_vector(15 downto 0); S: in std_logic; Z: out std_logic_vector(15 downto 0));
end mux_two_to_one_16bit;
 
architecture Struct of mux_two_to_one_16bit is
begin

	process(A,B,S) is
	begin
	  if (S ='0') then Z <= A;
	  else Z <= B;
	  end if; 
	end process;

end Struct;