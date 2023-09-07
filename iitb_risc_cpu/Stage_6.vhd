library std;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Stage_6 is
	port( clk, rst: in std_logic;
	P5_O: in std_logic_vector(50 downto 0);
	Data, Mem_A: out std_logic_vector(15 downto 0);
    RF_A: out std_logic_vector(2 downto 0);
    RF_w, Mem_w: out std_logic;
	 op_6: out std_logic_vector(3 downto 0));
end entity;

architecture path_6 of Stage_6 is
begin

--------------------------------------------------Connections-----------------------------------------------------
op_6 <= P5_o(40 downto 37);

Data <= P5_O(19 downto 4);

Mem_A <= P5_O(36 downto 21);
RF_A <= P5_O(3 downto 1);

Mem_w <= P5_O(20);
RF_w <= P5_O(0);

------------------------------------------------------------------------------------------------------------------

end architecture;

