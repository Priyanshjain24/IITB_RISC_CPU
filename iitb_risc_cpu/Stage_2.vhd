library std;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Stage_2 is
	port( clk, rst, disable: in std_logic;
	P1_O: in std_logic_vector(50 downto 0);
	P2_I: out std_logic_vector(50 downto 0));
end entity;

architecture path_2 of Stage_2 is

----------------------------------------------------Components-----------------------------------------------------

component Controller is
	port(instruction: in std_logic_vector(15 downto 0);
	rst, disable: in std_logic;
	decide: out std_logic_vector(1 downto 0);
	Z_w, C_w, car, RF_w, Mem_w: out std_logic;
	ALU_cs: out std_logic_vector(2 downto 0));
end component;
	
-------------------------------------------------------Signals----------------------------------------------------

signal instruction: std_logic_vector(15 downto 0);
signal decide: std_logic_vector(1 downto 0); 
signal Z_w, C_w, car, RF_w, Mem_w: std_logic;
signal ALU_cs: std_logic_vector(2 downto 0);

-------------------------------------------------------Datapath---------------------------------------------------
begin 
Cont: Controller port map (instruction, rst, disable, decide, Z_w, C_w, car, RF_w, Mem_w, ALU_cs);

--------------------------------------------------Extra Connections-----------------------------------------------

instruction <= P1_O(15 downto 0);
P2_I <= "0000000000000000000000000"& Mem_w & instruction & decide & Z_w & C_w & RF_w & car & ALU_cs;

------------------------------------------------------------------------------------------------------------------

end architecture;

