LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY ALU_NBit_TB IS

END ALU_NBit_TB;

ARCHITECTURE ALU_NBit_TB_bhv OF ALU_NBit_TB Is

	COMPONENT ALU_NBit IS
			GENERIC(N : POSITIVE :=8);
			PORT ( 
				a0, a1 : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
				sel : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
				s : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0)
			);
	END COMPONENT;	
		
	SIGNAL a0, a1 : STD_LOGIC_VECTOR(16-1 DOWNTO 0);
	SIGNAL sel : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL s : STD_LOGIC_VECTOR(16-1 DOWNTO 0);		
	
	BEGIN		
	
	ALU : ALU_NBit GENERIC MAP (16) PORT MAP(a0,a1,sel,s);	
		
	--Pour faire fonctionner le test, il suffit d'indiquer des valeurs à la FSM
	--via les cables imput uniquement
	first_test : process
			BEGIN 
			--Calcul 1 : 0+0
				sel<="0000";
				
				a0<="0000000000000000";
				a1<="0000000000000000";
			wait for 40 ns;
				a0<="0000000000000001";
				a1<="0000000000000000";
				
			wait for 40 ns;
				a0<="0000000000000001";
				a1<="0000000000000000";
				
			wait for 40 ns;
				a0<="0000000000000001";
				a1<="0000000000000001";
				
			wait for 40 ns;
				a0<="1111111111111111";
				a1<="0000000000000000";	

				sel<="0001";
				
				a0<="0000000000000000";
				a1<="0000000000000000";
			wait for 40 ns;
				a0<="0000000000000001";
				a1<="0000000000000000";
				
			wait for 40 ns;
				a0<="0000000000000001";
				a1<="0000000000000000";
				
			wait for 40 ns;
				a0<="0000000000000001";
				a1<="0000000000000001";
				
			wait for 40 ns;
				a0<="1111111111111111";
				a1<="0000000000000000";	
				
				
				sel<="0010";
				
				a0<="0000000000000000";
				a1<="0000000000000000";
			wait for 40 ns;
				a0<="0000000000000001";
				a1<="0000000000000000";
				
			wait for 40 ns;
				a0<="0000000000000001";
				a1<="0000000000000000";
				
			wait for 40 ns;
				a0<="0000000000000001";
				a1<="0000000000000001";
				
			wait for 40 ns;
				a0<="1111111111111111";
				a1<="0000000000000000";	
				
				sel<="0011";
				
				a0<="0000000000000000";
				a1<="0000000000000000";
			wait for 40 ns;
				a0<="0000000000000001";
				a1<="0000000000000000";
				
			wait for 40 ns;
				a0<="0000000000000001";
				a1<="0000000000000000";
				
			wait for 40 ns;
				a0<="0000000000000001";
				a1<="0000000000000001";
				
			wait for 40 ns;
				a0<="1111111111111111";
				a1<="0000000000000000";	
				
				sel<="0100";
				
				a0<="0000000000000000";
				a1<="0000000000000000";
			wait for 40 ns;
				a0<="0000000000000001";
				a1<="0000000000000000";
				
			wait for 40 ns;
				a0<="0000000000000001";
				a1<="0000000000000000";
				
			wait for 40 ns;
				a0<="0000000000000001";
				a1<="0000000000000001";
				
			wait for 40 ns;
				a0<="1111111111111111";
				a1<="0000000000000000";	

				sel<="0101";
				
				a0<="0000000000000000";
				a1<="0000000000000000";
			wait for 40 ns;
				a0<="0000000000000001";
				a1<="0000000000000000";
				
			wait for 40 ns;
				a0<="0000000000000001";
				a1<="0000000000000000";
				
			wait for 40 ns;
				a0<="0000000000000001";
				a1<="0000000000000001";
				
			wait for 40 ns;
				a0<="1111111111111111";
				a1<="0000000000000000";	
				
				sel<="0110";
				
				a0<="0000000000000000";
				a1<="0000000000000000";
			wait for 40 ns;
				a0<="0000000000000001";
				a1<="0000000000000000";
				
			wait for 40 ns;
				a0<="0000000000000001";
				a1<="0000000000000000";
				
			wait for 40 ns;
				a0<="0000000000000001";
				a1<="0000000000000001";
				
			wait for 40 ns;
				a0<="1111111111111111";
				a1<="0000000000000000";	
	end process first_test;
	

END ALU_NBit_TB_bhv;
