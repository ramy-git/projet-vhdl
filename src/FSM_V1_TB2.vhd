LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY FSM_V1_TB2 IS

END FSM_V1_TB2;

ARCHITECTURE FSM_V1_TB2_bhv OF FSM_V1_TB2 Is
	COMPONENT FSM_V1 IS
		generic(NombreRegistre : positive :=16); -- Nombre de registre que controle la FSM : on ne prend pas en compte les registre R,G et A
		
		port( 
			--Entrées
			IR : IN STD_LOGIC_VECTOR(11 DOWNTO 0); -- 12 bits de données entrantes
			clk, reset_n, run : std_logic; -- reset_n : mise à 0 de tous les registres
			
			--Sorties automate
			Done : OUT STD_LOGIC; -- sortie	qui indique que l'instruction est fini
			Erreur : OUT STD_LOGIC; -- sortie	qui indique que l'instruction s'est mal fini
			StateOutput : OUT STD_LOGIC_VECTOR(8 DOWNTO 0); --Signaux d'indication de l'état courant
			
			--Sortie multiplexer
			selectionnerMultiplexer : OUT STD_LOGIC_VECTOR(4 DOWNTO 0); --Nombre de 
			
			--Choix opérations ALU
			SelAlu : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
			
			--Sortie registre du processeur
			reset_registre : OUT STD_LOGIC_VECTOR(15 DOWNTO 0); -- Sortie registre de travail
			reset_registre_IR : OUT STD_LOGIC;
			reset_registre_G : OUT STD_LOGIC;
			reset_registre_A : OUT STD_LOGIC;
			
			set_registre : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);		
			set_registre_IR : OUT STD_LOGIC;
			set_registre_G : OUT STD_LOGIC;
			set_registre_A : OUT STD_LOGIC;
		
			--Sortie registre image 
			reset_registre_image : OUT STD_LOGIC;
			set_registre_image : OUT STD_LOGIC
		);
	END COMPONENT;

		
		--Entrées
		SIGNAL IR : STD_LOGIC_VECTOR(11 DOWNTO 0); -- 12 + 1 bits de données entrantes
		SIGNAL clk, reset_n, run : std_logic; -- reset_n : mise à 0 de tous les registres
		
		--Sorties automate
		SIGNAL Done : STD_LOGIC; -- sortie	qui indique que l'instruction est fini
		SIGNAL Erreur : STD_LOGIC; -- sortie	qui indique que l'instruction s'est mal fini
		SIGNAL StateOutput : STD_LOGIC_VECTOR(8 DOWNTO 0); --Signaux d'indication de l'état courant
		
		--Sortie multiplexer
		SIGNAL selectionnerMultiplexer : STD_LOGIC_VECTOR(4 DOWNTO 0); --Nombre de 
		
		--Choix opérations ALU
		SIGNAL SelAlu : STD_LOGIC_VECTOR (3 DOWNTO 0);
		
		--Sortie registre du processeur
		SIGNAL reset_registre : STD_LOGIC_VECTOR(15 DOWNTO 0); -- Sortie registre de travail
		SIGNAL reset_registre_IR : STD_LOGIC;
		SIGNAL reset_registre_G : STD_LOGIC;
		SIGNAL reset_registre_A : STD_LOGIC;
		
		SIGNAL set_registre : STD_LOGIC_VECTOR(15 DOWNTO 0);		
		SIGNAL set_registre_IR : STD_LOGIC;
		SIGNAL set_registre_G : STD_LOGIC;
		SIGNAL set_registre_A : STD_LOGIC;	
	
		--Sortie registre image 
		SIGNAL reset_registre_image : STD_LOGIC;
		SIGNAL set_registre_image : STD_LOGIC;	
		
