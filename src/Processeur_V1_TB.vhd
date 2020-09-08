LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY Processeur_V1_TB IS
	
END Processeur_V1_TB;

ARCHITECTURE Processeur_V1_TB_bhv OF Processeur_V1_TB Is
	COMPONENT Processeur_V1 IS
		GENERIC(N : POSITIVE :=16);
		port( 
			DIN : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
			Reset_n, Clock, Run : IN STD_LOGIC;
			Done, Erreur : OUT STD_LOGIC;
			BusWires : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
			StateOutput : OUT STD_LOGIC_VECTOR(8 DOWNTO 0); --Signaux d'indication de l'état courant
			AfficheurRegistre : OUT STD_LOGIC_VECTOR(27 DOWNTO 0)
		);
	END COMPONENT;

	SIGNAL DIN : STD_LOGIC_VECTOR(15 DOWNTO 0);
	SIGNAL Reset_n, Clock, Run : STD_LOGIC;
	SIGNAL Done, Erreur : STD_LOGIC;
	SIGNAL BusWires : STD_LOGIC_VECTOR(15 DOWNTO 0);
	SIGNAL StateOutput : STD_LOGIC_VECTOR(8 DOWNTO 0);
	SIGNAL AfficheurRegistre : STD_LOGIC_VECTOR(27 DOWNTO 0);
	
