----------------------------------------------------------------------------|
-- Author		: Miguel Morales-Sandoval Copyrights (R)	                |
-- Project		: " Reconfigurable ECC" 					                |
-- Organization	: INAOE, Computer Science Department		                |
-- Date			: Originally created March, 2007.			                |
----------------------------------------------------------------------------|
--         / o      o \				 This is the binary method to compute	|
--        / - o    o - \			 scalar multiplication in affine 		|
--       / --- o  o --- \			 coordinates. It uses a module that		|
--      / ---- o  o ---- \			 implements the ECC-ADD and ECC-DOUBLE	|
--     /------ o  o ----- \			 at the same time. The operations are	|
--    / ----- o    o ----- \		 performed serially. This is a m- bit 	|
--    / o o o        o o o \		 implementation.						|
--            x x x															|
--          x ----- x														|
--         x ------- x														|
--        x --------- x														|
--        x --------- x														|
--        -------------														|
--   _  _   _    _    ___  ___												|
--  | || \ | | / _ \ | _ || __|												|
--  | ||  \| || |_| ||| ||||__												|
--  | || \ | ||  _  |||_||||__												|
--  |_||_|\__||_| |_||___||___|												|
----------------------------------------------------------------------------|
library IEEE; 
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;	
use IEEE.std_logic_arith.all;

entity binaryMethod is
	generic(  	 
		--------------------------------------------------------------
		-- para la entrada y salida
		CW		 : positive := 15;	-- 15   29  29,   23,   11,    5,   7,   5   	:- bits que "faltan" para ser multiplo de 32
		WORD	 : positive := 32; 	-- 32   32  32,   32,   32,   32,  32,  32   	:- Numero de palabra de entrada 
		ITR		 : positive := 4; 	-- 4    5    6,     8,    9,    9,  13,  18   	:- No. de iteraciones en la máquina de estados
		-------------------------------------------------------------- 
								  -- 113   131  163,   233,  277,  283, 409, 571	
	    -- para el squarer
		--------------------------------------------------------------
	--	D		 : positive := 11; 	-- 11   10    9,	76,	   14, 	 14,  89,  12	 	-- el "grado mas grande" para el polinomio en el campo m + 2
	--	NUM2_BITS: positive := 225;	--225  261  325,	465,  553,	565, 817, 1141 	    -- 2*NUMBITS -1									
		--------------------------------------------------------------
	    							--113  131  163, 233,  277,  283, 409, 571			
		-- El nivel de seguridad
		NUM_BITS: positive := 113
	);
	port(  
		valid_data_in  	:in std_logic; 	
		valid_data_out 	:out std_logic; 
		
		ack_master 		:in std_logic;
		ack_slave		:out std_logic;
			
		data_in   		: in std_logic_vector(WORD-1 downto 0); 
		data_out  		: out std_logic_vector(WORD-1 downto 0); 
		
		op		  		: in std_logic;										-- 0 -> Scalar multiplication, 1 -> SUM of points
		clk 	  		: in std_logic;
		rst 	  		: in std_logic
	);												 
end;
------------------------------------------------------------------
architecture behave of BinaryMethod is
------------------------------------------------------------------
-- se agregaron mas estados para controlar la carga de los 
-- operadores de la multiplicación escalar o de la suma

