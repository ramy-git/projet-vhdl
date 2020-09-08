LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY multiplex_2_1 IS
	port( 
		x, y, s : IN STD_LOGIC; --Données entrantes 
		m : OUT STD_LOGIC); -- Sortie
END multiplex_2_1;

ARCHITECTURE multiplex_2_1_bhv OF multiplex_2_1 Is
	BEGIN
	m <= (NOT (s) AND x) OR (s AND y);
END multiplex_2_1_bhv;
