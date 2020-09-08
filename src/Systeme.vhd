LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY Systeme IS
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
	
END Systeme;

ARCHITECTURE Systeme_bhw OF Systeme IS

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
	
	COMPONENT ROM IS
	PORT
	(
		address		: IN STD_LOGIC_VECTOR (4 DOWNTO 0);
		clock		: IN STD_LOGIC  := '1';
		q		: OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
	);
	END COMPONENT;
	
	COMPONENT counter IS
	PORT
	(
		aclr		: IN STD_LOGIC ;
		clock		: IN STD_LOGIC ;
		q		: OUT STD_LOGIC_VECTOR (4 DOWNTO 0)
	);
	END COMPONENT;
	
	Signal addr : STD_LOGIC_VECTOR (4 DOWNTO 0);
	Signal DIN : STD_LOGIC_VECTOR (15 DOWNTO 0);
	
	BEGIN
	
	processor : Processeur_V1 PORT MAP (DIN => DIN, Reset_n => resetn, clock => Pclock, Run => Run, Done => Done, Erreur => Erreur, BusWires => BusWires, StateOutput => StateOutput, AfficheurRegistre => AfficheurRegistre);
	programCounter : counter PORT MAP (aclr => resetn, clock => Mclock, q => addr);
	memory : rom PORT MAP (address => addr, clock => Mclock, q => DIN);

END Systeme_bhw;