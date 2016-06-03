-- The VHDL code was written by Miguel Morales-Sandoval
--(morales.sandoval.miguel@gmail.com) from 2004 to 2008 when he was 
--a MSc and PhD student at the Computer Science department in INAOE,
--Mexico.

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
		 x_div_y: out STD_LOGIC_VECTOR(NUM_BITS-1 downto 0)	-- U = x/y mod Fx,
	     );
end;
----------------------------------------------------------------------------------------------------
architecture behave of f2m_divider_163 is		
----------------------------------------------------------------------------------------------------
signal V    : STD_LOGIC_VECTOR(NUM_BITS downto 0);   			-- Internal registers
signal U, s, R   : STD_LOGIC_VECTOR(NUM_BITS downto 0);   			-- Internal registers

signal to_U, to_R, to_V, to_S, op1   : STD_LOGIC_VECTOR(NUM_BITS downto 0);   			-- Internal registers
----------------------------------------------------------------------------------------------------
constant F     : std_logic_vector(NUM_BITS downto 0) := "10000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000011001001";
signal c: std_logic_vector(3 downto 0);
signal U_div_2, R_div_2, V_div_2, S_div_2, p_div_2 : STD_LOGIC_VECTOR(NUM_BITS downto 0);   			-- Internal registers

signal D, counter :std_logic_vector(8 downto 0);
signal IsPos, en: std_logic;

type CurrentState_type is (END_STATE, INIT, CYCLE);
signal currentState: CurrentState_type;

----------------------------------------------------------------------------------------------------
begin
	
U_div_2 <= '0' & U(NUM_BITS downto 1);
R_div_2 <= '0' & R(NUM_BITS downto 1);
V_div_2 <= '0' & V(NUM_BITS downto 1);
S_div_2 <= '0' & S(NUM_BITS downto 1);
p_div_2 <= '0' & F(NUM_BITS downto 1); 

to_U <= u_div_2 xor v_div_2 when c(0) = '1' else
	u_div_2;

op1 <= R_div_2 xor p_div_2 when c(3) = '1' else
	R_div_2;

to_R <= op1 xor s_div_2 when c(0) = '1' else
	op1;
	
--to_v <= U when c(1) = '0' and c(2) = '0' else
--	U when c(1) = '0' and c(2) = '1' else
--	Y when c(1) = '1' and c(2) = '0' else
--	F;

--to_s <= R when c(1) = '0' and c(2) = '0' else
--	R when c(1) = '0' and c(2) = '1' else
--	X when c(1) = '1' and c(2) = '0' else
--	(others => '0');
	
c(0) <= U(0);
c(3) <= '1';

EEAL: process (clk)
	begin -- syncronous reset
		if CLK'event and CLK = '1' then
			if (rst = '1')then
				U <= '0' & Y;
				V <= F;
				R <= '0' & X;
				S <= (others => '0');
				done <= '0';
				x_div_y <= (others => '0');
				counter <= "101000111";	-- 325  2m-1
				D <= "000000001";
				IsPos <= '0';
				
				currentState <= Cycle;
			else	
				case currentState is 
					-----------------------------------------------------------------------------------	
						
					when CYCLE =>
						if counter = "000000000" then
							currentState <= END_STATE;
							Done <= '1';  
							x_div_y <= S(NUM_BITS-1 downto 0);
						else	 
							counter <= counter - 1;	
							
							U <= to_U;
							R <= to_R;
							
							if U(0) = '0' then
								if IsPos = '0' then
									D <= D + 1; 
								elsif D = "000000000" then
									D <= D + 1; 
									IsPos <= '0';
								else
									D <= D - 1;
								end if;	
							elsif IsPos = '1' then
								if D = "000000000" then
									D <= D + 1;
									IsPos <= '0';
								else
									D <= D - 1;
								end if;
							else
								D <= D - 1;
								IsPos <= '1'; 
								V <= U;					 
								S <= R;	 
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