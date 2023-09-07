library std;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity decider is
	port(W_RF: in std_logic;
	decide: in std_logic_vector(1 downto 0);
	C, Z: in std_logic; -- from alu
	RF_w: out std_logic);
end entity;

architecture dec of decider is
begin
process(W_RF, decide, C, Z)
begin
	if (decide = "00") then
		RF_w <= W_RF and Z;
	elsif (decide = "01") then
		RF_w <= W_RF and C;
	else
		RF_w <= W_RF;
	end if;
end process;
end architecture;
