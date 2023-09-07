library std;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Datapath is
port(inp: in std_logic; outp: out std_logic);
end entity;

architecture path of Datapath is

----------------------------------------------------Components-----------------------------------------------------

component Stage_1 is
	port( clk, rst, disable: in std_logic;
	RF_A1, RF_A2, RF_A_W : in std_logic_vector (2 downto 0);
	RF_D_IN: in std_logic_vector(15 downto 0);
	RF_w: in std_logic;
	RF_O1, RF_O2 : out std_logic_vector(15 downto 0);
	P1_I: out std_logic_vector(50 downto 0));
end component;

component Stage_2 is
	port( clk, rst, disable: in std_logic;
	P1_O: in std_logic_vector(50 downto 0);
	P2_I: out std_logic_vector(50 downto 0));
end component;

component Stage_3 is
	port( clk, rst, disable: in std_logic;
	RF_A1, RF_A2: out std_logic_vector(2 downto 0);
	RF_EX, RF_MA, RF_WB: in std_logic_vector(2 downto 0);
	RF_D1, RF_D2, D_EX, D_MA, D_WB: in std_logic_vector(15 downto 0);
	w_EX, w_MA, w_WB: in std_logic;
	P2_O: in std_logic_vector(50 downto 0);
	P3_I: out std_logic_vector(72 downto 0));
end component;

component Stage_4 is
	port( clk, rst: in std_logic;
	P3_O: in std_logic_vector(72 downto 0);
	P4_I: out std_logic_vector(50 downto 0);
	RF_EX: out std_logic_vector(2 downto 0);
	D_EX: out std_logic_vector(15 downto 0);
	w_EX, disable: out std_logic);
end component;

component Stage_5 is
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
end component;

component Stage_6 is
	port( clk, rst: in std_logic;
	P5_O: in std_logic_vector(50 downto 0);
	Data, Mem_A: out std_logic_vector(15 downto 0);
    RF_A: out std_logic_vector(2 downto 0);
    RF_w, Mem_w: out std_logic;
	 op_6: out std_logic_vector (3 downto 0));
end component;

component Pipe_reg is
	port(
	  clk, rst, wr: in std_logic;
	  Din: in std_logic_vector(50 downto 0);
	  Dout: out std_logic_vector(50 downto 0));
	end component;
	
component Big_Pipe_reg is
	port(
	  clk, rst, wr: in std_logic;
	  Din: in std_logic_vector(72 downto 0);
	  Dout: out std_logic_vector(72 downto 0));
	end component;

component clock_generator is
	port (clk_out, rst : out std_logic);
end component;

-------------------------------------------------------------------------------------------------------------------

signal clk, rst, RF_w, wr, Mem_w, disable, w_EX, w_MA: std_logic;
signal P1_I, P1_O, P2_I, P2_O, P4_I, P4_O, P5_I, P5_O: std_logic_vector(50 downto 0);
signal P3_I, P3_O: std_logic_vector(72 downto 0);
signal RF_A1, RF_A2, RF_A_W, RF_EX, RF_MA: std_logic_vector(2 downto 0);
signal RF_D_IN, RF_O1, RF_O2, Aw, Data, D_EX, D_MA: std_logic_vector(15 downto 0);
signal op_6: std_logic_vector(3 downto 0);

-------------------------------------------------------------------------------------------------------------------
begin
clock: clock_generator port map (clk, rst);

S1: Stage_1 port map (clk, rst, disable, RF_A1, RF_A2, RF_A_W, Data, RF_w, RF_O1, RF_O2, P1_I);
P1: Pipe_reg port map (clk, rst, wr, P1_I, P1_O);

S2: Stage_2 port map (clk, rst, disable, P1_O, P2_I);
P2: Pipe_reg port map (clk, rst, wr, P2_I, P2_O);

S3: Stage_3 port map (clk, rst, disable, RF_A1, RF_A2, RF_EX, RF_MA, RF_A_W, RF_O1, RF_O2, D_EX, D_MA, Data, w_EX, w_MA, RF_w, P2_O, P3_I);
P3: Big_Pipe_reg port map (clk, rst, wr, P3_I, P3_O);

S4: Stage_4 port map (clk, rst, P3_O, P4_I, RF_EX, D_EX, w_EX, disable);
P4: Pipe_reg port map (clk, rst, wr, P4_I, P4_O);

S5: Stage_5 port map (clk, rst, Mem_w, Aw, Data, RF_A_W, RF_w, op_6, P4_O, P5_I, RF_MA, D_MA, w_MA);
P5: Pipe_reg port map (clk, rst, wr, P5_I, P5_O);

S6: Stage_6 port map (clk, rst, P5_O, Data, Aw, RF_A_W, RF_w, Mem_w, op_6);

-------------------------------------------------------------------------------------------------------------------

wr <= '1';
end architecture;