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
signal c0, c1, c2, c3, c4, c5, c6, enA, enB, a_greater_b,a_eq_b: std_logic;	
signal A, B, U, V, X2, Y2, toB, toV: STD_LOGIC_VECTOR(NUM_BITS downto 0);   			-- Internal registers		 

type CurrentState_type is (END_STATE, LOAD1, CYCLE);
signal currentState: CurrentState_type;
----------------------------------------------------------------------------------------------------
begin
----------------------------------------------------------------------------------------------------
X2 <= x & '0'; 
Y2 <= y & '0';

caso <= "00" when A(0) = '0' and currentState = CYCLE else
		"01" when B(0) = '0' and currentState = CYCLE else
		"10" when a_greater_b = '1' and currentState = CYCLE else
		"11";

c0 <= '0' when caso = "01" else
'1';

c1 <= '0' when caso = "00" else
'1';

c2 <= '0' when caso = "01" else
'1';

c3 <= '0' when caso = "00" else
'1';

c4 <= '0' when CurrentState = Load1 else
	'1';

c5 <= '0' when rst = '1' or currentState = LOAD1 else
	'1';

c6 <= '0' when rst = '1' else
	'1';

enA <= '1' when currentState = LOAD1 or caso = "00" or caso = "10" else
'0';

enB <= '1' when caso = "01" or caso = "11" or rst = '1' or currentstate = LOAD1 else
'0';

a_greater_b <= '1' when A > B else
	'0';

a_eq_b <= '1' when A = B else
	'0';
	
celda_reg_A: entity celda_a(behave)
	generic map(NUM_BITS)
	port map( A, B, c0, c1, enA, rst, clk, toB, A);
 		 
celda_reg_U: entity celda_U(behave)
	generic map(NUM_BITS)
	port map(U, V, P, c2, c3, c4, enA, rst, clk, toV, U);
 
celda_reg_B: entity celda_B(behave)
	generic map(NUM_BITS)
	port map(toB, P , Y2, c5, c6, enB, clk, B);
  
celda_reg_V: entity celda_v(behave)
	generic map(NUM_BITS)
	port map(toV, X2, c5, c6, enB, clk, V);
	
----------------------------------------------------------------------------------------------------			
-- Finite state machine 
----------------------------------------------------------------------------------------------------
EEAL: process (clk)
	begin -- syncronous reset
		if CLK'event and CLK = '1' then
			if rst = '1' then
				x_div_y <= (others => '0');
				done <= '0';
				currentState <= LOAD1;
			else	
				case currentState is 
					-----------------------------------------------------------------------------------	
					when LOAD1 =>
						currentState <= Cycle;
						
					when CYCLE =>
						if A_eq_B = '1' then
							currentState <= END_STATE;
							Done <= '1';  
							x_div_y <= U(NUM_BITS-1 downto 0);
						end if;
							
					-----------------------------------------------------------------------------------
					when END_STATE =>					-- Do nothing 
						currentState <= END_STATE; 
						--done <= '0';					-- para generar el pulso, quitarlo entity caso contrario
					-----------------------------------------------------------------------------------
					when others =>
						null;
				end case;
			end if;
		end if;			
	end process;
end behave;