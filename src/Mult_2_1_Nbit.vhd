LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY Mult_2_1_Nbit IS
	GENERIC(N : POSITIVE :=8);
	PORT ( 
		a0, a1 : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
		sel : IN STD_LOGIC;
		s : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0)

	);
END Mult_2_1_Nbit;

ARCHITECTURE Mult_2_1_Nbit_bhv OF Mult_2_1_Nbit Is

	COMPONENT multiplex_2_1 IS
		port( 
			x, y, s : IN STD_LOGIC; --Données entrantes 
			m : OUT STD_LOGIC); -- Sortie
	END COMPONENT;
	
	BEGIN
		cell_array : FOR i IN 0 TO N-1 GENERATE
			mux_i : multiplex_2_1 PORT MAP( a0(i),a1(i),sel,s(i));
		END GENERATE;

END Mult_2_1_Nbit_bhv;