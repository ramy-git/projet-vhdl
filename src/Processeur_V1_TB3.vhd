LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY Processeur_V1_TB3 IS
	
END Processeur_V1_TB3;

ARCHITECTURE Processeur_V1_TB3_bhv OF Processeur_V1_TB3 Is
COMPONENT Systeme IS
	PORT(
		MClock : IN STD_LOGIC;
		PClock : IN STD_LOGIC;
		Resetn : IN STD_LOGIC;
		Run : IN STD_LOGIC;
		Done, Erreur : OUT STD_LOGIC;
		BusWires : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		StateOutput : OUT STD_LOGIC_VECTOR(8 DOWNTO 0); --Signaux d'indication de l'état courant
		AfficheurRegistre : OUT STD_LOGIC_VECTOR(27 DOWNTO 0)		
	);
END COMPONENT;	

Signal Mclock, Pclock, Resetn, Run, Done, Erreur : STD_LOGIC;
Signal BusWires : STD_LOGIC_VECTOR(15 DOWNTO 0);
Signal StateOutput : STD_LOGIC_VECTOR(8 DOWNTO 0);
Signal AfficheurRegistre : STD_LOGIC_VECTOR(27 DOWNTO 0);
	
BEGIN
comp : Systeme PORT MAP (Mclock => Mclock, Pclock => Pclock,Resetn=>resetn,run=>run,done=>done,erreur=>erreur,BusWires=>Buswires,StateOutput=>StateOutput,AfficheurRegistre=>afficheurRegistre);	

	first_test : process
			BEGIN 
			Resetn <= '1';
			Run<='0';
			Pclock <='0';
			Mclock <='0';
			wait for 20 ns;
			
			Resetn <= '0';
			Run<='1';
			
			--donnée 1
			--Tour 1, Automate init
			
			PClock<='1';			
			wait for 20 ns;
			PClock<='0';
			wait for 20 ns;	
			PClock<='1';			
			wait for 20 ns;
			PClock<='0';
			wait for 20 ns;	
			
			Mclock <= '1';
			wait for 20 ns;
			Mclock <= '0';			
			
			--Tour 2, Automate décode
			PClock<='1';
			wait for 20 ns;
			PClock<='0';
			wait for 20 ns;
			
			--Tour 2, Automate MVI : on envoie la donnée de MVI
			PClock<='1';
			wait for 20 ns;
			PClock<='0';
			wait for 20 ns;
			
			--Fin de l'instruction donnée 1

			--donnée 2
			--Tour 1, Automate init
			
			Mclock <= '1';
			wait for 20 ns;
			Mclock <= '0';	
			
			PClock<='1';			
			wait for 20 ns;
			PClock<='0';
			wait for 20 ns;	
			PClock<='1';			
			wait for 20 ns;
			PClock<='0';
			wait for 20 ns;	
			
			Mclock <= '1';
			wait for 20 ns;
			Mclock <= '0';			
			
			--Tour 2, Automate décode
			PClock<='1';
			wait for 20 ns;
			PClock<='0';
			wait for 20 ns;
			
			--Tour 2, Automate MVI : on envoie la donnée de MVI
			PClock<='1';
			wait for 20 ns;
			PClock<='0';
			wait for 20 ns;
			
			--Fin de l'instruction donnée 2
			
			--Addition du registre 1 et 2
			Mclock <= '1';
			wait for 20 ns;
			Mclock <= '0';	

			--Tour 1, Automate init
			PClock<='1';
			wait for 20 ns;
			PClock<='0';
			wait for 20 ns;	
			
			--Tour 2, Automate décode
			PClock<='1';
			wait for 20 ns;
			PClock<='0';
			wait for 20 ns;	
	
			--Tour 3, automate Fill_A
			PClock<='1';
			wait for 20 ns;
			PClock<='0';
			wait for 20 ns;		
			
			--Tour 3, automate opération
			PClock<='1';
			wait for 20 ns;
			PClock<='0';
			wait for 20 ns;		

			--Fin de l'instruction d'addition

			
	end process first_test;
	

END Processeur_V1_TB3_bhv;
