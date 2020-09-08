LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY FullAdder_4bits IS
	port( 
		a, b: IN STD_LOGIC_VECTOR(3 DOWNTO 0); --Données entrantes 
		cin : IN STD_LOGIC;
		s : OUT STD_LOGIC_VECTOR (3 DOWNTO 0); -- Sortie
		cout : OUT STD_LOGIC);
END FullAdder_4bits;

ARCHITECTURE FullAdder_4bits_bhv OF FullAdder_4bits Is
	
	COMPONENT FullAdder IS
	port( 
		x, y: IN STD_LOGIC; --Données entrantes 
		cin : IN STD_LOGIC;
		s : OUT STD_LOGIC; -- Sortie
		cout : OUT STD_LOGIC);
	END COMPONENT;
	
	SIGNAL R1 : STD_LOGIC;
	SIGNAL R2 : STD_LOGIC;
	SIGNAL R3 : STD_LOGIC;
	
	BEGIN
	FA0 : FullAdder PORT MAP(
		a(0), b(0), cin, s(0), R1   
	);
	FA1 : FullAdder PORT MAP(
		a(1), b(1), R1, s(1), R2   
	);
	FA2 : FullAdder PORT MAP(
		a(2), b(2), R2, s(2), R3   
	);
	FA3 : FullAdder PORT MAP(
		a(3), b(3), R3, s(3), cout   
	);
	
	
	
	
END FullAdder_4bits_bhv;