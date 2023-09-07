library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity extender is
  port (A: in std_logic_vector(8 downto 0); B: out std_logic_vector(15 downto 0));
end entity extender;

architecture Struct of extender is
begin
	
	process(A)
	begin
	B <= "0000000" & A;
	end process;
	
end Struct;