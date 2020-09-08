LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY FullAdder IS
	port( 
		x, y: IN STD_LOGIC; --Données entrantes 
		cin : IN STD_LOGIC;
		s : OUT STD_LOGIC; -- Sortie
		cout : OUT STD_LOGIC);
END FullAdder;

ARCHITECTURE FullAdder_bhv OF FullAdder Is
	BEGIN
	s <= x XOR y XOR cin;
	cout <= (x AND y) OR (cin AND (x XOR y));
END FullAdder_bhv;