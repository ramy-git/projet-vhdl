LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY decodeurAdresseRegistre_TB IS

END decodeurAdresseRegistre_TB;

ARCHITECTURE decodeurAdresseRegistre_TB_bhv OF decodeurAdresseRegistre_TB Is
	COMPONENT decodeurAdresseRegistre IS
		port( 		
			enable : IN STD_LOGIC;
			d_in : IN STD_LOGIC_VECTOR(3 DOWNTO 0);		
			s_out : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)		
		);
	END COMPONENT;
	
	SIGNAL enable : STD_LOGIC;
	SIGNAL d_in : STD_LOGIC_VECTOR(3 DOWNTO 0);		
	SIGNAL s_out : STD_LOGIC_VECTOR(15 DOWNTO 0);	
		
BEGIN
	
	decodeur : decodeurAdresseRegistre PORT MAP(enable,d_in,s_out); 
	
	first_test : process
			BEGIN 

			enable<='1';
			d_in<="0000";
			wait for 20 ns;
			
			d_in<="0001";
			wait for 20 ns;
			
			d_in<="0010";
			wait for 20 ns;
			
			d_in<="0011";
			wait for 20 ns;
			
			d_in<="0100";
			wait for 20 ns;
			
			d_in<="1000";
			wait for 20 ns;
			
			d_in<="1001";
			wait for 20 ns;
			
			d_in<="1010";
			wait for 20 ns;
			
			d_in<="1011";
			wait for 20 ns;
			
			d_in<="1100";
			wait for 20 ns;
			
			d_in<="1101";
			wait for 20 ns;
			
			d_in<="1110";
			wait for 20 ns;
			
			d_in<="1111";
			wait for 20 ns;
			
			enable<='0';
			d_in<="0000";
			wait for 20 ns;
			
			d_in<="0001";
			wait for 20 ns;
			
			d_in<="0010";
			wait for 20 ns;
			
			d_in<="0011";
			wait for 20 ns;
			
			d_in<="0100";
			wait for 20 ns;
			
			d_in<="1000";
			wait for 20 ns;
			
			d_in<="1001";
			wait for 20 ns;
			
			d_in<="1010";
			wait for 20 ns;
			
			d_in<="1011";
			wait for 20 ns;
			
			d_in<="1100";
			wait for 20 ns;
			
			d_in<="1101";
			wait for 20 ns;
			
			d_in<="1110";
			wait for 20 ns;
			
			d_in<="1111";
			wait for 20 ns;
			
			
			
			end process first_test;
	

END decodeurAdresseRegistre_TB_bhv;
