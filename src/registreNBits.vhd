LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY registreNBits IS 
	generic(N : positive :=8);
	Port (
		d : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
		en, ck, n_reset : IN STD_LOGIC;
		q : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0)
	);

END registreNBits;

ARCHITECTURE registreNBits_bhv OF registreNBits IS 
	COMPONENT basculeD IS
	PORT(
		d : IN STD_LOGIC;
		en, ck, n_reset  : IN STD_LOGIC;
		q : OUT STD_LOGIC
	);
	END COMPONENT;

	BEGIN 	
		cell_array : FOR i IN 0 TO N-1 GENERATE
			basculei : basculeD PORT MAP(d(i),en,ck,n_reset, q(i));
		
		END GENERATE cell_array;


END registreNBits_bhv; 