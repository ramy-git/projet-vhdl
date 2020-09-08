LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY Decodeur IS
	PORT ( 
		c : IN STD_LOGIC_VECTOR(2 DOWNTO 0); --Données x entrantes
		s : OUT STD_LOGIC_VECTOR(6 DOWNTO 0));
END Decodeur;

ARCHITECTURE Decodeur_bhv OF Decodeur Is
	
	BEGIN 
		WITH c SELECT 	
			s<="0001001"  WHEN "000",
			"0000110" WHEN "001",
			"1000111" WHEN "010",
			"1000000" WHEN "011",
			"1111111" WHEN OTHERS;
END Decodeur_bhv;