LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY basculeD IS
	PORT(
		d : IN STD_LOGIC;
		en, ck, n_reset : IN STD_LOGIC;
		q : OUT STD_LOGIC
	);
	
END basculeD;

ARCHITECTURE basculeD_bhw OF basculeD IS
	BEGIN
		PROCESS (ck, n_reset)
		BEGIN	
			IF n_reset='1' THEN
				q<='0';
			ELSE			
				IF RISING_EDGE(ck) AND en = '1' THEN
					q<=d;
				END IF;
			END IF;
		END PROCESS;
END basculeD_bhw;