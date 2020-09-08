LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY Mult_32_1_Nbit IS
	GENERIC(N : POSITIVE :=8);
	PORT ( 
		a0, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15 : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
		a16, a17, a18, a19, a20, a21, a22, a23, a24, a25, a26, a27, a28, a29, a30, a31 : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
		sel : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		s : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0)

	);
END Mult_32_1_Nbit;

ARCHITECTURE Mult_32_1_Nbit_bhv OF Mult_32_1_Nbit Is
	COMPONENT Mult_16_1_4Nbit IS
		GENERIC(N : POSITIVE :=8);
		PORT ( 
			a0, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15 : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
			sel : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			s : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0)

		);
	END COMPONENT;
	
	COMPONENT Mult_2_1_Nbit IS
	GENERIC(N : POSITIVE :=8);
		PORT ( 
			a0, a1 : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
			sel : IN STD_LOGIC;
			s : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0)

		);
	END COMPONENT;
	
	SIGNAL sortieMult1, sortieMult2 : STD_LOGIC_VECTOR(N-1 DOWNTO 0);
	
	BEGIN
	
	mult_1 : Mult_16_1_4Nbit GENERIC MAP(16) PORT MAP(a0, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15,
																			sel(3 DOWNTO 0),
																			sortieMult1
																		);
																		
	mult_2 : Mult_16_1_4Nbit GENERIC MAP(16) PORT MAP(a16, a17, a18, a19, a20, a21, a22, a23, a24, a25, a26, a27, a28, a29, a30, a31,
																			sel(3 DOWNTO 0),
																			sortieMult2
																		);
																		
	mult_3 : Mult_2_1_Nbit GENERIC MAP(16) PORT MAP(sortieMult1, sortieMult2, sel(4),s);
																		
																		
END Mult_32_1_Nbit_bhv;
