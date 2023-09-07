library std;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Register_File is
  port(
    clk, rst, wr: in std_logic;
    A1,A2,Aw: in std_logic_vector(2 downto 0);
	 Din, PC_i: in std_logic_vector(15 downto 0);
    Dout1, Dout2, PC_o: out std_logic_vector(15 downto 0));
end entity;

architecture arch of Register_File is
  type registers is array(0 to 7) of std_logic_vector(15 downto 0);
  signal RF: registers:= ("0000000000000000","0000000000000001", "0000000000000010", "0000000000000000", "1000000000000000", "0000000000000000", "0000000000000000", "0000000000000001");

begin
PC_o <= RF(0);
process(clk,rst,RF,A1,A2)
  begin
      if(rst = '1') then
        for i in 7 to 0 loop
          RF(i) <= "00000000000000000";
			end loop;
		else	
	
	if (falling_edge(clk)) then
		
		RF(0) <= PC_i;
		
      if(wr = '1') then
			
         RF(to_integer(unsigned(Aw))) <= Din;
		end if;
	end if;
	end if;

		Dout1 <= RF(to_integer(unsigned(A1)));
      Dout2 <= RF(to_integer(unsigned(A2)));
		
end process;
end arch;
