LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY Multi IS
	port( 
		b: IN STD_LOGIC; --Données entrantes 
		a,a1: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		cin : IN STD_LOGIC;
		cout: OUT STD_LOGIC;
		s: OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
END Multi;

ARCHITECTURE Multi_bhv OF Multi Is
	
	
	COMPONENT FullAdder IS
	port( 
		x, y : IN STD_LOGIC; --Données entrantes 
		cin : IN STD_LOGIC;
		s : OUT STD_LOGIC; -- Sortie
		cout : OUT STD_LOGIC);
	END COMPONENT;
	
	SIGNAL n0 : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL c : STD_LOGIC_VECTOR(2 DOWNTO 0); 
	
	BEGIN
	n0(0) <= a(0) AND b;
	n0(1) <= a(1) AND b;
	n0(2) <= a(2) AND b;
	n0(3) <= a(3) AND b;

	FA0 : FullAdder PORT MAP(
		n0(0), a1(0), cin, s(0), c(0)  
	);
	FA1 : FullAdder PORT MAP(
		n0(1), a1(1), c(0), s(1), c(1)
	);
	FA2 : FullAdder PORT MAP(
		n0(2), a1(2), c(1), s(2), c(2)   
	);
	FA3 : FullAdder PORT MAP(
		n0(3), a1(3), c(2), s(3), cout  
	);
	
END Multi_bhv;