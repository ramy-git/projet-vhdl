LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY And_nbits IS
	generic(N : positive := 8);
	port(
		a : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
		b : IN STD_LOGIC;
		s : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0)
	);
END And_nbits;

ARCHITECTURE And_nbits_bhv OF And_nbits Is
	BEGIN
	cell_array : FOR i IN 0 TO N-1 GENERATE
		s(i) <= a(i) AND b;
	END GENERATE;
	
END And_nbits_bhv;