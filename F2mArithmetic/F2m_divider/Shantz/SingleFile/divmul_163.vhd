-- Este bloque puede realizar la inversion de un elemento de F2m 
-- o la multiplicación de dos elementos de F2m. Dicha operacion  
-- es determinada por una señal de entrada. La inversión se realiza 
-- implementando el Teorema de Fermat como una máquina de estados, 
-- la multiplicación se realiza en m/4 ciclos de reloj con el 
-- multiplicador serial a nivel de digito.
----------------------------------------------------------------
library IEEE; 
----------------------------------------------------------------
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;	
use IEEE.std_logic_arith.all;
----------------------------------------------------------------
entity inv_mul is
	generic(   		
		NUM_BITS : positive := 163
	);
	port(	  
		A_x		: in std_logic_vector(NUM_BITS-1 downto 0);	 
		B_x		: in std_logic_vector(NUM_BITS-1 downto 0);	
		clk		: in std_logic;	
		rst		: in std_logic;		 
		op	      : in std_logic;
		C_x		: out std_logic_vector(NUM_BITS-1 downto 0);
		done	: out std_logic		
	);												 
end;
--------------------------------------------------------------
architecture behave of inv_mul is
--------------------------------------------------------------
-- Para la máquina de estados
type CurrentState_type is (END_STATE, SPEND_CYCLE1, SPEND_CYCLE2, WAIT_MUL, LAST_MUL);
signal CurrentState: CurrentState_type;

-- Señales de control para el multiplicador serial a nivel de digito
signal doneMul, rstMul : std_logic;	
signal MUL, MUX1, MUX3 : std_logic_vector(NUM_BITS-1 downto 0);

signal counter: std_logic_vector(7 downto 0);

signal  REG_Bx, MUX2, SQR: std_logic_vector(NUM_BITS-1 downto 0);

begin	
	
	MULTIPLIER1: ENTITY work.serial_multiplier_163(behave) 
	Generic Map (NUM_BITS)
	PORT MAP(MUX1,MUX3, MUL, rstMul, clk, doneMul);
		
	SQUARER1: ENTITY work.squarer_163(behave) 
	Generic Map (9,325,NUM_BITS)
	PORT MAP(REG_Bx,SQR);


MUX1 <= B_x when op = '0' or CurrentState = LAST_MUL else -- solo cuando es una multiplicacion o se trata de la ultima multiplicacion
	     A_x;

MUX2 <= A_x when rst = '1' else 
        MUL;
		
MUX3 <= SQR when op = '1' else 		-- siempre que se trate de una division, de lo contrario Ax
        A_x;
		  
		  
	SEQ_PROC: process (CLK)
	Begin						
		if CLK'event and CLK = '1' then
			if rst = '1' then				-- Se debe asegurar que al llegar la señal rst, los datos a la entrada son validos
				C_x <= (others => '0');
				Counter <= (others => '0');
				Done <= '0'; 

				rstMul <= '1';
								
				if op = '1' then  --division
					REG_Bx <= MUX2;
					CurrentState <= SPEND_CYCLE2;
				else
					CurrentState <= SPEND_CYCLE1;
				end if;
			else
				case CurrentState is 
					when SPEND_CYCLE1  =>
						rstMul <= '0';
						CurrentState <= LAST_MUL;

					when SPEND_CYCLE2  =>	
						rstMul <= '0';
						CurrentState <= WAIT_MUL;
							
					when LAST_MUL =>
						if doneMul = '1' then		  
								done <= '1';
								C_x <= MUL;
								currentState <= END_STATE;	
						end if;
										
					when WAIT_MUL =>
						if doneMul = '1' then
							Counter <= Counter + "00000001";
							REG_Bx <= MUX2;
							
							if (Counter = "10100000") then	-- lo tiene que hacer m -2 veces = 160	
								--ya termino la inversion, ahora tiene que realizar la multiplicacion para realizar la division
								rstMul <= '1';
								CurrentState <= SPEND_CYCLE1;					
							else
								rstMul <= '1';
								CurrentState <= SPEND_CYCLE2;
							end if;
						end if;
											
					when END_STATE =>
						CurrentState <= END_STATE;
					
					when others =>
						NULL;
				end case;
			end if;		
		end if;
	end process;						 			
end behave;