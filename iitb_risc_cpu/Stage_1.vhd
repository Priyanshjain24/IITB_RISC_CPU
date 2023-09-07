library std;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Stage_1 is
	port( clk, rst, disable: in std_logic;
	RF_A1, RF_A2, RF_A_W : in std_logic_vector (2 downto 0);
	RF_D_IN: in std_logic_vector(15 downto 0);
	RF_w: in std_logic;
	RF_O1, RF_O2 : out std_logic_vector(15 downto 0);
	P1_I: out std_logic_vector(50 downto 0));
end entity;

architecture path_1 of Stage_1 is

----------------------------------------------------Components-----------------------------------------------------

component Instruction_Memory is
  port(
    PC: in std_logic_vector(15 downto 0);
    O1: out std_logic_vector(7 downto 0);
	 O2: out std_logic_vector(7 downto 0));
end component;

component Register_File is
  port(
    clk, rst, wr: in std_logic;
    A1,A2,Aw: in std_logic_vector(2 downto 0);
	 Din, PC_i: in std_logic_vector(15 downto 0);
    Dout1, Dout2, PC_o: out std_logic_vector(15 downto 0));
end component;

component Temp_reg is
	port(
	  clk, rst, wr: in std_logic;
	  Din: in std_logic_vector(15 downto 0);
	  Dout: out std_logic_vector(15 downto 0));
end component;

component Pipe_reg is
	port(
	  clk, rst, wr: in std_logic;
	  Din: in std_logic_vector(50 downto 0);
	  Dout: out std_logic_vector(50 downto 0));
end component;

component six_extender is
  port (A: in std_logic_vector(5 downto 0); B: out std_logic_vector(15 downto 0));
end component;

component Adder is
  port (
    A: in std_logic_vector(15 downto 0);   
    C: out std_logic_vector(15 downto 0));
end component;

component Add_Imm is
  port ( clk, rst: in std_logic;
    PC, Imm: in std_logic_vector(15 downto 0);
    C: out std_logic_vector(15 downto 0));
end component;

component mux_two_to_one_1bit is
	port(A,B,S: in std_logic; Z: out std_logic);
end component;

component mux_two_to_one_16bit is
	port(A,B: in std_logic_vector(15 downto 0); S: in std_logic; Z: out std_logic_vector(15 downto 0));
end component;

component mux_four_to_one_1bit is
	port(A,B,C,D : in std_logic; 
	S : in std_logic_vector(1 downto 0);
	Z: out std_logic);
end component;

component mux_four_to_one_16bit is
	port(A,B,C,D : in std_logic_vector(15 downto 0); 
	S : in std_logic_vector(1 downto 0);
	Z: out std_logic_vector(15 downto 0));
end component;

-------------------------------------------------------Signals----------------------------------------------------

signal PC_I, PC_O, PC_T_O, PC_d: std_logic_vector(15 downto 0):= "0000000000000000";
signal IS_H, IS_L: std_logic_vector(7 downto 0);
signal Imm: std_logic_vector(5 downto 0);
signal op : std_logic_vector (3 downto 0);
signal INST, Imm_ext, INC: std_logic_vector(15 downto 0);
signal X_PC: std_logic;
signal one: std_logic_vector(15 downto 0) := "0000000000000001";

-------------------------------------------------------Datapath---------------------------------------------------
begin
RF: Register_File port map (clk, rst, RF_w, RF_A1, RF_A2, RF_A_W, RF_D_IN, PC_I, RF_O1, RF_O2, PC_O);
IM: Instruction_Memory port map (PC_O, IS_H, IS_L);
ADD: Add_Imm port map (clk, rst, PC_O, INC, PC_d);	
EX: six_extender port map (Imm, Imm_ext);		--changed to 6 extender for branch (1000 1001 1010)
MUX_PC_ADD: mux_two_to_one_16bit port map (one, Imm_ext, X_PC, INC);
PC_T: Temp_reg port map (clk, rst, X_PC, PC_O, PC_T_O);
MUX_Branch: mux_two_to_one_16bit port map (PC_d, PC_T_O, disable, PC_I);

--------------------------------------------------Extra Connections-----------------------------------------------

INST <= IS_H & IS_L;
Imm <= INST(5 downto 0); 
op <= INST(15 downto 12);
-- X_PC <= not(INST(12) and not(INST(13)) and INST(14) and INST(15);  starting JAL
X_PC <= op(3) and not(op(2)) and (op(1) nand op(0));
P1_I <= "00000000000000000000000000000000000"&INST;

------------------------------------------------------------------------------------------------------------------

end architecture;

