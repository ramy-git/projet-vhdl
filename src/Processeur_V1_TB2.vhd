LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY Processeur_V1_TB2 IS
	
END Processeur_V1_TB2;

ARCHITECTURE Processeur_V1_TB2_bhv OF Processeur_V1_TB2 Is
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
			--Reset_n <= '1';
			--Run<='0';
			--clock <='0';
			--DIN <= "0000000000000000";
			--wait for 20 ns;
			--Reset_n<='0';
			--wait for 20 ns;
			Run<='1';
			Reset_n <= '0';
			
			--Initialisation du test : 

			-- Etape 1 : envoie des données au registre avec MVI
			
			--donnée 1
			-- code opération : 0101, Registre destination : 0000, donnée : 0000000000000001
			DIN(15 DOWNTO 0)<="0000000000000101";
			--Tour 1, Automate init
			
			Clock<='1';			
			wait for 20 ns;
			Clock<='0';
			wait for 20 ns;	
			Clock<='1';			
			wait for 20 ns;
			Clock<='0';
			wait for 20 ns;	
			
			
			--Ici on peut envoyer dans DIN la valeur du registre
			DIN(15 DOWNTO 0)<="0000000000000001";
			--Tour 2, Automate décode
			Clock<='1';
			wait for 20 ns;
			Clock<='0';
			wait for 20 ns;
			
			--Tour 2, Automate MVI : on envoie la donnée de MVI
			Clock<='1';
			wait for 20 ns;
			Clock<='0';
			wait for 20 ns;
			
			--Fin de l'instruction donnée 1

			--donnée 2
			-- code opération : 0101, Registre destination : 0001, donnée : 0000000000000001
			DIN(15 DOWNTO 0)<="0000000000010101";
			--Tour 1, Automate init
			Clock<='1';
			wait for 20 ns;
			Clock<='0';
			wait for 20 ns;	
			
			--Ici on peut envoyer dans DIN la valeur du registre
			DIN(15 DOWNTO 0)<="0000000000000001";
			--Tour 2, Automate décode
			Clock<='1';
			wait for 20 ns;
			Clock<='0';
			wait for 20 ns;
			
			--Tour 2, Automate MVI : on envoie la donnée de MVI
			Clock<='1';
			wait for 20 ns;
			Clock<='0';
			wait for 20 ns;
			
			--Fin de l'instruction donnée 2
			
			--Addition du registre 1 et 2
			--code opération : 1000, registre A : 0000, registre B : 0001
			DIN(15 DOWNTO 0)<="0000000100001000";

			--Tour 1, Automate init
			Clock<='1';
			wait for 20 ns;
			Clock<='0';
			wait for 20 ns;	
			
			--Tour 2, Automate décode
			Clock<='1';
			wait for 20 ns;
			Clock<='0';
			wait for 20 ns;	
	
			--Tour 3, automate Fill_A
			Clock<='1';
			wait for 20 ns;
			Clock<='0';
			wait for 20 ns;		
			
			--Tour 3, automate opération
			Clock<='1';
			wait for 20 ns;
			Clock<='0';
			wait for 20 ns;		

			--Fin de l'instruction d'addition
			
			--Affichage du registre 1 : 0000
			--code opération : 0011, registre A : 0000
			DIN(15 DOWNTO 0)<="0000000000000011";
			
			--Tour 1, Automate init
			Clock<='1';
			wait for 20 ns;
			Clock<='0';
			wait for 20 ns;	
			
			--Tour 2, Automate décode
			Clock<='1';
			wait for 20 ns;
			Clock<='0';
			wait for 20 ns;	
	
			--Tour 3, automate IMAGE
			Clock<='1';
			wait for 20 ns;
			Clock<='0';
			wait for 20 ns;		
			
			DIN(15 DOWNTO 0)<="----------------";
			
			Clock<='1';
			wait for 20 ns;
			Clock<='0';
			wait for 20 ns;
			Clock<='1';
			wait for 20 ns;
			Clock<='0';
			wait for 20 ns;
			Clock<='1';
			wait for 20 ns;
			Clock<='0';
			wait for 20 ns;
			Clock<='1';
			wait for 20 ns;
			Clock<='0';
			wait for 20 ns;
			
	end process first_test;
	

END Processeur_V1_TB2_bhv;
