LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY N_MULT IS
	GENERIC(N : POSITIVE :=8);
	PORT ( 
		a, b : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
		cin : IN STD_LOGIC_VECTOR(N-2 DOWNTO 0);
		s : OUT STD_LOGIC_VECTOR( (2*N)-1 DOWNTO 0)

	);
END N_MULT;

ARCHITECTURE N_MULT_bhv OF N_MULT Is

	COMPONENT NFullAdder IS
	generic(N : positive := 8);
	port(
		x, y: IN STD_LOGIC_VECTOR(N-1 DOWNTO 0); --Données entrantes 
		cin : IN STD_LOGIC;
		s : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0); -- Sortie
		cout : OUT STD_LOGIC);
	END COMPONENT;
	
	COMPONENT And_nbits IS
	generic(N : positive := 8);
	port(
		a : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
		b : IN STD_LOGIC;
		s : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0)
	);
	END COMPONENT;

	TYPE CABLE  IS array(N-1 DOWNTO 0) of STD_LOGIC_VECTOR(N DOWNTO 0);
	TYPE CABLE2 IS array(N-1 DOWNTO 0) of STD_LOGIC_VECTOR(N-1 DOWNTO 0);
	SIGNAL C : CABLE;
	SIGNAL S_AND : CABLE2;
	SIGNAL firstCable : STD_LOGIC_VECTOR(N DOWNTO 0);

	BEGIN 
		-- Premier nand : 5 cable pour y mettre un zéro en 4ième position
		initNAnd : And_nbits GENERIC MAP(N) PORT MAP(
			a(N-1 DOWNTO 0), b(0), firstCable(N-1 DOWNTO 0)
		);
			
		firstCable(N)<='0';
			
		--Boucle	
			
		cell_array : FOR i IN 0 TO N-1 GENERATE
			
			first_cell :  if i = 0 GENERATE
				
				firstNAnd : And_nbits GENERIC MAP(N) PORT MAP(
					a(N-1 DOWNTO 0), b(1), S_AND(0)(N-1 DOWNTO 0)
				);
				
			FIRST_FA : NFullAdder GENERIC MAP(N) PORT MAP(
					firstCable(N DOWNTO 1), S_AND(0)(N-1 DOWNTO 0),'0',C(0)(N-1 DOWNTO 0),C(0)(N)
				);
				s(0) <= firstCable(0);
			
			end generate first_cell;
			
			middle_cell :  if i > 0 and i < N-1 GENERATE
				firstNAnd : And_nbits GENERIC MAP(N) PORT MAP(
					a(N-1 DOWNTO 0), b(i+1), S_AND(i)(N-1 DOWNTO 0)
				);
				
			FIRST_FA : NFullAdder GENERIC MAP(N) PORT MAP(
					C(i-1)(N DOWNTO 1), S_AND(i)(N-1 DOWNTO 0),'0',C(i)(N-1 DOWNTO 0),C(i)(N)
				);
				s(i) <= C(i-1)(0);
			end generate middle_cell;
			
			last_cell :  if i = N-1 GENERATE
				s((2*N)-1 DOWNTO N-1) <= C(N-2)(N DOWNTO 0);
			
			
			end generate last_cell;
		END GENERATE;	
		
	
	


END N_MULT_bhv;
