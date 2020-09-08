LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY memoireInstruction IS
	PORT(
		MemoryClock : IN STD_LOGIC;
		Reset_n : IN STD_LOGIC;	
		EntreePC : IN STD_LOGIC_VECTOR (4 DOWNTO 0);
		enablePC : IN STD_LOGIC;
		
		valeurPC : OUT STD_LOGIC_VECTOR (4 DOWNTO 0);
		DOUT : OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
	);
	
END memoireInstruction;

ARCHITECTURE memoireInstruction_bhw OF memoireInstruction IS
	
	COMPONENT registreNBits IS 
		generic(N : positive :=8);
		Port (
			d : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
			en, ck, n_reset : IN STD_LOGIC;
			q : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0)
		);
	END COMPONENT;
	
	component ROM
	PORT
	(
		address		: IN STD_LOGIC_VECTOR (4 DOWNTO 0);
		clock		: IN STD_LOGIC  := '1';
		q		: OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
	);
	end component;
	
	--Etape 1 : construction du PC 
	SIGNAL SortiePC : STD_LOGIC_VECTOR (4 DOWNTO 0);
	
	BEGIN
	
	valeurPC <=SortiePC;
	
	PC : registreNBIts GENERIC MAP(5) PORT MAP(EntreePc, enablePC, MemoryClock, Reset_n, SortiePC);
	MemoireInstruction : ROM PORT MAP (SortiePC, MemoryClock, DOUT);
	

END memoireInstruction_bhw;