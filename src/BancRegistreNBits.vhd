LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY BancRegistreNBits IS 
	generic(N : positive :=8);
	Port (
		d : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
		en, n_reset : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
		ck  : IN STD_LOGIC;
		q0, q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, q12, q13, q14, q15 : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0)
	);

END BancRegistreNBits;

ARCHITECTURE BancRegistreNBits_bhv OF BancRegistreNBits IS 
	COMPONENT registreNBits IS 
		generic(N : positive :=8);
		Port (
			d : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
			en, ck, n_reset : IN STD_LOGIC;
			q : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0)
		);
	END COMPONENT;

	BEGIN 	
		
	registre0 : registreNBits GENERIC MAP(16) PORT MAP(d, en(0), ck, n_reset(0), q0); 
	registre1 : registreNBits GENERIC MAP(16) PORT MAP(d, en(1), ck, n_reset(1), q1); 
	registre2 : registreNBits GENERIC MAP(16) PORT MAP(d, en(2), ck, n_reset(2), q2); 
	registre3 : registreNBits GENERIC MAP(16) PORT MAP(d, en(3), ck, n_reset(3), q3); 
	registre4 : registreNBits GENERIC MAP(16) PORT MAP(d, en(4), ck, n_reset(4), q4); 
	registre5 : registreNBits GENERIC MAP(16) PORT MAP(d, en(5), ck, n_reset(5), q5); 
	registre6 : registreNBits GENERIC MAP(16) PORT MAP(d, en(6), ck, n_reset(6), q6); 
	registre7 : registreNBits GENERIC MAP(16) PORT MAP(d, en(7), ck, n_reset(7), q7); 
	registre8 : registreNBits GENERIC MAP(16) PORT MAP(d, en(8), ck, n_reset(8), q8); 
	registre9 : registreNBits GENERIC MAP(16) PORT MAP(d, en(9), ck, n_reset(9), q9); 
	registre10 : registreNBits GENERIC MAP(16) PORT MAP(d, en(10), ck, n_reset(10), q10); 
	registre11 : registreNBits GENERIC MAP(16) PORT MAP(d, en(11), ck, n_reset(11), q11); 
	registre12 : registreNBits GENERIC MAP(16) PORT MAP(d, en(12), ck, n_reset(12), q12); 
	registre13 : registreNBits GENERIC MAP(16) PORT MAP(d, en(13), ck, n_reset(13), q13); 
	registre14 : registreNBits GENERIC MAP(16) PORT MAP(d, en(14), ck, n_reset(14), q14); 
	registre15 : registreNBits GENERIC MAP(16) PORT MAP(d, en(15), ck, n_reset(15), q15); 
	
	


END BancRegistreNBits_bhv; 