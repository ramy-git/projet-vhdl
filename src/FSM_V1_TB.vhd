LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY FSM_V1_TB IS

END FSM_V1_TB;

ARCHITECTURE FSM_V1_TB_bhv OF FSM_V1_TB Is

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

	first_test : process
			BEGIN 
			--On déclenche le processeur en mettant run à 1
			run<='1';
			-- On donne la donnée
			-- code opération : 0100, RX : 1101, RY : 1111
			IR(11 DOWNTO 0)<="111110110100";
			
			clk<='1';
			wait for 20 ns;
			
			clk<='0';
			wait for 20 ns;			
			
			clk<='1';
			wait for 20 ns;
			
			clk<='0';
			wait for 20 ns;

			
			end process first_test;
	

END FSM_V1_TB_bhv;
