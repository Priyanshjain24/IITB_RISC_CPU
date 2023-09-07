library std;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Stage_4 is
	port( clk, rst: in std_logic;
	P3_O: in std_logic_vector(72 downto 0);
	P4_I: out std_logic_vector(50 downto 0);
	RF_EX: out std_logic_vector(2 downto 0);
	D_EX: out std_logic_vector(15 downto 0);
	w_EX, disable: out std_logic);
end entity;

architecture path_4 of Stage_4 is

----------------------------------------------------Components-----------------------------------------------------

component decider is
	port(W_RF: in std_logic;
	decide: in std_logic_vector(1 downto 0);
	C, Z: in std_logic; -- from alu
	RF_w: out std_logic);
end component;

component alu is
	port(
		A,B: in std_logic_vector(15 downto 0);
		C_in: in std_logic;
      car: in std_logic;
		op: in std_logic_vector(2 downto 0);
		output: out std_logic_vector(15 downto 0);
		C,Z: out std_logic) ;
end component;

component reg_1 is
    port(
      clk, rst, wr: in std_logic;
      Din: in std_logic;
      Dout: out std_logic);
    end component;

-------------------------------------------------------Signals----------------------------------------------------

signal instruction, ALU_a, ALU_b, ALU_C: std_logic_vector(15 downto 0);
signal decide: std_logic_vector(1 downto 0); 
signal Z_w, C_w, car, W_RF, RF_w, C_o, Z_o, C_flag, Z_flag: std_logic;
signal ALU_cs, A1, A2: std_logic_vector(2 downto 0);
signal op: std_logic_vector(3 downto 0);

-------------------------------------------------------Datapath---------------------------------------------------
begin

decider1: decider port map(W_RF, decide, C_o, Z_o, RF_w);
ALU1: alu port map (ALU_a, ALU_b, C_flag, car, ALU_cs, ALU_C, C_o, Z_o);
C: reg_1 port map (clk, rst, C_w, C_o, C_flag);
Z: reg_1 port map (clk, rst, Z_w, Z_o, Z_flag);

--------------------------------------------------Extra Connections-----------------------------------------------

W_RF <= P3_O(4);
ALU_cs <= P3_o (2 downto 0);
car <= P3_o (3);
decide <= P3_o (8 downto 7);
C_w <= P3_o (5);
Z_w <= P3_o (6);
ALU_a <= P3_O(43 downto 28);
ALU_b <= P3_O(27 downto 12);
op <= P3_O(66 downto 63);
A1 <= P3_O(72 downto 70);
A2 <= P3_O(69 downto 67);

RF_EX <= P3_O(11 downto 9);
D_EX <= ALU_c;
w_EX <= RF_w;


P4_I <= "00000" & A1 & op & P3_O(62 downto 44) & ALU_C & P3_O(11 downto 9) & RF_w;

-- for branch, sets value of disable bit
process (op, C_o, Z_o)
begin

	if (op = "1000" and Z_o = '0') then
		disable <= '1';
	elsif (op = "1001" and C_o = '1') then
		disable <= '1';
	elsif (op = "1010" and (Z_o = '1' or C_o = '1') ) then
		disable <= '1';
	else
		disable <= '0';
	end if;
	
end process;
-- disable is passed to controller (stage 2) and to stage 3 to make all writes = '0'



------------------------------------------------------------------------------------------------------------------

end architecture;

