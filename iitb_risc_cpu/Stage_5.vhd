library std;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Stage_5 is
	port( clk, rst, wr: in std_logic;
	Aw, Din: in std_logic_vector(15 downto 0);
	RF_WB: in std_logic_vector(2 downto 0);
	w_WB: in std_logic;
	op_6: in std_logic_vector(3 downto 0);
	P4_O: in std_logic_vector(50 downto 0);
	P5_I: out std_logic_vector(50 downto 0);
	RF_MA: out std_logic_vector(2 downto 0);
	D_MA: out std_logic_vector(15 downto 0);
	W_MA: out std_logic);
end entity;

architecture path_5 of Stage_5 is

----------------------------------------------------Components-----------------------------------------------------

component Data_Memory is
  port(
	 clk, wr, rst : in std_logic;
    D_in: in std_logic_vector(15 downto 0);
    Ar, Aw: in std_logic_vector(15 downto 0);
	 Dout_1, Dout_2: out std_logic_vector(7 downto 0));
end component;

component mux_four_to_one_16bit is
	port(A,B,C,D : in std_logic_vector(15 downto 0); 
	S : in std_logic_vector(1 downto 0);
	Z: out std_logic_vector(15 downto 0));
end component;

component mem_hazard is
	port(op, op_6: in std_logic_vector(3 downto 0);
	RF_MA, RF_WB : in std_logic_vector(2 downto 0);
	A_MA, A_WB: in std_logic_vector(15 downto 0);
	w_Mem, w_RF: in std_logic;
	X: out std_logic);
end component;

component mux_two_to_one_16bit is
	port(A,B: in std_logic_vector(15 downto 0); S: in std_logic; Z: out std_logic_vector(15 downto 0));
end component;

-------------------------------------------------------Signals----------------------------------------------------

signal X5 : std_logic_vector (1 downto 0);
signal Ar, LW, SW, D, Data: std_logic_vector(15 downto 0); --Ar, Norm same
signal D1, D2: std_logic_vector(7 downto 0);
signal zero: std_logic_vector(15 downto 0) := "0000000000000000";
signal op: std_logic_vector(3 downto 0);
signal X: std_logic;

-------------------------------------------------------Datapath---------------------------------------------------
begin

MUX1: mux_four_to_one_16bit port map (Ar, LW, SW, zero, X5, D);
Data_mem: Data_Memory port map(clk, wr, rst, Din, Ar, Aw, D1, D2);
hazard: mem_hazard port map (op, op_6, P4_O(45 downto 43) , RF_WB, Ar, Aw, wr, w_WB, X);
MUX2: mux_two_to_one_16bit port map (D, Din, X, Data);

--------------------------------------------------Extra Connections-----------------------------------------------

LW <= D1 & D2;

op <= P4_O(42 downto 39);
Ar <= P4_O(19 downto 4);
SW <= P4_O(36 downto 21);
X5 <= P4_O(38 downto 37);

w_MA <= P4_O(0);
D_MA <= Data ;
RF_MA <= P4_O(3 downto 1); 

P5_I <= "0000000000" & op & Ar & P4_O(20) & Data & P4_O(3 downto 0);

------------------------------------------------------------------------------------------------------------------

end architecture;
