LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY FA_TB IS

END FA_TB;

ARCHITECTURE FA_TB_bhv OF FA_TB Is

	COMPONENT FullAdder IS
	port( 
		x, y: IN STD_LOGIC; --Données entrantes 
		cin : IN STD_LOGIC;
		s : OUT STD_LOGIC; -- Sortie
		cout : OUT STD_LOGIC);
	END COMPONENT;

	SIGNAL x, y, cin, s, cout : STD_LOGIC;
	
	BEGIN		
	
	full1 : FullAdder PORT MAP (x,y,cin,s,cout);
	
	--Pour faire fonctionner le test, il suffit d'indiquer des valeurs à la FSM
	--via les cables imput uniquement
	first_test : process
			BEGIN 
				x<='1';
				y<='1';
				cin<='0';
				wait for 20 ns;
	
				x<='0';
				y<='1';
				cin<='0';
				wait for 20 ns;	
				
			
	end process first_test;
	

END FA_TB_bhv;
