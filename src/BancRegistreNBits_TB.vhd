LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY BancRegistreNBits_TB IS
	
END BancRegistreNBits_TB;

ARCHITECTURE BancRegistreNBits_TB_bhv OF BancRegistreNBits_TB Is

	COMPONENT BancRegistreNBits IS 
		generic(N : positive :=8);
		Port (
			d : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
			en, n_reset : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
			ck  : IN STD_LOGIC;
			q0, q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, q12, q13, q14, q15 : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0)
		);
	END COMPONENT;

	SIGNAL d : STD_LOGIC_VECTOR(16-1 DOWNTO 0);
	SIGNAL en, n_reset : STD_LOGIC_VECTOR(16-1 DOWNTO 0);
	SIGNAL ck  : STD_LOGIC;
	SIGNAL q0, q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, q12, q13, q14, q15 : STD_LOGIC_VECTOR(16-1 DOWNTO 0);
	
BEGIN
	
	Banc : BancRegistreNBits GENERIC MAP(16) PORT MAP(d, en, n_reset, ck, q0, q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, q12, q13, q14, q15 );
	
	first_test : process
			BEGIN 
				--La donnée
				d<="1111111111111111";
				en<="0000000000000001";
				
				n_reset<="0000000000000000";
				
				ck<='1';
				wait for 20 ns;
				ck<='0';
				wait for 20 ns;
				ck<='1';
				wait for 20 ns;
				ck<='0';
				wait for 20 ns;
				ck<='1';
				wait for 20 ns;
				ck<='0';
				wait for 20 ns;
				
				--en<="----------------";
				ck<='1';
				wait for 20 ns;
				ck<='0';
				wait for 20 ns;
			
	end process first_test;
	

END BancRegistreNBits_TB_bhv;
