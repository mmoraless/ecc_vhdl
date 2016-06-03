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
-- Coments: This is an implementation of the division algorithm. Different to the other implemented inverter
--			in this, the division is performed directly. 
----------------------------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all; 
use IEEE.STD_LOGIC_unsigned.all; 
use IEEE.STD_LOGIC_arith.all;
----------------------------------------------------------------------------------------------------
entity f2m_divider_163 is
	generic(       
		NUM_BITS : positive := 163
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
architecture behave of f2m_divider_163 is		
----------------------------------------------------------------------------------------------------
-- m = 163, the irreductible polynomial	
constant p     : std_logic_vector(NUM_BITS downto 0) := "10000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000011001001";
----------------------------------------------------------------------------------------------------
-- control signals
signal en_VS, C_0, C_3, ISPos: std_logic;		 

signal V, S, to_V, to_S : STD_LOGIC_VECTOR(NUM_BITS downto 0);   			-- Internal registers		 

signal U, R, to_U, to_R	: STD_LOGIC_VECTOR(NUM_BITS-1 downto 0);   			-- Internal registers
signal u_div_2, v_div_2, r_div_2, s_div_2, p_div_2, op1: STD_LOGIC_VECTOR(NUM_BITS-1 downto 0);   			-- Internal registers

signal D: STD_LOGIC_VECTOR(3 downto 0);   			-- Internal registers

signal counter: STD_LOGIC_VECTOR(8 downto 0);   			-- Internal registers

type CurrentState_type is (END_STATE, LOAD1, LOAD2, CYCLE);
signal currentState: CurrentState_type;
----------------------------------------------------------------------------------------------------
begin
----------------------------------------------------------------------------------------------------
U_div_2 <= '0' & U(NUM_BITS-1 downto 1); 
R_div_2 <= '0' & R(NUM_BITS-1 downto 1);

P_div_2 <= p(NUM_BITS downto 1);
S_div_2 <= S(NUM_BITS downto 1);
V_div_2 <= V(NUM_BITS downto 1);

to_U <= U_div_2 xor V_div_2 when c_0 = '1' else
	U_div_2;
	
op1 <= R_div_2 xor P_div_2 when c_3 = '1' else
	R_div_2;
	
to_R <= op1 xor S_div_2 when c_0 = '1' else
	op1;
	
to_V <= Y & '0' when rst = '1' else
	p when CurrentState = LOAD1 else
	'0' & U;
	
to_S <= X & '0' when rst = '1' else
	(others => '0') when CurrentState = LOAD1 else
	'0' & R;

en_VS <= '1' when rst = '1' or CurrentState = LOAD1 or (U(0) = '1' and IsPos = '0') else
	'0';		
	
c_0 <= '1' when CurrentState = LOAD1 or  U(0) = '1' else
	'0';

c_3 <= '0' when (CurrentState = LOAD1 or R(0) = '0') else
	'1';
	
	
----------------------------------------------------------------------------------------------------			
-- Finite state machine 
----------------------------------------------------------------------------------------------------
EEAL: process (clk)
	begin -- syncronous reset
		if CLK'event and CLK = '1' then
			if (rst = '1')then
				R <= (others => '0');
				U <= (others => '0');		   
				
				x_div_y <= (others => '0');		   
				
				if en_VS = '1' then
					V <= to_V;
					S <= to_S;
				end if;
				
				done <= '0';
				counter <= "101000110"; --2*m - 2
				IsPos <= '0';
				D <= "0001";
				currentState <= LOAD1;
			else	
				case currentState is 
					-----------------------------------------------------------------------------------	
					when LOAD1 =>
						R <= to_R;
						U <= to_U; 
						if en_VS = '1' then
							V <= to_V;
							S <= to_S;
						end if;
					    
						currentState <= Cycle;
						
					when CYCLE =>
						counter <= counter - 1;
						R <= to_R;
						U <= to_U; 
						if en_VS = '1' then
							V <= to_V;
							S <= to_S;
						end if;
					    
						if U(0) = '0' then
							if IsPos = '0' then D <= D + 1;
							elsif D = "0000" then
								D <= D + 1;
								IsPos <= '0';
							else
								D <= D - 1;
							end if;
						elsif IsPos = '1' then	
							if D = "0000" then
								D <= D + 1;
								IsPos <= '0';
							else
								D <= D - 1;
							end if;
						else
							D <= D - 1;
							IsPos <= '1';
						end if;	
						
						if counter = "000000000" then
							done <= '1';
							x_div_y <= S(NUM_BITS-1 downto 0);
							CurrentState <= END_STATE;
						end if;	
					-----------------------------------------------------------------------------------
					when END_STATE =>					-- Do nothing 
						currentState <= END_STATE; 
					-----------------------------------------------------------------------------------
					when others =>
						null;
				end case;
			end if;
		end if;			
	end process;
end behave;