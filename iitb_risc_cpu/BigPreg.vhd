library std;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity Big_Pipe_reg is
port(
  clk, rst, wr: in std_logic;
  Din: in std_logic_vector(72 downto 0);
  Dout: out std_logic_vector(72 downto 0));
end entity;

architecture reg1 of Big_Pipe_reg is
  signal reg: std_logic_vector(72 downto 0);
begin
process(clk,rst,wr,reg)
  begin
    
      if(rst = '1') then
          reg <= "0000000000000000000000000000000000000000000000000000000000000000000000000";
			 Dout <= "0000000000000000000000000000000000000000000000000000000000000000000000000";

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