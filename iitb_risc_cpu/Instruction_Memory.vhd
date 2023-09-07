library std;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Instruction_Memory is
  port(
    PC: in std_logic_vector(15 downto 0);
    O1: out std_logic_vector(7 downto 0);
	 O2: out std_logic_vector(7 downto 0));
end entity;

architecture mem of Instruction_Memory is
  type mem is array(0 to 255) of std_logic_vector(7 downto 0);
  signal RAM: mem:= ("01000100", "01000001", "01010100", "01000011", others => "11100000");

begin
	O1 <= RAM(to_integer(unsigned(PC)));
	O2 <= RAM(1+to_integer(unsigned(PC)));
end mem;
