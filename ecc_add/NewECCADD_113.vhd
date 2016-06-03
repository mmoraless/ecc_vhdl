------------------------------------------------------------------------ 
--Nueva implementacion ADD y Double en una misma arquitectura
------------------------------------------------------------------------
library IEEE; 

use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;	
use IEEE.std_logic_arith.all;

entity ECC_add_serial_113 is					
	generic(   						
									-- 163, 233,    277,   283,     409,    571
		NUM_BITS : positive := 113	
	);
	port(
		xP: in std_logic_vector(NUM_BITS-1 downto 0);
		yP: in std_logic_vector(NUM_BITS-1 downto 0);	
		xQ: in std_logic_vector(NUM_BITS-1 downto 0);
		yQ: in std_logic_vector(NUM_BITS-1 downto 0);			   		
		---------------------------------------------
		clk: in std_logic;
		rst: in std_logic;
		s0: in std_logic;								 -- 1 = Suma, 0 = Double
		---------------------------------------------
		X: out std_logic_vector(NUM_BITS-1 downto 0); 
		Y: out std_logic_vector(NUM_BITS-1 downto 0); 
		done: out std_logic
	);												 
end;		 

------------------------------------------------------
architecture behave of ECC_add_serial_113 is

type CurrentState_type is (END_STATE, CHECK_INPUT, SPEND_CYCLE1, SPEND_CYCLE2,CALC_INV, CALC_MUL);
signal CurrentState : CurrentState_type;

constant cero : std_logic_vector(NUM_BITS-1 downto 0):= (others => '0');
-- 
signal S1 : std_logic_vector(NUM_BITS-1 downto 0); 
signal not_s0 : std_logic; 
-- 4 multiplexores
signal L3 : std_logic_vector(NUM_BITS-1 downto 0); 
signal SQRin : std_logic_vector(NUM_BITS-1 downto 0); 
signal Div1 : std_logic_vector(NUM_BITS-1 downto 0); 
signal Div2 : std_logic_vector(NUM_BITS-1 downto 0); 

--- interface con el inversor
signal rstInv  : std_logic; 
signal Division    : std_logic_vector(NUM_BITS-1 downto 0);  
signal doneInv : std_logic;

--- interface del multiplicador
signal rstMul  : std_logic; 
signal Multiplication    : std_logic_vector(NUM_BITS-1 downto 0);  
signal doneMul : std_logic;  

--- interface del squarer
signal SQR    : std_logic_vector(NUM_BITS-1 downto 0);   

---------------------------------------------------------------	
begin
---------------------------------------------------------------	  

-- Componentes
---------------------------------------------------------------
	SQUARER_1 : entity squarer_113(behave) 
		--generic map (D, NUM2_BITS, NUM_BITS)
		generic map (NUM_BITS)
		port map(SQRin, SQR);
---------------------------------------------------------------
	MUL_1: entity serial_multiplier_113(behave)
		generic map (NUM_BITS)
		port map(S1, SQRin, Multiplication,rstMul,clk,doneMul);
---------------------------------------------------------------				  
	INV_1: entity f2m_divider_113(behave)
		generic map (NUM_BITS)
		port map(Div1, Div2, clk, rstInv, doneInv, Division);
---------------------------------------------------------------	

---------------------------------------------------------------				  
	LUT31: entity lut_3in(behave)
		generic map (NUM_BITS)
		port map(yQ, s0, yP, Div1);
---------------------------------------------------------------	

---------------------------------------------------------------				  
	LUT32: entity lut_3in(behave)
		generic map (NUM_BITS)
		port map(xQ, s0, xP, Div2);
---------------------------------------------------------------	

---------------------------------------------------------------				  
	LUT33: entity lut_3in(behave)
		generic map (NUM_BITS)
		port map(xP, not_s0, Division,SQRin);
---------------------------------------------------------------	

---------------------------------------------------------------				  
	LUT41: entity lut_3inadd(behave)
		generic map (NUM_BITS)
		port map(SQR, Division, Div2, L3);
---------------------------------------------------------------	


-- Operaciones combinacionales (Sumas)
	S1 <= L3 xor xP;
	not_s0 <= not s0;
---------------------------------------------------------------	
ADD_FSM: process (CLK)
Begin						
	if CLK'event and CLK = '1' then
		-- Los datos de entrada deben estar presentes al llegar la señal de reset,
		-- Si la señal Rst de entrada es síncrona con un reloj (i.e. es proporcionada 
		-- por un control en la subida del reloj), los datos a la entrada deben asignarse
		-- junto con la señal de Rst o al momento de que Rst regrese a '0'
		if Rst = '1' then
			CurrentState <= CHECK_INPUT;
			Done <= '0';
			X <= (others =>'0');
			Y <= (others =>'0');
			rstInv <= '0'; 
			rstMul <= '0';
			
		 else
			case CurrentState is
			when CHECK_INPUT =>	
				if (xP = cero) and (yP = cero) and s0 = '1' then	 -- add
					X  <= xQ;
					Y  <= yQ;	
					Done <= '1';		
					CurrentState <= END_STATE;	
				elsif (xQ = cero) and (yQ = cero)  and s0 = '1' then -- Add
					X  <= xP;
					Y  <= yP;
					Done <= '1';		
					CurrentState <= END_STATE;	
				
				elsif (xP = cero) and s0 = '0' then	-- Double
					Done <= '1';				
					CurrentState <= END_STATE;	
				else										
					rstInv  <= '1';						-- calcular la division primero.
					CurrentState <= SPEND_CYCLE1;
				end if;				
				
			when SPEND_CYCLE1 =>			 			-- Provoca el pulso RST al modulo de inversion.
				rstInv  <= '0';
				CurrentState <= CALC_INV;
			
			when CALC_INV =>							-- Una vez que termina de calcular la division, 
				if doneInv = '1' then					-- comienza con la multiplicación.
					X <= L3;
					rstMul <= '1';  
					CurrentState <= SPEND_CYCLE2;	
				end if;				
				
			when SPEND_CYCLE2 =>			 		   	-- Provoca el pulso RST en el multiplicador
				rstMul  <= '0';
				CurrentState <= CALC_MUL;
				
			when CALC_MUL =>				   			-- Espera que el multiplicador termine					
				if doneMul = '1' then
					Y <=  Multiplication xor L3 xor yP;			 										
					Done <= '1';
					CurrentState <= END_STATE;			-- Operación ADD terminada
				end if;
				
			when END_STATE =>	 	   
				CurrentState <= END_STATE; 				
			
			when others =>
				null;
			end case;
			
		end if;
	end if;
end process;	  
end behave;