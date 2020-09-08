LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY Processeur_V1 IS
	GENERIC(N : POSITIVE :=16);
	port( 
		DIN : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		Reset_n, Clock, Run : IN STD_LOGIC;
		Done, Erreur : OUT STD_LOGIC;
		BusWires : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		StateOutput : OUT STD_LOGIC_VECTOR(8 DOWNTO 0); --Signaux d'indication de l'état courant
		AfficheurRegistre : OUT STD_LOGIC_VECTOR(27 DOWNTO 0)
	);
END Processeur_V1;

ARCHITECTURE Processeur_V1_bhv OF Processeur_V1 Is
	--FSM
	COMPONENT FSM_V1 IS
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

	--Multiplexers
	COMPONENT Mult_32_1_Nbit IS
		GENERIC(N : POSITIVE :=8);
		PORT ( 
			a0, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15 : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
			a16, a17, a18, a19, a20, a21, a22, a23, a24, a25, a26, a27, a28, a29, a30, a31 : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
			sel : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
			s : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0)

		);
	END COMPONENT;

	--Banc de registre
	COMPONENT BancRegistreNBits IS 
	generic(N : positive :=8);
	Port (
		d : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
		en, n_reset : STD_LOGIC_VECTOR(N-1 DOWNTO 0);
		ck  : STD_LOGIC;
		q0, q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, q12, q13, q14, q15 : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0)
	);
	END COMPONENT;	
	
	--Registre	
	COMPONENT registreNBits IS 
		generic(N : positive :=8);
		Port (
			d : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
			en, ck, n_reset : IN STD_LOGIC;
			q : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0)
		);
	END COMPONENT;
	
	--Alu
	COMPONENT ALU_NBit IS
		GENERIC(N : POSITIVE :=8);
		PORT ( 
			a0, a1 : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
			sel : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			s : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0)
		);
	END COMPONENT;
	--DECODEUR 7 SEGMENT POUR MOT DE 16 BITS
	COMPONENT decodeurChiffe_16Bits IS 
		port(
			binaire : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
			sortie : OUT STD_LOGIC_VECTOR(27 DOWNTO 0)
		);
	END COMPONENT;
	
	
	TYPE Paquet_15_Fils_NBits  IS array(15 DOWNTO 0) of STD_LOGIC_VECTOR(N-1 DOWNTO 0);
	--CABLE GLOBAUX
	SIGNAL CheminDeDonnee : STD_LOGIC_VECTOR(N-1 DOWNTO 0) ;
	
	--Etape 1 : creation du banc de registre et connexion
	SIGNAL sortieRegistreMemoire : Paquet_15_Fils_NBits ;
	SIGNAL EnableRegistreMemoire : STD_LOGIC_VECTOR(N-1 DOWNTO 0) ;
	SIGNAL ResetRegistreMemoire : STD_LOGIC_VECTOR(N-1 DOWNTO 0) ;
	
	--Etape 2 : mise en place de l'ALU	
	SIGNAL SortieRegistreA : STD_LOGIC_VECTOR(N-1 DOWNTO 0) ;
	SIGNAL selectionneurALU : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL entreRegistreG : STD_LOGIC_VECTOR(N-1 DOWNTO 0) ;
	--Etape 3 : mise en place du registre A et G
	SIGNAL SortieRegistreG : STD_LOGIC_VECTOR(N-1 DOWNTO 0) ;
	SIGNAL enableA : STD_LOGIC;
	SIGNAL resetA : STD_LOGIC;
	SIGNAL enableG : STD_LOGIC;
	SIGNAL resetG : STD_LOGIC;
	--Etape 4 : mise en place du multiplexeur 32 bits
	SIGNAL selectionneurMultiplexeur : STD_LOGIC_VECTOR(4 DOWNTO 0);
	SIGNAL TROUEMULTIPLEXER : STD_LOGIC_VECTOR(15 DOWNTO 0);
	--Etape 5 : mise en place du registre IR
	SIGNAL sortieIR : STD_LOGIc_VECTOR(11 DOWNTO 0);
	SIGNAL enableIR : STD_LOGIc;
	SIGNAL resetIR : STD_LOGIc;
	--Etape 7 : mise en place du registre image
	SIGNAL reset_registre_image : STD_LOGIC;
	SIGNAL set_registre_image : STD_LOGIC;
	SIGNAL sortieImage : STD_LOGIC_VECTOR(15 DOWNTO 0);
	
	
	BEGIN
	--Valeur qui permet de comble les valeurs inutilisées du multiplexeur
	--CheminDeDonnee<="----------------";
	--TROUEMULTIPLEXER<="0000000000000000";
	
	--Capteurs :
	--Capteur sur le chemin de donnée
	BusWires(15 DOWNTO 0)<=CheminDeDonnee(15 DOWNTO 0);
	
	--Etape 1 : creation du banc de registre et connexion
	bancMemoire : BancRegistreNBits GENERIC MAP(16) PORT MAP(CheminDeDonnee,EnableRegistreMemoire,ResetRegistreMemoire,Clock,
		sortieRegistreMemoire(0), sortieRegistreMemoire(1), sortieRegistreMemoire(2), sortieRegistreMemoire(3),
		sortieRegistreMemoire(4), sortieRegistreMemoire(5), sortieRegistreMemoire(6), sortieRegistreMemoire(7),
		sortieRegistreMemoire(8), sortieRegistreMemoire(9), sortieRegistreMemoire(10), sortieRegistreMemoire(11),
		sortieRegistreMemoire(12), sortieRegistreMemoire(13), sortieRegistreMemoire(14), sortieRegistreMemoire(15)
	);
	
	--Etape 2 : mise en place de l'ALU
	ALU : ALU_NBit GENERIC MAP(16) PORT MAP(sortieRegistreA, CheminDeDonnee, selectionneurALU, entreRegistreG);
	
	--Etape 3 : mise en place du registre A et G
	A : registreNBits GENERIC MAP(16) PORT MAP( CheminDeDonnee, enableA, clock, resetA, SortieRegistreA);
	G : registreNBits GENERIC MAP(16) PORT MAP( entreRegistreG, enableG, clock, resetG, SortieRegistreG);
	
	--Etape 4 : mise en place du multiplexeur 32 bits 
	multiplexer : Mult_32_1_Nbit GENERIC MAP(16) PORT MAP(
		sortieRegistreMemoire(0), sortieRegistreMemoire(1), sortieRegistreMemoire(2), sortieRegistreMemoire(3),
		sortieRegistreMemoire(4), sortieRegistreMemoire(5), sortieRegistreMemoire(6), sortieRegistreMemoire(7),
		sortieRegistreMemoire(8), sortieRegistreMemoire(9), sortieRegistreMemoire(10), sortieRegistreMemoire(11),
		sortieRegistreMemoire(12), sortieRegistreMemoire(13), sortieRegistreMemoire(14), sortieRegistreMemoire(15),
		DIN, SortieRegistreG, 
		TROUEMULTIPLEXER,TROUEMULTIPLEXER,TROUEMULTIPLEXER,TROUEMULTIPLEXER,TROUEMULTIPLEXER,
		TROUEMULTIPLEXER,TROUEMULTIPLEXER,TROUEMULTIPLEXER,TROUEMULTIPLEXER,TROUEMULTIPLEXER,
		TROUEMULTIPLEXER,TROUEMULTIPLEXER,TROUEMULTIPLEXER, TROUEMULTIPLEXER,
		selectionneurMultiplexeur, CheminDeDonnee
	);
	
	--Etape 5 : mise en place du registre IR
	IR : registreNBits GENERIC MAP(12) PORT MAP( DIN(11 DOWNTO 0), enableIR, clock, resetIR, sortieIR);
	
	--Etape 6 : mise en place de la final state machine<
	FSM : FSM_V1 PORT MAP(
			sortieIR,
			Clock,
			reset_n,
			Run,
			Done,
			Erreur,
			StateOutput,
			selectionneurMultiplexeur,
			selectionneurALU,
			ResetRegistreMemoire,
			resetIR,
			resetG,
			resetA,
			EnableRegistreMemoire,
			enableIR,
			enableG,
			enableA,
			reset_registre_image,
			set_registre_image
	);
	--Etape 7 : mise en place du registre image
	RegistreImage : registreNBits GENERIC MAP(16) PORT MAP( CheminDeDonnee, set_registre_image, clock, reset_registre_image, sortieImage);
	decodeurRegistre : decodeurChiffe_16Bits PORT MAP(sortieImage,AfficheurRegistre);
	
	
	
END Processeur_V1_bhv;
