---------------------------------------------------------------------------------------------------
--											divider_f2m.vhd										 ---
----------------------------------------------------------------------------------------------------
-- Author		: Miguel Morales-Sandoval														 ---
-- Project		: "Hardware Arquitecture for ECC and Lossless Data Compression					 ---
-- Organization	: INAOE, Computer Science Department											 ---
-- Date			: July, 2004.																	 ---
----------------------------------------------------------------------------------------------------
--	Inverter for F_2^m 
----------------------------------------------------------------------------------------------------
-- Coments: This is an implementation of the division algorithm. Dirent to the other implemented inverter
--			in this, the division is performed directly. 
----------------------------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all; 
use IEEE.STD_LOGIC_unsigned.all; 
use IEEE.STD_LOGIC_arith.all;
----------------------------------------------------------------------------------------------------
entity f2m_divider_113 is
	generic(       
		NUM_BITS : positive := 113
	);
	 port(
	  	 x    : in STD_LOGIC_VECTOR(NUM_BITS-1 downto 0); 
	 	 y    : in STD_LOGIC_VECTOR(NUM_BITS-1 downto 0);
		 clk  : in STD_LOGIC;
		 rst  : in STD_LOGIC;
		 done : out STD_LOGIC;
		 x_div_y    : out STD_LOGIC_VECTOR(NUM_BITS-1 downto 0)	-- U = x/y mod Fx,
	     );
end;
----------------------------------------------------------------------------------------------------
architecture behave of f2m_divider_113 is		
----------------------------------------------------------------------------------------------------
-- m = 113, the irreductible polynomial	
constant p     : std_logic_vector(NUM_BITS downto 0) := "100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000001";
-- control signals
signal CASO: std_logic_vector(1 downto 0);		
signal c_4, c_5,c_6,a_greater_b,a_eq_b: std_logic;	
signal CA, CB : STD_LOGIC_VECTOR(7 downto 0);

signal U, A, V, B,X2, Y2, temp1, toA, toB, toU, toV: STD_LOGIC_VECTOR(NUM_BITS downto 0);   			-- Internal registers		 

type CurrentState_type is (END_STATE, LOAD1, CYCLE);
signal currentState: CurrentState_type;
----------------------------------------------------------------------------------------------------
begin
----------------------------------------------------------------------------------------------------
X2 <= x & '0'; 
Y2 <= y & '0';

caso <= "01" when (A(0) = '1' and B(0) = '0') or CurrentState = LOAD1 else
		"10" when A(0) = '0' else
		"11";
	
c_5 <= '0' when rst = '1' or currentState = LOAD1 else
	'1';
c_6 <= '1' when CurrentState = LOAD1 else
	'0';

a_greater_b <= '1' when CA > CB else
	'0';

a_eq_b <= '1' when A = B else
	'0';

--a_eq_b <= '1' when CA = "00000000" else
--	'0';

c_4 <= '0' when CurrentState = Load1 or temp1(0) = '0' else
	'1';
	
celda_reg_A: entity celda_a(behave)
	generic map (NUM_BITS)
	port map( A, B,caso(1), caso(0), toA);

celda_reg_U: entity celda_U(behave)
	generic map (NUM_BITS)
	port map(U, V, caso(1), caso(0), temp1);

celda_reg_mod_P: entity mod_P(behave)
	generic map (NUM_BITS)
	port map(temp1, P, c_4, toU);
	
celda_reg_B: entity celda_B(behave)
	generic map (NUM_BITS)
	port map(toA,P,Y2,c_5,c_6, toB);

celda_reg_V: entity celda_v(behave)
	generic map (NUM_BITS)
	port map(toU,X2,c_5,c_6,toV);
	

----------------------------------------------------------------------------------------------------			
-- Finite state machine 
----------------------------------------------------------------------------------------------------
EEAL: process (clk)
	begin -- syncronous reset
		if CLK'event and CLK = '1' then
			if (rst = '1')then
				A <= (others => '0'); 
				U <= (others => '0'); 
				B <= toB;
				V <= toV;
				CA <= "01110000" ;
				CB <= "01101111" ;
				x_div_y <= (others => '0');	
				done <= '0';
				currentState <= LOAD1;
			else	
				case currentState is 
					-----------------------------------------------------------------------------------	
					when LOAD1 =>
						A <= toA;
						U <= toU;
						B <= toB;
						V <= toV;
						currentState <= Cycle;
						
					when CYCLE =>
						if A_eq_B = '1' then
							currentState <= END_STATE;
							Done <= '1';  
							x_div_y <= U(NUM_BITS-1 downto 0);
						elsif CASO = "10" then
							A <= toA;
							CA <= CA-1;
							U <= toU;
						elsif CASO = "01" then				
								B <= toB;
								CB <= CB -1;
								V <= toV;
								
						elsif a_greater_b = '1' then				
								A <= toA; 
								CA <= CA-1;
								U <= toU;			   
						else
								B <= toB;	
								CB <= CB-1;
								V <= toV;							
						end if;
							
					-----------------------------------------------------------------------------------
					when END_STATE =>					-- Do nothing 
						currentState <= END_STATE; 
						done <= '0';					-- para generar el pulso, quitarlo entity caso contrario
					-----------------------------------------------------------------------------------
					when others =>
						null;
				end case;
			end if;
		end if;			
	end process;
end behave;