type CurrentState_type is (END_STATE, WAIT_DATA, WAIT_MORE, SEND_MORE, SEND_DATA, MODE0, WAIT_FINISH);
signal CurrentState: CurrentState_type;
------------------------------------------------------------------
signal Q_X: std_logic_vector(NUM_BITS-1 downto 0); 	  				-- Registros para manterner las operaciones ADD y Double
signal Q_Y: std_logic_vector(NUM_BITS-1 downto 0); 	 
signal P_X: std_logic_vector(NUM_BITS-1 downto 0); 	  
signal P_Y: std_logic_vector(NUM_BITS-1 downto 0); 	  
signal counter: std_logic_vector(7 downto 0);		  				-- Counter, indicates the number of iterations (m)
------------------------------------------------------------------
signal RstADD : std_logic; 							  				-- Interface signals for the ADD-Double module
signal ADD_X  : std_logic_vector(NUM_BITS-1 downto 0);  
signal ADD_Y  : std_logic_vector(NUM_BITS-1 downto 0); 
signal DoneADD: std_logic;
signal op_ADD: std_logic;
------------------------------------------------------------------
signal internal_regk : std_logic_vector(NUM_BITS-1 downto 0); 		-- Register to keep the shifth value of the scalar
signal K_SHIFT       : std_logic_vector(NUM_BITS-1 downto 0); 		-- The combinatorial shifter for the scalar
------------------------------------------------------------------
-- Estas señales se agregaron para controlar y carga y salida de 
-- valores desde/hacia el modulo KP
signal B_x_in		: std_logic_vector((NUM_BITS+CW)-1 downto 0); 	-- 1 Registros de NUM_BITS bits para el siguiente corrimiento
signal B_X_shift	: std_logic_vector((NUM_BITS+CW)-1 downto 0); 	-- Corrimiento combinacional
signal counter_word : std_logic_vector(4 downto 0); 				-- Contador para la carga del dato 

signal mux_input : std_logic_vector(WORD-1 downto 0); 				-- Contador para la carga del dato
------------------------------------------------------------------

begin			
	
------------------------------------------------------------------
-- The ADD module
	ECC_ADD: entity ECC_add_serial_113(behave) 	
		--Generic Map (D, NUM2_BITS, NUM_BITS)
		Generic Map (NUM_BITS)
		Port Map(Q_X, Q_Y, P_X, P_Y, clk, RstADD, op_ADD, ADD_X, ADD_Y, DoneADD);		
		

k_shift   <= internal_regk(NUM_BITS-2 downto 0) & '0';				-- Shift the scalar every time 

mux_input <= data_in when currentState = WAIT_DATA else
			(others => '0');
	
B_x_shift <= B_x_in((NUM_BITS+CW)-WORD-1 downto 0) & mux_input;

data_out  <= B_x_in(NUM_BITS+CW-1 downto NUM_BITS+CW-WORD);											

------------------------------------------------------------------
-- Finite state machine that implements the LEFT-TO-RIGTH
-- binary method, ADD and DOUBLING are performed serially
------------------------------------------------------------------

