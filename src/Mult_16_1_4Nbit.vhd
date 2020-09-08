LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY Mult_16_1_4Nbit IS
	GENERIC(N : POSITIVE :=8);
	PORT ( 
		a0, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15 : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
		sel : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		s : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0)

	);
END Mult_16_1_4Nbit;

ARCHITECTURE Mult_16_1_4Nbit_bhv OF Mult_16_1_4Nbit Is

	COMPONENT Mult_2_1_Nbit IS
		GENERIC(N : POSITIVE :=8);
		PORT ( 
			a0, a1 : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
			sel : IN STD_LOGIC;
			s : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0)
		);
	END COMPONENT;
	
	TYPE CABLE  IS array(15 DOWNTO 0) of STD_LOGIC_VECTOR(N-1 DOWNTO 0);
	SIGNAL f : CABLE;
	
	BEGIN
	
	mux_0 : Mult_2_1_Nbit GENERIC MAP(N) PORT MAP(
			a0,a1,sel(0),f(0)
	);
	
	mux_1 : Mult_2_1_Nbit GENERIC MAP(N) PORT MAP(
			a2,a3,sel(0),f(1)
	);
	
	mux_2 : Mult_2_1_Nbit GENERIC MAP(N) PORT MAP(
			a4,a5,sel(0),f(2)
	);
	
	mux_3 : Mult_2_1_Nbit GENERIC MAP(N) PORT MAP(
			a6,a7,sel(0),f(3)
	);
	
	mux_4 : Mult_2_1_Nbit GENERIC MAP(N) PORT MAP(
			a8,a9,sel(0),f(4)
	);
	
	mux_5 : Mult_2_1_Nbit GENERIC MAP(N) PORT MAP(
			a10,a11,sel(0),f(5)
	);
	
	mux_6 : Mult_2_1_Nbit GENERIC MAP(N) PORT MAP(
			a12,a13,sel(0),f(6)
	);
	
	mux_7 : Mult_2_1_Nbit GENERIC MAP(N) PORT MAP(
			a14,a15,sel(0),f(7)
	);
	
	mux_8 : Mult_2_1_Nbit GENERIC MAP(N) PORT MAP(
			f(0),f(1),sel(1),f(8)
	);
	
	mux_9 : Mult_2_1_Nbit GENERIC MAP(N) PORT MAP(
			f(2),f(3),sel(1),f(9)
	);

	mux_10 : Mult_2_1_Nbit GENERIC MAP(N) PORT MAP(
			f(4),f(5),sel(1),f(10)
	);
	
	mux_11 : Mult_2_1_Nbit GENERIC MAP(N) PORT MAP(
			f(6),f(7),sel(1),f(11)
	);
	
	mux_12 : Mult_2_1_Nbit GENERIC MAP(N) PORT MAP(
			f(8),f(9),sel(2),f(12)
	);
	
	mux_13 : Mult_2_1_Nbit GENERIC MAP(N) PORT MAP(
			f(10),f(11),sel(2),f(13)
	);
	
	mux_14 : Mult_2_1_Nbit GENERIC MAP(N) PORT MAP(
			f(12),f(13),sel(3),s
	);

END Mult_16_1_4Nbit_bhv;