BEGIN

	processeur : Processeur_V1 GENERIC MAP(16) PORT MAP(DIN, Reset_n, Clock, Run, Done, Erreur, BusWires, StateOutput, AfficheurRegistre);	

	first_test : process
			BEGIN 
			Reset_n<='0';
			Run<='1';
			
			DIN(15 DOWNTO 0)<="0000000000000000" ;--"111110110100";
			Clock<='1';
			wait for 20 ns;
			Clock<='0';
			wait for 20 ns;	
			Clock<='1';
			wait for 20 ns;
			Clock<='0';
			wait for 20 ns;	

	
			
			DIN(15 DOWNTO 0)<="0000000000000001" ;
			Clock<='1';
			wait for 20 ns;
			Clock<='0';
			wait for 20 ns;	
			Clock<='1';
			wait for 20 ns;
			Clock<='0';
			wait for 20 ns;	

			
			
			DIN(15 DOWNTO 0)<="0000000000000010" ;
			Clock<='1';
			wait for 20 ns;
			Clock<='0';
			wait for 20 ns;
			Clock<='1';
			wait for 20 ns;
			Clock<='0';
			wait for 20 ns;	

			
			DIN(15 DOWNTO 0)<="0000000000000011" ;
			Clock<='1';
			wait for 20 ns;
			Clock<='0';
			wait for 20 ns;
			Clock<='1';
			wait for 20 ns;
			Clock<='0';
			wait for 20 ns;	

			
			DIN(15 DOWNTO 0)<="0000000000000100" ;
			Clock<='1';
			wait for 20 ns;
			Clock<='0';
			wait for 20 ns;
			Clock<='1';
			wait for 20 ns;
			Clock<='0';
			wait for 20 ns;	

			
			
			DIN(15 DOWNTO 0)<="0000000000000101" ;
			Clock<='1';
			wait for 20 ns;
			Clock<='0';
			wait for 20 ns;
			Clock<='1';
			wait for 20 ns;
			Clock<='0';
			wait for 20 ns;	

			
			
			DIN(15 DOWNTO 0)<="0000000000000110" ;
			Clock<='1';
			wait for 20 ns;
			Clock<='0';
			wait for 20 ns;
			Clock<='1';
			wait for 20 ns;
			Clock<='0';
			wait for 20 ns;	

			
			
			DIN(15 DOWNTO 0)<="0000000000000111" ;
			Clock<='1';
			wait for 20 ns;
			Clock<='0';
			wait for 20 ns;
			Clock<='1';
			wait for 20 ns;
			Clock<='0';
			wait for 20 ns;	

			
			
			DIN(15 DOWNTO 0)<="0000000000001000" ;
			Clock<='1';
			wait for 20 ns;
			Clock<='0';
			wait for 20 ns;
			Clock<='1';
			wait for 20 ns;
			Clock<='0';
			wait for 20 ns;	

			
			
			
			DIN(15 DOWNTO 0)<="0000000000001001" ;
			Clock<='1';
			wait for 20 ns;
			Clock<='0';
			wait for 20 ns;
			Clock<='1';
			wait for 20 ns;
			Clock<='0';
			wait for 20 ns;	

			
			
			DIN(15 DOWNTO 0)<="0000000000001010" ;
			Clock<='1';
			wait for 20 ns;
			Clock<='0';
			wait for 20 ns;
			Clock<='1';
			wait for 20 ns;
			Clock<='0';
			wait for 20 ns;	

			
			
			DIN(15 DOWNTO 0)<="0000000000001011" ;
			Clock<='1';
			wait for 20 ns;
			Clock<='0';
			wait for 20 ns;
			Clock<='1';
			wait for 20 ns;
			Clock<='0';
			wait for 20 ns;	

			
			
			DIN(15 DOWNTO 0)<="0000000000001111" ;
			Clock<='1';
			wait for 20 ns;
			Clock<='0';
			wait for 20 ns;
			Clock<='1';
			wait for 20 ns;
			Clock<='0';
			wait for 20 ns;	

			
			
			DIN(15 DOWNTO 0)<="0000000000010000" ;
			Clock<='1';
			wait for 20 ns;
			Clock<='0';
			wait for 20 ns;
			Clock<='1';
			wait for 20 ns;
			Clock<='0';
			wait for 20 ns;	
			
			DIN(15 DOWNTO 0)<="0000000000010001" ;
			Clock<='1';
			wait for 20 ns;
			Clock<='0';
			wait for 20 ns;
			Clock<='1';
			wait for 20 ns;
			Clock<='0';
			wait for 20 ns;	
			
			
			DIN(15 DOWNTO 0)<="0000000000010010" ;
			Clock<='1';
			wait for 20 ns;
			Clock<='0';
			wait for 20 ns;
			Clock<='1';
			wait for 20 ns;
			Clock<='0';
			wait for 20 ns;	
			
			
			DIN(15 DOWNTO 0)<="0000000000010011" ;
			Clock<='1';
			wait for 20 ns;
			Clock<='0';
			wait for 20 ns;
			Clock<='1';
			wait for 20 ns;
			Clock<='0';
			wait for 20 ns;	
			
			
			DIN(15 DOWNTO 0)<="0000000000010100" ;
			Clock<='1';
			wait for 20 ns;
			Clock<='0';
			wait for 20 ns;
			Clock<='1';
			wait for 20 ns;
			Clock<='0';
			wait for 20 ns;	
			
			
			DIN(15 DOWNTO 0)<="0000000000010101" ;
			Clock<='1';
			wait for 20 ns;
			Clock<='0';
			wait for 20 ns;
			Clock<='1';
			wait for 20 ns;
			Clock<='0';
			wait for 20 ns;	
			
			
			DIN(15 DOWNTO 0)<="0000000000010110" ;
			Clock<='1';
			wait for 20 ns;
			Clock<='0';
			wait for 20 ns;
			Clock<='1';
			wait for 20 ns;
			Clock<='0';
			wait for 20 ns;	
			
			DIN(15 DOWNTO 0)<="0000000000010111" ;
			Clock<='1';
			wait for 20 ns;
			Clock<='0';
			wait for 20 ns;
			Clock<='1';
			wait for 20 ns;
			Clock<='0';
			wait for 20 ns;
		
			DIN(15 DOWNTO 0)<="0000000000011000" ;
			Clock<='1';
			wait for 20 ns;
			Clock<='0';
			wait for 20 ns;
			Clock<='1';
			wait for 20 ns;
			Clock<='0';
			wait for 20 ns;
			
			DIN(15 DOWNTO 0)<="0000000000011001" ;
			Clock<='1';
			wait for 20 ns;
			Clock<='0';
			wait for 20 ns;
			Clock<='1';
			wait for 20 ns;
			Clock<='0';
			wait for 20 ns;
			
			DIN(15 DOWNTO 0)<="0000000000011010" ;
			Clock<='1';
			wait for 20 ns;
			Clock<='0';
			wait for 20 ns;
			Clock<='1';
			wait for 20 ns;
			Clock<='0';
			wait for 20 ns;
			
			DIN(15 DOWNTO 0)<="0000000000011011" ;
			Clock<='1';
			wait for 20 ns;
			Clock<='0';
			wait for 20 ns;
			Clock<='1';
			wait for 20 ns;
			Clock<='0';
			wait for 20 ns;
			
			DIN(15 DOWNTO 0)<="0000000000011100" ;
			Clock<='1';
			wait for 20 ns;
			Clock<='0';
			wait for 20 ns;
			Clock<='1';
			wait for 20 ns;
			Clock<='0';
			wait for 20 ns;
			
			DIN(15 DOWNTO 0)<="0000000000011101" ;
			Clock<='1';
			wait for 20 ns;
			Clock<='0';
			wait for 20 ns;
			Clock<='1';
			wait for 20 ns;
			Clock<='0';
			wait for 20 ns;
			
			DIN(15 DOWNTO 0)<="0000000000011110" ;
			Clock<='1';
			wait for 20 ns;
			Clock<='0';
			wait for 20 ns;
			Clock<='1';
			wait for 20 ns;
			Clock<='0';
			wait for 20 ns;
			
			DIN(15 DOWNTO 0)<="0000000000011111" ;
			Clock<='1';
			wait for 20 ns;
			Clock<='0';
			wait for 20 ns;
			Clock<='1';
			wait for 20 ns;
			Clock<='0';
			wait for 20 ns;
			
			DIN(15 DOWNTO 0)<="0000000000100000" ;
			Clock<='1';
			wait for 20 ns;
			Clock<='0';
			wait for 20 ns;
			Clock<='1';
			wait for 20 ns;
			Clock<='0';
			wait for 20 ns;
			
			--TEST INVERE
			
			DIN(15 DOWNTO 0)<="0000000000100001" ;
			Clock<='1';
			wait for 20 ns;
			Clock<='0';
			wait for 20 ns;
			Clock<='1';
			wait for 20 ns;
			Clock<='0';
			wait for 20 ns;
			
			DIN(15 DOWNTO 0)<="0000000000010111" ;
			Clock<='1';
			wait for 20 ns;
			Clock<='0';
			wait for 20 ns;
			Clock<='1';
			wait for 20 ns;
			Clock<='0';
			wait for 20 ns;
			
			DIN(15 DOWNTO 0)<="0000000000010111" ;
			Clock<='1';
			wait for 20 ns;
			Clock<='0';
			wait for 20 ns;
			Clock<='1';
			wait for 20 ns;
			Clock<='0';
			wait for 20 ns;
			
			DIN(15 DOWNTO 0)<="0000000000010111" ;
			Clock<='1';
			wait for 20 ns;
			Clock<='0';
			wait for 20 ns;
			Clock<='1';
			wait for 20 ns;
			Clock<='0';
			wait for 20 ns;
			
			DIN(15 DOWNTO 0)<="0000000000010111" ;
			Clock<='1';
			wait for 20 ns;
			Clock<='0';
			wait for 20 ns;
			Clock<='1';
			wait for 20 ns;
			Clock<='0';
			wait for 20 ns;
			
			DIN(15 DOWNTO 0)<="0000000000010111" ;
			Clock<='1';
			wait for 20 ns;
			Clock<='0';
			wait for 20 ns;
			Clock<='1';
			wait for 20 ns;
			Clock<='0';
			wait for 20 ns;
			
			DIN(15 DOWNTO 0)<="0000000000010111" ;
			Clock<='1';
			wait for 20 ns;
			Clock<='0';
			wait for 20 ns;
			Clock<='1';
			wait for 20 ns;
			Clock<='0';
			wait for 20 ns;
			
			DIN(15 DOWNTO 0)<="0000000000010111" ;
			Clock<='1';
			wait for 20 ns;
			Clock<='0';
			wait for 20 ns;
			Clock<='1';
			wait for 20 ns;
			Clock<='0';
			wait for 20 ns;
			

			
	end process first_test;
	

END Processeur_V1_TB_bhv;
