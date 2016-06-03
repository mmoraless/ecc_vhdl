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

-- control signals
signal en_VS, C_0, C_1, C_2, C_3, ISPos: std_logic;		 

signal V, S,X2, Y2, u_pad, r_pad : STD_LOGIC_VECTOR(NUM_BITS downto 0);   			-- Internal registers		 
signal U, R : STD_LOGIC_VECTOR(NUM_BITS-1 downto 0);   			-- Internal registers
signal u_div_2, v_div_2, r_div_2, s_div_2, p_div_2: STD_LOGIC_VECTOR(NUM_BITS-1 downto 0);   			-- Internal registers

signal D: STD_LOGIC_VECTOR(3 downto 0);   			-- Internal registers
signal counter: STD_LOGIC_VECTOR(8 downto 0);   			-- Internal registers

type CurrentState_type is (END_STATE, LOAD1, LOAD2, CYCLE);
signal currentState: CurrentState_type;
----------------------------------------------------------------------------------------------------
begin
----------------------------------------------------------------------------------------------------
X2 <= x & '0'; 
Y2 <= y & '0';

u_pad <= '0' & U; 
R_pad <= '0' & R;

U_div_2 <= '0' & U(NUM_BITS-1 downto 1); 
R_div_2 <= '0' & R(NUM_BITS-1 downto 1);
P_div_2 <= p(NUM_BITS downto 1);
S_div_2 <= S(NUM_BITS downto 1);
V_div_2 <= V(NUM_BITS downto 1);
			 --carga 2x, 2y    --carga p, 0            carga U, R    
en_VS <= '1' when rst = '1' or CurrentState = LOAD1 or (U(0) = '1' and IsPos = '0') else
	'0';		
	
c_0 <= '1' when CurrentState = LOAD1 or  U(0) = '1' else
	'0';

c_2 <= '0' when rst = '1' else
	'1';

c_1 <= '0' when rst = '1' or currentState = LOAD1 else
	'1';
	
c_3 <= '0' when (CurrentState = LOAD1 or R(0) = '0') else
	'1';
	
celda_reg_u: entity work.celda_u(behave)
	port map( V_div_2,U_div_2,c_0,clk,rst,U);

celda_reg_r: entity work.celda_r(behave)
	port map(R_div_2, P_div_2, S_div_2, c_3, c_0, clk, rst, R);
	
celda_reg_v: entity work.celda_v(behave)
	port map(u_pad,P,Y2,c_1,c_2,en_VS,clk,V);

celda_reg_s: entity work.celda_s(behave)
	port map(R_pad,X2,c_1,c_2,en_VS,clk,S);
				    
----------------------------------------------------------------------------------------------------			
-- Finite state machine 
----------------------------------------------------------------------------------------------------
EEAL: process (clk)
	begin -- syncronous reset
		if CLK'event and CLK = '1' then
			if (rst = '1')then
				x_div_y <= (others => '0');		   
				
				done <= '0';
				counter <= "101001000"; --2*m - 2
				IsPos <= '0';
				D <= "0001";
				currentState <= LOAD1;
			else	
				case currentState is 
					-----------------------------------------------------------------------------------	
					when LOAD1 =>
						currentState <= Cycle;
						
					when CYCLE =>
						counter <= counter - 1;
						
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