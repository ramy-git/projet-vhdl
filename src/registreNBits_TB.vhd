LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY registreNBits_TB IS 

END registreNBits_TB;

ARCHITECTURE registreNBits_TB_bhv OF registreNBits_TB IS 
	COMPONENT registreNBits IS 
		generic(N : positive :=8);
		Port (
			d : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
			en, ck, n_reset : IN STD_LOGIC;
			q : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0)
		);

	END COMPONENT;

	SIGNAL d : STD_LOGIC_VECTOR(16-1 DOWNTO 0);
	SIGNAL en, ck, n_reset : STD_LOGIC;
	SIGNAL q : STD_LOGIC_VECTOR(16-1 DOWNTO 0);
	
BEGIN 	

	BancRegistre : registreNBits GENERIC MAP(16) PORT MAP(d,en,ck,n_reset,q);

	first_test : process
			BEGIN 
			d<="1111111111111111";
			
			ck<='1';
			wait for 20 ns;
			
			ck<='0';
			wait for 20 ns;			
			
			en<='1';
			
			ck<='1';
			wait for 20 ns;
			
			ck<='0';
			wait for 20 ns;

			en<='0';
			
			ck<='1';
			wait for 20 ns;
			
			ck<='0';
			wait for 20 ns;
			
			ck<='1';
			wait for 20 ns;
			
			ck<='0';
			wait for 20 ns;
			
			n_reset<='1';
			
			ck<='1';
			wait for 20 ns;
			
			ck<='0';
			wait for 20 ns;
			
			n_reset<='0';
		
			end process first_test;


END registreNBits_TB_bhv; 