library std;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg_hazard is
	port(
	RF_RR_1, RF_RR_2, RF_EX, RF_MA, RF_WB: in std_logic_vector(2 downto 0);
	w_EX, w_MA, w_WB: in std_logic;
	X_RF_A, X_RF_B: out std_logic_vector(1 downto 0));
end entity;

-- RR = Stage 3
-- EX = Stage 4
-- MA = Stage 5
-- WB = STage 6

architecture danger of reg_hazard is
begin
process(RF_RR_1, RF_RR_2, RF_EX, RF_MA, RF_WB, w_EX, w_MA, w_WB)
begin

--	if ((instruction(15 downto 12) = "0001") or (instruction(15 downto 12) = "0000") or (instruction(15 downto 12) = "0010")) then
		if (RF_RR_1 = RF_EX and w_EX = '1') then
			X_RF_A <= "01"; --Fast forwarding from Execution
		else 
			if (RF_RR_1 = RF_MA and w_MA = '1') then
				X_RF_A <= "10"; --Fast forwarding from Memory Access
			else 
				if (RF_RR_1 = RF_WB and w_WB = '1') then
					X_RF_A <= "11"; --Fast forwarding from Write back
				else
					X_RF_A <= "00"; --Normal Read
				end if;
			end if;
		end if;
--	else
--		X_RF_A <= "00"; --Normal Read
--	end if;
		
--	if ((instruction(15 downto 12) = "0001") or (instruction(15 downto 12) = "0010")) then
		if (RF_RR_2 = RF_EX and w_EX = '1') then
			X_RF_B <= "01"; --Fast forwarding from Execution
		else 
			if (RF_RR_2 = RF_MA and w_MA = '1') then
				X_RF_B <= "10"; --Fast forwarding from Memory Access
			else 
				if (RF_RR_2 = RF_MA and w_WB = '1') then
					X_RF_B <= "11"; --Fast forwarding from Write back
				else
					X_RF_B <= "00"; --Normal Read
				end if;
			end if;
		end if;
--	else
--		X_RF_B <= "00"; --Normal Read
--	end if;
	
end process;
end architecture;