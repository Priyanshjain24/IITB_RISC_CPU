library std;
library ieee;
use ieee.std_logic_1164.all;

entity reg_1 is
port(
  clk, rst, wr: in std_logic;
  Din: in std_logic;
  Dout: out std_logic);
end entity;

architecture reg1 of reg_1 is
  signal reg: std_logic:= '0';
begin
process(clk,rst,wr,reg)
  begin
 
      if(rst = '1') then
          reg <= '0';
			 Dout <= '0';

      else
        if(wr = '1' and rising_edge(clk)) then
          reg <= Din;
			 Dout <= Din; --added
        end if;
        
		end if;
		
		if(wr='0')then
		Dout <= reg;
		end if;
      
		
end process;

end reg1;