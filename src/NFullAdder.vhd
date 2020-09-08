LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY NFullAdder IS
	generic(N : positive := 8);
	port(
		x, y: IN STD_LOGIC_VECTOR(N-1 DOWNTO 0); --Données entrantes 
		cin : IN STD_LOGIC;
		s : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0); -- Sortie
		cout : OUT STD_LOGIC);
END NFullAdder;

ARCHITECTURE NFullAdder_bhv OF NFullAdder Is
	COMPONENT FullAdder IS
	port( 
		x, y: IN STD_LOGIC; --Données entrantes 
		cin : IN STD_LOGIC;
		s : OUT STD_LOGIC; -- Sortie
		cout : OUT STD_LOGIC);
	END COMPONENT;
	
	SIGNAL r : STD_LOGIC_VECTOR(N-1 DOWNTO 0); 
	
	BEGIN
	cell_array : FOR i IN 0 TO N-1 GENERATE
		first_cell :  if i = 0 GENERATE
			FA0 : FullAdder PORT MAP(
				x(0),y(0),cin,s(0),r(0)
			);
		end generate first_cell;
		
		middle_cell :  if i > 0 and i < N-1 GENERATE
			FAi : FullAdder PORT MAP(
				x(i),y(i),r(i-1),s(i),r(i) 
			);
		end generate middle_cell;
		
		last_cell :  if i = N-1 GENERATE
			FAi : FullAdder PORT MAP(
				x(i),y(i),r(i-1),s(i),cout
			);
		end generate last_cell;
		
	END GENERATE cell_array;
END NFullAdder_bhv;