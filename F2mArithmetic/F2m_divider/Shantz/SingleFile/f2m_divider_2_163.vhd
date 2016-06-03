---------------------------------------------------------------------------------------------------
--											divider_f2m.vhd										 ---
----------------------------------------------------------------------------------------------------
-- Author		: Miguel Morales-Sandoval														 ---
-- Project		: "Hardware Arquitecture for ECC and Lossless Data Compression					 ---
-- Organization	: INAOE, Computer Science Department											 ---
-- Date			: July, 2004.																	 ---
----------------------------------------------------------------------------------------------------
--	Inverter for F_2^m . Based on the work of Meurice Guerric
----------------------------------------------------------------------------------------------------
-- Coments: This is an implementation of the division algorithm. Dirent to the other implemented inverter
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
		 x_y: out STD_LOGIC_VECTOR(NUM_BITS-1 downto 0)	-- U = x/y mod Fx,
	     );
end;
----------------------------------------------------------------------------------------------------
architecture behave of f2m_divider_163 is		
----------------------------------------------------------------------------------------------------
signal R,S    : STD_LOGIC_VECTOR(NUM_BITS downto 0);   			-- Internal registers
signal U, V   : STD_LOGIC_VECTOR(NUM_BITS downto 0);   			-- Internal registers
----------------------------------------------------------------------------------------------------
constant F     : std_logic_vector(NUM_BITS downto 0) := "10000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000011001001";

signal V_shift,S_shift,U_shift,R_shift,P_shift : STD_LOGIC_VECTOR(NUM_BITS downto 0);   			-- Internal registers

signal D, counter :std_logic_vector(8 downto 0);
signal IsPos: std_logic;
						
type CurrentState_type is (END_STATE, INIT, CYCLE);
signal currentState: CurrentState_type;
----------------------------------------------------------------------------------------------------
begin
----------------------------------------------------------------------------------------------------
-- Mux definitions																					
----------------------------------------------------------------------------------------------------

V_shift <= '0' & V(NUM_BITS downto 1); 
S_shift <= '0' & S(NUM_BITS downto 1); 

U_shift <= '0' & U(NUM_BITS downto 1); 
R_shift <= '0' & R(NUM_BITS downto 1);
P_shift <= F(NUM_BITS downto 1); 

----------------------------------------------------------------------------------------------------			
-- Finite state machine 
----------------------------------------------------------------------------------------------------
EEAL: process (clk)
	begin -- syncronous reset
		if CLK'event and CLK = '1' then
			if (rst = '1')then
				U <= '0' & y;
				V <= F;
				R <= '0' & x;
				S <= (others => '0');
				done <= '0';
				
				x_y <= (others => '0');
				counter <= "101000101";	-- 325  2m-1
				D <= "000000001";
				IsPos <= '0';
				
				currentState <= CYCLE;
			else	
				case currentState is 
					-----------------------------------------------------------------------------------	
					when CYCLE =>
						if counter = "000000000" then
							currentState <= END_STATE;
							Done <= '1';  
							x_y <= S(NUM_BITS-1 downto 0);
						else	 
							counter <= counter - 1;	
							if U(0) = '0' then 
								  U <= U_shift;
							      if R(0) = '1' then
								  	R <= (R_shift xor P_shift);
								  else
									R <= R_shift;
								  end if;
								  
								if IsPos = '0' then
									D <= D + 1; 
								elsif D = "000000000" then
									D <= D + 1; 
									IsPos <= '0';
								else
									D <= D - 1;
								end if;	
							elsif IsPos = '1' then
								U <= U_shift xor V_shift;
								if R(0) = '1' then
									R <= R_shift xor S_shift xor P_shift;
								else									 
									R <= R_shift xor S_shift;
								end if;
								
								if D = "000000000" then
									D <= D + 1;
									IsPos <= '0';
								else
									D <= D - 1;
								end if;
							else
								D <= D - 1;
								IsPos <= '1'; 
								U <= U_shift xor V_shift;
								V <= U;					 
								S <= R;
								
								if R(0) = '1' then
									R <= R_shift xor S_shift xor P_shift;
								else									 
									R <= R_shift xor S_shift;
								end if;	
							end if;	
						end if;
							
					-----------------------------------------------------------------------------------
					when END_STATE =>					-- Do nothing 
						currentState <= END_STATE; 
										-- para generar el pulso, quitarlo entity caso contrario
					-----------------------------------------------------------------------------------
					when others =>
						null;
				end case;
			end if;
		end if;			
	end process;
end behave;