BEGIN

	--Creation de la composante à tester
	FSM : FSM_V1 GENERIC MAP (16) PORT MAP(
		IR,
		clk, reset_n, run,
		Done,
		Erreur,
		StateOutput,
		selectionnerMultiplexer,
		SelAlu,
		reset_registre,
		reset_registre_IR,
		reset_registre_G,
		reset_registre_A,
		set_registre,
		set_registre_IR,
		set_registre_G,
		set_registre_A,
		reset_registre_image,
		set_registre_image
	);		
		
	--Pour faire fonctionner le test, il suffit d'indiquer des valeurs à la FSM
	--via les cables imput uniquement
	-- IR,
	-- clk, reset_n, run,

	--Pour écrire une instruction, on l'écrit de droite à gauche
	
	first_test : process
			BEGIN 
			--Initialisation du test : 
			run<='1';

			-- Etape 1 : envoie des données au registre avec MVI
			
			--donnée 1
			-- code opération : 0101, Registre destination : 0000, donnée : 0000000000000001
			IR(11 DOWNTO 0)<="000000000101";
			--Tour 1, Automate init
			clk<='1';
			wait for 20 ns;
			clk<='0';
			wait for 20 ns;	
			
			--Ici on peut envoyer dans DIN la valeur du registre
			IR(11 DOWNTO 0)<="000000000101";
			--Tour 2, Automate décode
			clk<='1';
			wait for 20 ns;
			clk<='0';
			wait for 20 ns;
			
			--Tour 2, Automate MVI : on envoie la donnée de MVI
			clk<='1';
			wait for 20 ns;
			clk<='0';
			wait for 20 ns;
			
			--Fin de l'instruction donnée 1

			--donnée 2
			-- code opération : 0101, Registre destination : 0001, donnée : 0000000000000001
			IR(11 DOWNTO 0)<="000000010101";
			--Tour 1, Automate init
			clk<='1';
			wait for 20 ns;
			clk<='0';
			wait for 20 ns;	
			
			--Ici on peut envoyer dans DIN la valeur du registre
			
			--Tour 2, Automate décode
			clk<='1';
			wait for 20 ns;
			clk<='0';
			wait for 20 ns;
			
			--Tour 2, Automate MVI : on envoie la donnée de MVI
			clk<='1';
			wait for 20 ns;
			clk<='0';
			wait for 20 ns;
			
			--Fin de l'instruction donnée 2
			
			--Addition du registre 1 et 2
			--code opération : 1000, registre A : 0000, registre B : 0001
			IR(11 DOWNTO 0)<="000010001000";

			--Tour 1, Automate init
			clk<='1';
			wait for 20 ns;
			clk<='0';
			wait for 20 ns;	
			
			--Tour 2, Automate décode
			clk<='1';
			wait for 20 ns;
			clk<='0';
			wait for 20 ns;	
	
			--Tour 3, automate Fill_A
			clk<='1';
			wait for 20 ns;
			clk<='0';
			wait for 20 ns;		
			
			--Tour 3, automate opération
			clk<='1';
			wait for 20 ns;
			clk<='0';
			wait for 20 ns;		

			--Fin de l'instruction d'addition
			
			--Affichage du registre 1 : 0000
			--code opération : 0011, registre A : 0000
			IR(11 DOWNTO 0)<="000000000011";
			
			--Tour 1, Automate init
			clk<='1';
			wait for 20 ns;
			clk<='0';
			wait for 20 ns;	
			
			--Tour 2, Automate décode
			clk<='1';
			wait for 20 ns;
			clk<='0';
			wait for 20 ns;	
	
			--Tour 3, automate IMAGE
			clk<='1';
			wait for 20 ns;
			clk<='0';
			wait for 20 ns;		
			
			IR(11 DOWNTO 0)<="------------";
			
			clk<='1';
			wait for 20 ns;
			clk<='0';
			wait for 20 ns;
			clk<='1';
			wait for 20 ns;
			clk<='0';
			wait for 20 ns;
			clk<='1';
			wait for 20 ns;
			clk<='0';
			wait for 20 ns;
			clk<='1';
			wait for 20 ns;
			clk<='0';
			wait for 20 ns;
			end process first_test;
	

END FSM_V1_TB2_bhv;
