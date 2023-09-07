library std;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mem_hazard is
	port(op, op_6: in std_logic_vector(3 downto 0);
	RF_MA, RF_WB : in std_logic_vector(2 downto 0);
	A_MA, A_WB: in std_logic_vector(15 downto 0);
	w_Mem, w_RF: in std_logic;
	X: out std_logic);
end entity;

architecture danger of mem_hazard is
begin
process(op, A_MA, A_WB, w_Mem, RF_MA, RF_WB, w_RF)
begin
	
	if(op = "0100" and op_6 = "0101" and A_MA = A_WB and w_Mem = '1') then
		X <= '1';
	else
		X <= '0';
	end if;
	
	if(op = "0101" and op_6 = "0100" and RF_MA = RF_WB and w_RF = '1') then
		X <= '1';
	else
		X <= '0';
	end if;

end process;
end architecture;