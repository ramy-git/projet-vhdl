LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY decodeurChiffe_16Bits IS 
	port(
	binaire : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
	sortie : OUT STD_LOGIC_VECTOR(27 DOWNTO 0)
	);
END decodeurChiffe_16Bits;

ARCHITECTURE decodeurChiffe_16Bits_bhv OF decodeurChiffe_16Bits IS 
	COMPONENT DecodeurChiffre IS
		PORT ( 
			c : IN STD_LOGIC_VECTOR(3 DOWNTO 0); --Données x entrantes
			s : OUT STD_LOGIC_VECTOR(6 DOWNTO 0));
	END COMPONENT;
	
	SIGNAL unite : STD_LOGIC_VECTOR(6 DOWNTO 0);
	SIGNAL dizaine : STD_LOGIC_VECTOR(6 DOWNTO 0);
	SIGNAL centaine : STD_LOGIC_VECTOR(6 DOWNTO 0);
	SIGNAL millier : STD_LOGIC_VECTOR(6 DOWNTO 0);
	
	BEGIN
		decodeur1 : DecodeurChiffre PORT MAP(
			binaire(3 DOWNTO 0),sortie(6 DOWNTO 0)
		);
		decodeur2 : DecodeurChiffre PORT MAP(
			binaire(7 DOWNTO 4),sortie(13 DOWNTO 7)
		);
		decodeur3 : DecodeurChiffre PORT MAP(
			binaire(11 DOWNTO 8),sortie(20 DOWNTO 14)
		);
		decodeur4 : DecodeurChiffre PORT MAP(
			binaire(15 DOWNTO 12),sortie(27 DOWNTO 21)
		);

END decodeurChiffe_16Bits_bhv; 