library std;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Stage_3 is
	port( clk, rst, disable: in std_logic;
	RF_A1, RF_A2: out std_logic_vector(2 downto 0);
	RF_EX, RF_MA, RF_WB: in std_logic_vector(2 downto 0);
	RF_D1, RF_D2, D_EX, D_MA, D_WB: in std_logic_vector(15 downto 0);
	w_EX, w_MA, w_WB: in std_logic;
	P2_O: in std_logic_vector(50 downto 0);
	P3_I: out std_logic_vector(72 downto 0));
end entity;

architecture path_3 of Stage_3 is

----------------------------------------------------Components-----------------------------------------------------

component six_extender is
  port (A: in std_logic_vector(5 downto 0); B: out std_logic_vector(15 downto 0));
end component;

component extender is
  port (A: in std_logic_vector(8 downto 0); B: out std_logic_vector(15 downto 0));
end component;

component mux_two_to_one_16bit is
	port(A,B : in std_logic_vector(15 downto 0); 
	S : in std_logic;
	Z: out std_logic_vector(15 downto 0));
end component;

component mux_four_to_one_16bit is
	port(A,B,C,D : in std_logic_vector(15 downto 0); 
	S : in std_logic_vector(1 downto 0);
	Z: out std_logic_vector(15 downto 0));
end component;

component mux_four_to_one_3bit is
	port(A,B,C,D : in std_logic_vector(2 downto 0); 
	S : in std_logic_vector(1 downto 0);
	Z: out std_logic_vector(2 downto 0));
end component;

component reg_hazard is
	port(
	RF_RR_1, RF_RR_2, RF_EX, RF_MA, RF_WB: in std_logic_vector(2 downto 0);
	w_EX, w_MA, w_WB: in std_logic;
	X_RF_A, X_RF_B: out std_logic_vector(1 downto 0));
end component;

-------------------------------------------------------Signals----------------------------------------------------

signal instruction, ALU_a, ALU_b: std_logic_vector(15 downto 0);
signal A1, A2, A3, RF_A3: std_logic_vector(2 downto 0);
signal imm_se, imm_e, D1, D2: std_logic_vector(15 downto 0);
signal im_6: std_logic_vector(5 downto 0);
signal im_9: std_logic_vector(8 downto 0);
signal zero: std_logic_vector(15 downto 0) := "0000000000000000";
signal X1, X2, X3, X5, XA, XB: std_logic_vector(1 downto 0);
signal op: std_logic_vector(3 downto 0);
signal Mem_w, Z_w, C_w, RF_w: std_logic;

-------------------------------------------------------Datapath---------------------------------------------------
begin
signed_6: six_extender port map (im_6, Imm_se);
extend: extender port map (im_9, imm_e);
hazard: reg_hazard port map (A1, A2, RF_EX, RF_MA, RF_WB, w_EX, w_MA, w_WB, XA, XB);
MUX_1: mux_four_to_one_16bit port map (D1, Imm_se, Imm_e, zero, X1, ALU_a);
MUX_2: mux_four_to_one_16bit port map (D2, Imm_se, Imm_e, zero, X2, ALU_b);
MUX_3: mux_four_to_one_3bit port map (A3, A1, A2, "000", X3, RF_A3);
MUX_A: mux_four_to_one_16bit port map (RF_D1, D_EX, D_MA, D_WB, XA, D1);
MUX_B: mux_four_to_one_16bit port map (RF_D2, D_EX, D_MA, D_WB, XB, D2);

--------------------------------------------------Extra Connections-----------------------------------------------

instruction <= P2_O(24 downto 9);
op <= instruction(15 downto 12);
A1 <= instruction(11 downto 9);
A2 <= instruction(8 downto 6);
A3 <= instruction(5 downto 3);
im_6 <= instruction(5 downto 0);
im_9 <= instruction (8 downto 0);
Mem_w <= P2_O(25) and not(disable);
Z_w <= P2_O(6) and not(disable);
C_w <= P2_O(5) and not(disable);
RF_w <= P2_O(4) and not(disable);

RF_A1 <= A1;
RF_A2 <= A2;

X1(1) <= op(1) and op(0);
X1(0) <= not(op(3)) and ( (op(1) and op(0)) or op(2) );

X2(1) <= not(op(3)) and not(op(2)) and op(1) and op(0);
X2(0) <= not(op(3)) and not(op(2)) and not(op(1)) and not(op(0));

X3(1) <= not(op(3) or op(2) or op(1) or op(0));
X3(0) <= not(op(3)) and (op(2) xor op(1)) and (op(1) xnor op(0));

X5(1) <= not(op(3)) and op(2) and not(op(1)) and op(0);
X5(0) <= not(op(3)) and op(2) and not(op(1)) and not(op(0));

P3_I <= A1 & A2 & op & X5 & RF_D1 & Mem_w & ALU_a & ALU_b & RF_A3 & P2_O (8 downto 7) & Z_w & C_w & RF_w & P2_O (3 downto 0);

-- check disable logic once, I've disabled all writes here if disable is 1

-- pass rf_dout1 separately for sw		
-- 0100, 0101, 0001, 0010: X2 <= 00
-- X5 can only take vals 00, 01, 10
--for add, nand RF_A3 <= instruction(5 downto 3); 0001 0010
--for lli, lw RF_A3 <= instruction(11 downto 9); 0011 0100
--for adi RF_A3 <= instruction(8 downto 6); 0000
-- no 11

------------------------------------------------------------------------------------------------------------------

end architecture;

