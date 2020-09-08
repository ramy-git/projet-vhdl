LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY FSM_V1 IS
	--FSM de 16 registres entrant
	port( 
	
		--Entrées
		IR : IN STD_LOGIC_VECTOR(11 DOWNTO 0); -- 12 + 1 bits de données entrantes
		clk, reset_n, run : std_logic; -- reset_n : mise à 0 de tous les registres
		
		--Sorties automate
		Done : OUT STD_LOGIC; -- sortie	qui indique que l'instruction est fini
		Erreur : OUT STD_LOGIC; -- sortie	qui indique que l'instruction s'est mal fini
		StateOutput : OUT STD_LOGIC_VECTOR(8 DOWNTO 0); --Signaux d'indication de l'état courant
		
		--Sortie multiplexer
		selectionnerMultiplexer : OUT STD_LOGIC_VECTOR(4 DOWNTO 0); --Nombre de 
		
		--Choix opérations ALU
		SelAlu : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
		
		--Sortie registre du processeur
		reset_registre : OUT STD_LOGIC_VECTOR(15 DOWNTO 0); -- Sortie registre de travail
		reset_registre_IR : OUT STD_LOGIC;
		reset_registre_G : OUT STD_LOGIC;
		reset_registre_A : OUT STD_LOGIC;
		
		set_registre : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);		
		set_registre_IR : OUT STD_LOGIC;
		set_registre_G : OUT STD_LOGIC;
		set_registre_A : OUT STD_LOGIC;
		
		--Sortie registre image 
		reset_registre_image : OUT STD_LOGIC;
		set_registre_image : OUT STD_LOGIC
	);
END FSM_V1;

ARCHITECTURE FSM_V1_bhv OF FSM_V1 Is
	--Declaration des composantes
	COMPONENT decodeurAdresseRegistre IS
		port( 	
			enable : IN STD_LOGIC;
			d_in : IN STD_LOGIC_VECTOR(3 DOWNTO 0);		
			s_out : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)		
	);
	END COMPONENT;
	
	--Declaration des signals
		--SIGNAL action, RX, RY: STD_LOGIC_VECTOR(2 DOWNTO 0);
	
	--Definition des différents états possibles (sachant que certain ne seront pas utilisé dans cette version)
	TYPE State_type IS (	AUTOMATE_INIT, -- automate de démarage
								AUTOMATE_DECODE,
								AUTOMATE_MVI,
								AUTOMATE_MV,
								AUTOMATE_FILL_A,
								AUTOMATE_OPERATION,
								AUTOMATE_OUT_G,
								AUTOMATE_IMAGE,
								AUTOMATE_RESET
							  );
	SIGNAL current_state, next_state: State_type;
		
	Signal decodeurEcritureRegistreEnable : STD_LOGIC;
	
	BEGIN
	 --Decodeur qui permet de modifier la valeur d'un registre
	decodeurEcritureRegistre : decodeurAdresseRegistre  PORT MAP (decodeurEcritureRegistreEnable, IR(7 DOWNTO 4),set_registre );
	
	--On ajoute les capteurs d'états 
	StateOutput(0)<='1' when current_state = AUTOMATE_INIT else '0';
	StateOutput(1)<='1' when current_state = AUTOMATE_DECODE else '0';
	StateOutput(2)<='1' when current_state = AUTOMATE_MVI else '0';
	StateOutput(3)<='1' when current_state = AUTOMATE_MV else '0';
	StateOutput(4)<='1' when current_state = AUTOMATE_FILL_A else '0';
	StateOutput(5)<='1' when current_state = AUTOMATE_OPERATION else '0';
	
	--%%%%%%%%%%%%% AUTOMATE %%%%%%%%%%%%%%%%%%%%
	-- Attention : on ne peut pas modifier le même state en parralèle
	
		--On sensibilise notre process uniquement au changement de l'état courant
		first_process : process(current_state, next_state, clk)
			BEGIN 
				case current_state is 
					--Automate decode : envoie sur le bon automate action à faire 

--%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%AUTOMATE INIT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
					when AUTOMATE_INIT=>
							--On met à jours IR
							set_registre_IR<='1';
							set_registre_G<='0';
							set_registre_A<='0';
							set_registre_image<='0';
							Done<='0';
							decodeurEcritureRegistreEnable<='0';
							selectionnerMultiplexer(4 DOWNTO 0)<="-----"; 
							
							--Etape 1 : on lit la commande 
							
							if IR(3 DOWNTO 0)="0000" then --Action stay
								--On reste dans l'état courant jusqu'a ce qu'une commande soit disponibleS
								next_state<=AUTOMATE_INIT;
								
							else
								next_state<=AUTOMATE_DECODE;
							end if;
							
