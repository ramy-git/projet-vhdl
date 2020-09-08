LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY memoireInstruction_TB IS
	
END memoireInstruction_TB;

ARCHITECTURE memoireInstruction_TB_bhw OF memoireInstruction_TB IS
	COMPONENT memoireInstruction IS
		PORT(
			MemoryClock : IN STD_LOGIC;
			Reset_n : IN STD_LOGIC;	
			EntreePC : IN STD_LOGIC_VECTOR (4 DOWNTO 0);
			enablePC : IN STD_LOGIC;
			
			valeurPC : OUT STD_LOGIC_VECTOR (4 DOWNTO 0);
			DOUT : OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
		);
	END COMPONENT;
	
	SIGNAL MemoryClock : STD_LOGIC;
	SIGNAL Reset_n : STD_LOGIC;	
	SIGNAL EntreePC : STD_LOGIC_VECTOR (4 DOWNTO 0);
	SIGNAL enablePC : STD_LOGIC;
	SIGNAL valeurPC : STD_LOGIC_VECTOR (4 DOWNTO 0);
	SIGNAL DOUT : STD_LOGIC_VECTOR (15 DOWNTO 0);
	
	BEGIN

	memoire : memoireInstruction PORT MAP(MemoryClock, Reset_n, EntreePC, enablePC, valeurPC, DOUT);
	
	first_test : process
			BEGIN 
			EntreePC<="00000";
			enablePC<='1';
			
			MemoryClock<='1';
			wait for 20 ns;
			MemoryClock<='0';
			wait for 20 ns;

			
	end process first_test;
	

END memoireInstruction_TB_bhw;