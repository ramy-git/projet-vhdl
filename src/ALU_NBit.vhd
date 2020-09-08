LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY ALU_NBit IS
	GENERIC(N : POSITIVE :=8);
	PORT ( 
		a0, a1 : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
		sel : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		s : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0)
	);
END ALU_NBit;

ARCHITECTURE ALU_NBit_bhv OF ALU_NBit Is

	COMPONENT N_MULT IS
	GENERIC(N : POSITIVE :=8);
	PORT ( 
		a, b : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
		cin : IN STD_LOGIC_VECTOR(N-2 DOWNTO 0);
		s : OUT STD_LOGIC_VECTOR( (2*N)-1 DOWNTO 0)

	);
	END COMPONENT;
	
	COMPONENT NFullAdder IS
	generic(N : positive := 8);
	port(
		x, y: IN STD_LOGIC_VECTOR(N-1 DOWNTO 0); --Données entrantes 
		cin : IN STD_LOGIC;
		s : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0); -- Sortie
		cout : OUT STD_LOGIC);
	END COMPONENT;
	
	COMPONENT Mult_16_1_4Nbit IS
	GENERIC(N : POSITIVE :=8);
	PORT ( 
		a0, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15 : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
		sel : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		s : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0)

	);
	END COMPONENT;
	
	SIGNAL adition : STD_LOGIC_VECTOR(N-1 DOWNTO 0);
	SIGNAL soustraction : STD_LOGIC_VECTOR(N-1 DOWNTO 0);
	SIGNAL soustraction2 : STD_LOGIC_VECTOR(N-1 DOWNTO 0);
	SIGNAL multiplication : STD_LOGIC_VECTOR((2*N)-1 DOWNTO 0);
	SIGNAL et : STD_LOGIC_VECTOR(N-1 DOWNTO 0);
	SIGNAL ou : STD_LOGIC_VECTOR(N-1 DOWNTO 0);
	SIGNAL non : STD_LOGIC_VECTOR(N-1 DOWNTO 0);
	
	SIGNAL overflow : STD_LOGIC_VECTOR(N-1 DOWNTO 0);
	SIGNAL zero : STD_LOGIC_VECTOR(N-1 DOWNTO 0);
	
	BEGIN
		generation : FOR i IN 0 TO N-1 GENERATE
			zero(i) <= '0';
		END GENERATE;
	
		add : NFullAdder GENERIC MAP (N) PORT MAP(
			a0,a1,'0',adition, overflow(0)
		);	
		
		sous : NFullAdder GENERIC MAP (N) PORT MAP(
			a0,a1,'1',soustraction, overflow(1)
		);
		
		mult : N_MULT GENERIC MAP (N) PORT MAP(
			a0,a1,zero(N-2 DOWNTO 0),multiplication
		);

		cell_array : FOR i IN 0 TO N-1 GENERATE
			et(i) <= a0(i) AND a1(i);
			ou(i) <= a0(i) OR a1(i);
			non(i) <= NOT a0(i);
			soustraction2(i) <= NOT soustraction(i);
	
		END GENERATE;
		
		mux : Mult_16_1_4Nbit GENERIC MAP (N) PORT MAP(
			zero,zero,zero,zero,zero,zero,zero,zero,
			adition,soustraction,multiplication(N-1 DOWNTO 0),zero,et,ou,non,zero,
			sel,s
		);

END ALU_NBit_bhv;