--%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%AUTOMATE DECODE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%							
					when AUTOMATE_DECODE =>
						--On bloque le registre IR
						set_registre_IR<='0';
						
						if IR(3 DOWNTO 0)="0001" then --VIDE
						
						elsif IR(3 DOWNTO 0)="0010" then --JUMP
							
						elsif IR(3 DOWNTO 0)="0011" then --DISPLAY
							next_state<=AUTOMATE_IMAGE;
						elsif IR(3 DOWNTO 0)="0100" then --Action MV RX RY
							next_state<=AUTOMATE_MV;
						elsif IR(3 DOWNTO 0)="0101" then -- Action MVI
							next_state<=AUTOMATE_MVI;
						elsif IR(3 DOWNTO 0)="0110" then -- Action LOAD
							
						elsif IR(3 DOWNTO 0)="0111" then -- Action STORE
						
						elsif IR(3)='1' then -- Action ADD,SUB,OR,AND,NOT
							next_state<=AUTOMATE_FILL_A;
						else
							next_state<=AUTOMATE_INIT;
						end if;
						
--%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%AUTOMATE MVI %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%							
					when AUTOMATE_MVI =>
						--On selectionne le Din sur le multiplexeur. Code du Din est 10000
						selectionnerMultiplexer(4 DOWNTO 0)<="10000"; 
						
						--on donne la valeur Din Au registre selectionné, valeur = IR(7 DOWNTO 5) 	
						decodeurEcritureRegistreEnable<='1';
						Done<='1';
						next_state<=AUTOMATE_INIT;
						
--%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%AUTOMATE MV %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%							
					when AUTOMATE_MV =>						
						--Ou ouvre le registre destination IR 7 downto 4
						decodeurEcritureRegistreEnable<='1';

						--On selectionne le registre cible sur le multiplexeur. Code du Din est 00000
						selectionnerMultiplexer(3 DOWNTO 0)<=IR(11 DOWNTO 8);  
						selectionnerMultiplexer(4)<='0';  
						Done<='1';
						next_state<=AUTOMATE_INIT;
						
					when AUTOMATE_FILL_A =>
						--Etape 1 : on rempli le registre A
						selectionnerMultiplexer(3 DOWNTO 0)<=IR(7 DOWNTO 4);
						selectionnerMultiplexer(4)<='0';
						
						set_registre_A<='1';
						next_state<=AUTOMATE_OPERATION;
						
					when AUTOMATE_OPERATION =>
						--On ferme le registre A
						set_registre_A<='0';
						--On ouvre le registre G
						set_registre_G<='1';
						--Etape 1 : ON envoie à l'alu, la deuxième donnée, le registre à et les bits d'opérations.
						selectionnerMultiplexer(3 DOWNTO 0)<=IR(11 DOWNTO 8);
						SelAlu(3 DOWNTO 0)<=IR(3 DOWNTO 0);
						
						Done<='0';
						next_state<=AUTOMATE_OUT_G;
					when AUTOMATE_OUT_G =>
						set_registre_G<='0';
						--On selectionne le G sur le multiplexeur.
						selectionnerMultiplexer(4 DOWNTO 0)<="10001"; 
						
						--on donne la valeur G Au registre selectionné, valeur = IR(7 DOWNTO 5) 	
						decodeurEcritureRegistreEnable<='1';
						Done<='1';
						next_state<=AUTOMATE_INIT;
--%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%AUTOMATE IMAGE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%												
					when AUTOMATE_IMAGE=>
						set_registre_image<='1';

						--On selectionne le registre cible sur le multiplexeur. Code du Din est 00000
						selectionnerMultiplexer(3 DOWNTO 0)<=IR(11 DOWNTO 8);  
						selectionnerMultiplexer(4)<='0';  
						
						Done<='1';						
						next_state<=AUTOMATE_INIT;
--%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%AUTOMATE AUTRE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%							
					when AUTOMATE_RESET=>
						
						next_state<=AUTOMATE_INIT;
					when others =>
						next_state<=current_state; --On peut continuer l'automate
					----------------------------------------					
				end case;
		end process first_process;
		
		
		
		
	--%%%%%%%%%%%%% FLIP FLOP %%%%%%%%%%%%%%%%%%%%
		
		cadenceur : process(clk, reset_n, run, next_state)
			BEGIN
				if reset_n = '1' then	 --reset asynchrone
					--On doit remettre tous les registres à 0 pour réinitialiser le système -> surement nécéssaire de créer un état pour
					--Registre mémoire
					
					for i in 0 TO 16-1 loop
						reset_registre(i)<='1';
					end loop;
					
					--registre R,G,A
					reset_registre_IR<='1';
					reset_registre_G<='1';
					reset_registre_A<='1';
					reset_registre_image<='1';
					
					
				elsif reset_n = '0' then 
					for i in 0 TO 16-1 loop
							reset_registre(i)<='0';
						end loop;
						reset_registre_IR<='0';
						reset_registre_G<='0';
						reset_registre_A<='0';
						reset_registre_image<='0';
				end if;
				
				if (reset_n = '1') then
						current_state <= AUTOMATE_INIT;
				elsif (rising_edge(clk) and run = '1') then 
						--Dans ce cas, on change d'instruction
						current_state <= next_state;
				end if;
		end process cadenceur;	
	
	
	
END FSM_V1_bhv;
