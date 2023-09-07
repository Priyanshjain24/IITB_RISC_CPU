library std;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Controller is
	port(instruction: in std_logic_vector(15 downto 0);
	rst, disable: in std_logic;
	decide: out std_logic_vector(1 downto 0);
	Z_w, C_w, car, RF_w, Mem_w: out std_logic; --added then removed default value
	ALU_cs: out std_logic_vector(2 downto 0));
end entity;

architecture con of Controller is
signal op: std_logic_vector(3 downto 0);
signal comp: std_logic;
signal cz: std_logic_vector(1 downto 0);

begin
op <= instruction(15 downto 12);
comp <= instruction(2);
cz <= instruction(1 downto 0);

process(instruction,op,comp,cz,rst,disable)
begin
if (rst ='1' or disable = '1') then
	Z_w <= '0';
	C_w <= '0';
	RF_w <= '0';
	Mem_w <= '0';
	car <= '0';
	decide <= "11";
	ALU_cs <= "000";
else
 if (op = "0001") then
	Z_w <= '1';
	C_w <= '1';
	RF_w <= '1';
	Mem_w <= '0';
	
	if (cz = "11") then
		car <= '1';
	else
		car <= '0';
	end if; 
	
	if (comp = '0') then
		ALU_cs <= "000";
	else
		ALU_cs <= "001";
	end if;
	
	if (cz = "01") then
	 decide <= "00";
	elsif (cz = "10") then
	 decide <= "01";
	else
	 decide <= "11";
	end if;
	
 elsif (op = "0010") then
	Z_w <= '1';
	C_w <= '0';
	RF_w <= '1';
	Mem_w <= '0';
	
	if (cz = "11") then
		car <= '1';
	else
		car <= '0';
	end if; 
	
	if (comp = '0') then
		ALU_cs <= "010";
	else
		ALU_cs <= "011";
	end if;
	
 	if (cz = "01") then
	 decide <= "00";
	elsif (cz = "10") then
	 decide <= "01";
	else
	 decide <= "11";
	end if;
	
 elsif (op = "0000") then
	Z_w <= '1';
	C_w <= '1';	
	car <= '0';	
	ALU_cs <= "000";
	RF_w <= '1';
	Mem_w <= '0';
	decide <= "11";
	
 elsif (op = "0011" or op = "0100" or op = "0101") then
	Z_w <= '0';
	C_w <= '0';	
	car <= '0';	
	ALU_cs <= "000";
	decide <= "11";
	
	if (op = "0101") then
		RF_w <= '0';
		Mem_w <= '1';
	else
		RF_w <= '1';
		Mem_w <= '0';
	
	end if;
	
 elsif (op = "1000" or op = "1001" or op = "1010") then
	Z_w <= '0';
	C_w <= '0';
	car <= '0';
	ALU_cs <= "100";
	RF_w <= '0';
	Mem_w <= '0';
	decide <= "11";
	
	
 else NULL;
 end if;
 end if;
end process;

end architecture;
