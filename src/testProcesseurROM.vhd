LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY testProcesseurROM IS
	PORT(
		CLOCK_50 : IN STD_LOGIC;
		SW : IN STD_LOGIC_VECTOR(17 DOWNTO 0);
		KEY : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		LEDR : OUT STD_LOGIC_VECTOR(17 DOWNTO 0);
		LEDG : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
		HEX0 : BUFFER STD_LOGIC_VECTOR(6 DOWNTO 0);
		HEX1 : BUFFER STD_LOGIC_VECTOR(6 DOWNTO 0);
		HEX2 : BUFFER STD_LOGIC_VECTOR(6 DOWNTO 0);
		HEX3 : BUFFER STD_LOGIC_VECTOR(6 DOWNTO 0)
		
	);
	
END testProcesseurROM;

ARCHITECTURE testProcesseurROM_bhw OF testProcesseurROM IS
	COMPONENT Processeur_V2 IS
		PORT(
			--Attribut bloc mémoire
			MemoryClock : IN STD_LOGIC;
			SelMultiplexeur : IN STD_LOGIC;
			
			--Attribut processeur
			ProcessorClock : IN STD_LOGIC;
			
			Done, Erreur : OUT STD_LOGIC;
			BusWires : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
			StateOutput : OUT STD_LOGIC_VECTOR(8 DOWNTO 0); --Signaux d'indication de l'état courant
			AfficheurRegistre : OUT STD_LOGIC_VECTOR(27 DOWNTO 0);
			
			--Attribut general
			Reset_n : IN STD_LOGIC;
			Run : IN STD_LOGIC
			
		);
	END COMPONENT;

	BEGIN 
	
	--test : Processeur_V2 PORT MAP(
		--Clock_50,
		
	--	Clock_50,
	--);
	
	
END testProcesseurROM_bhw;