SCALAR_MUL_FSM: process (CLK)
	Begin											-- Inferencias de 6 registros de m y m+CW bits						
		if CLK'event and CLK = '1' then
			if Rst = '1' then						-- synchronous reset
				Q_X <= (others => '0');				-- registros internos
				Q_Y <= (others => '0');				-- para suma y double
				P_X <= (others => '0');	
				P_Y <= (others => '0');
				B_x_in <= (others => '0');
				internal_regk <= (others => '0');	-- registro de corrimiento del escalar k
			
				RstADD <= '0';						-- Señales de control para los bloques ADD y DOUBLE
				counter_word <= (others => '0');	-- contador para capturar las palabras de entrada
				counter <= (others => '0');			-- contador para la multiplicación escalar
				CurrentState <= WAIT_DATA;			-- El estado para esperar la primera secuencia de WORDS
				
				ack_slave <= '0';
		   		valid_data_out <= '0';				-- Señal de salida que habilida WORDs validos a la salida
				
		    else
				case CurrentState is													  
				----------------------------------------------------
					when WAIT_DATA =>
						if valid_data_in = '1' then
							
							B_X_in 		 <= B_x_shift;
							
							ack_slave <= '1';  				
							
							if counter_word = "00100" then	            			-- ITR
								P_X <= B_X_in(NUM_BITS-1 downto 0);	
								CurrentState <= WAIT_MORE;
								
							elsif counter_word = "01000" then						-- 2*ITR
								P_Y <= B_X_in(NUM_BITS-1 downto 0);
								CurrentState <= WAIT_MORE;
								
							elsif counter_word = "01100" then						-- 3*ITR
								if op = '0'	then									-- multiplicación escalar
									internal_regk <= B_x_in(NUM_BITS-1 downto 0); 	-- Lo que se leyo es el escalar, comenzar a ejecutar kP
									op_ADD <= '0'; 									--Double
									RstADD <= '1'; 							
									CurrentState <= MODE0;	
								else
									Q_x <= B_X_in(NUM_BITS-1 downto 0);
									CurrentState <= WAIT_MORE;	
									
								end if;	
									
							elsif counter_word = "10000" then						--4*ITR
								Q_Y <= B_X_in(NUM_BITS-1 downto 0);  				-- Ya tenemos los dos puntos, hacemos la suma						
								op_ADD <= '1'; 										--ADD
								RstADD <= '1'; 							
								CurrentState <= MODE0;	
							else
								CurrentState <= WAIT_MORE;
							end if;
					
						end if;
				----------------------------------------------------		
				when WAIT_MORE => 													-- Espera a que el host regrese subtype señal de dato valido a cero
					if valid_data_in = '0' then
						ack_slave <= '0';
						CurrentState <= WAIT_DATA;
						Counter_word <= Counter_word + "00001";							
					end if;
					
				----------------------------------------------------
				when MODE0 =>	  					
					RstADD <= '0';													-- Emite el pulso al Modulo de suma y espera a que termine la operacion				
					CurrentState <= WAIT_FINISH;

				----------------------------------------------------
				when WAIT_FINISH =>						
				
					if DoneADD = '1' then 											-- Espera hasta que la operacion ADD termina
												
						if op = '1' then											-- solo esta suma, terminar
							B_x_in <= "000000000000000" & ADD_X;
							counter_word <= (others => '0');
							CurrentState <= SEND_DATA;		
							valid_data_out <= '1';						
							
						else
							Q_X <= ADD_X; 											-- Almacenar el resultado actual
							Q_Y <= ADD_Y;										
							if internal_regk(NUM_BITS-1) = '1' and op_ADD = '0' then-- se comienza una nueva operacion si es qu es necesario realizar una suma
								op_ADD <= '1';										 -- add
								RSTADD <= '1';	   		   										
								CurrentState <= MODE0;  										
							else
								counter <= counter + 1;								-- incrementa el counter para indicar que ya se consumio un bit del escalar
								if counter = "01110000" then						--112 = NUM_BITS-1, if all iterations has been performed, then the operation is compleated
									B_x_in <= "000000000000000" & ADD_X;
									counter_word <= (others => '0');
									valid_data_out <= '1';
									CurrentState <= SEND_DATA;
								else												-- if not all iterations have been performed, do the following
									internal_regk <= k_shift;   					-- update the scalar shifted
									op_ADD <= '0';									-- operacion double
									RstADD <= '1';									-- double	
									CurrentState <= MODE0;										
								end if;
							end if;			  		
						end if;	
					end if;													
				----------------------------------------------------
				
				when SEND_DATA =>             										-- ya hay una palabra valida a la salida, esperar a que el host la lea
				--espera el ack del receptor 
					if ack_master = '1'	then												
						Counter_word <= Counter_word + "00001";
						valid_data_out <= '0';
						CurrentState <= SEND_MORE;						
					end if;
				
				----------------------------------------------------
				when SEND_MORE =>             										-- pone una palabra valida mas
					if ack_master = '0' then		
						if counter_word = "00100" then		    					-- ITR = 4   
							B_x_in <= "000000000000000" & ADD_Y;
							valid_data_out <= '1';
							CurrentState <= SEND_DATA;						  
						elsif counter_word = "01000" then	    					-- 2*ITR = 8   
							CurrentState <= END_STATE;						  
						else							
							B_x_in <= B_x_shift;
							valid_data_out <= '1';
							CurrentState <= SEND_DATA;						  
						end if;	
					end if;
				
				when END_STATE => 													-- do nothing, wait until the reset signal goes to '1'
					valid_data_out <= '0';						
			
				----------------------------------------------------
				when others =>
					null;
			end case;
		end if;
	end if;	
end process;

end behave;