library std;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Data_Memory is
  port(
	 clk, wr, rst : in std_logic;
    D_in: in std_logic_vector(15 downto 0);
    Ar, Aw: in std_logic_vector(15 downto 0);
	 Dout_1, Dout_2: out std_logic_vector(7 downto 0));
end entity;

architecture mem of Data_Memory is
  type mem is array(0 to 255) of std_logic_vector(7 downto 0);
  signal RAM: mem:= ("00000000", "00000000", "00000000", "00000000", others => "00000000");

begin

	process(clk,rst,wr,RAM,Ar)
		begin
	
			if(rst = '1') then
			  for i in 255 to 0 loop
				 RAM(i) <= "00000000";
			  end loop;
			end if;

			if(wr = '1' and falling_edge(clk)) then
				 RAM(to_integer(unsigned(Aw))) <= D_in(15 downto 8);
				 RAM(to_integer(unsigned(Aw))+1) <= D_in(7 downto 0);
			end if;
		
		Dout_1 <= RAM(to_integer(unsigned(Ar)));
		Dout_2 <= RAM(to_integer(unsigned(Ar))+1);
		
		end process;
end mem;