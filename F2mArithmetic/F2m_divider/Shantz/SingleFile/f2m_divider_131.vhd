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
entity f2m_divider_131 is
	generic(       
		NUM_BITS : positive := 131
	);
	 port(
	  	 x    : in STD_LOGIC_VECTOR(NUM_BITS-1 downto 0); 
	 	 y    : in STD_LOGIC_VECTOR(NUM_BITS-1 downto 0);
		 clk  : in STD_LOGIC;
		 rst  : in STD_LOGIC;
		 done : out STD_LOGIC;
		 Ux    : out STD_LOGIC_VECTOR(NUM_BITS-1 downto 0)	-- U = x/y mod Fx,
	     );
end;
----------------------------------------------------------------------------------------------------
architecture behave of f2m_divider_131 is		
----------------------------------------------------------------------------------------------------
-- Signal for up-date regsiters A and B
signal A,B    : STD_LOGIC_VECTOR(NUM_BITS downto 0);   			-- Internal registers
signal U, V   : STD_LOGIC_VECTOR(NUM_BITS downto 0);   			-- Internal registers
----------------------------------------------------------------------------------------------------
-- m = 131
constant F     : std_logic_vector(NUM_BITS downto 0) := "100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100001101";
-- m = 163, the irreductible polynomial	
--constant F     : std_logic_vector(NUM_BITS downto 0) := "10000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000011001001";
-- m = 233		  x233 + x74 + 1
--constant F_x: std_logic_vector(NUM_BITS downto 0) := "100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000001";
-- m = 277		  x277 + x74 + 1
--constant F_x: std_logic_vector(NUM_BITS downto 0) := "10000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000001001001"; --277 bits
-- m = 283        x283 + x12 + x7 + x5 + 1														
--constant F_x: std_logic_vector(NUM_BITS downto 0) := "10000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000010100001";
-- m = 409		  x409 + x87 + 1
--constant F_x: std_logic_vector(NUM_BITS downto 0) := "10000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000001";
-- m = 571        x571 + x10 + x5 + x2 + 1													
--constant F_x: std_logic_vector(NUM_BITS downto 0) := "10000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000100101";
----------------------------------------------------------------------------------------------------
-- control signals
signal a_greater_b, a_eq_b, A_par, B_par, U_par, V_par, u_mas_v_par: std_logic;		 
signal A_div_t, B_div_t, U_div_t, V_div_t  				 : STD_LOGIC_VECTOR(NUM_BITS downto 0);   			-- Internal registers		 
signal u_mas_M, v_mas_M, u_mas_v, u_mas_v_mas_M, a_mas_b : STD_LOGIC_VECTOR(NUM_BITS downto 0);   			-- Internal registers
signal u_mas_M_div_t, v_mas_M_div_t, u_mas_v_div_t, u_mas_v_mas_M_div_t, a_mas_b_div_t: STD_LOGIC_VECTOR(NUM_BITS downto 0);   			-- Internal registers
																		 ----------------------------------------------------------------------------------------------------------------------------------------------------------
type CurrentState_type is (END_STATE, INIT, CYCLE);
signal currentState: CurrentState_type;
----------------------------------------------------------------------------------------------------
begin
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
-- Control signals
A_par <= '1' when A(0) = '0' else
	'0';
B_par <= '1' when B(0) = '0' else
	'0';
U_par <= '1' when U(0) = '0' else
	'0';
V_par <= '1' when V(0) = '0' else
	'0';
	
a_greater_b <= '1' when A > B else
	'0';   

a_eq_b <= '1' when A = B else
	'0';
----------------------------------------------------------------------------------------------------
-- Mux definitions																					
----------------------------------------------------------------------------------------------------
u_mas_M <= U xor F;
v_mas_M <= V xor F;
u_mas_v <= U xor V;
u_mas_v_mas_M <= u_mas_v xor F;
a_mas_b <= A xor B;

-- Muxes for A and B
a_div_t <= '0'& A(NUM_BITS downto 1); 
b_div_t <= '0'& B(NUM_BITS downto 1);
u_div_t <= '0'& U(NUM_BITS downto 1); 
v_div_t <= '0'& V(NUM_BITS downto 1);

u_mas_M_div_t <= '0' & u_mas_M(NUM_BITS downto 1);
v_mas_M_div_t <= '0' & v_mas_M(NUM_BITS downto 1); 
u_mas_v_div_t <= '0' & u_mas_v(NUM_BITS downto 1); 
u_mas_v_mas_M_div_t <= '0' & u_mas_v_mas_M(NUM_BITS downto 1);
a_mas_b_div_t <= '0' & a_mas_b(NUM_BITS downto 1);
----------------------------------------------------------------------------------------------------			
-- Finite state machine 
----------------------------------------------------------------------------------------------------
EEAL: process (clk)
	begin -- syncronous reset
		if CLK'event and CLK = '1' then
			if (rst = '1')then
				A <= '0' & y;
				B <= F;
				U <= '0' & x; 
				v <= (others => '0');
				Ux <= (others => '0');	
				done <= '0';
				currentState <= CYCLE;
			else	
				case currentState is 
					-----------------------------------------------------------------------------------	
					when CYCLE =>
						if A_eq_B = '1' then
							currentState <= END_STATE;
							Done <= '1';  
							Ux <= U(NUM_BITS-1 downto 0);
						elsif A_par = '1' then
								A <= A_div_t;
								if U_par = '1' then
									U <= U_div_t;
								else
									U <= u_mas_M_div_t;
								end if;						
						elsif B_par = '1' then				
								B <= B_div_t;
								if V_par = '1' then
									V <= V_div_t;
								else
									V <= V_mas_M_div_t;
								end if;	
								
						elsif a_greater_b = '1' then				
								A <= a_mas_b_div_t;
								if u_mas_v(0) = '0' then
									U <= u_mas_v_div_t;
								else
									U <= u_mas_v_mas_M_div_t;
								end if;				   
						else
								B <= a_mas_b_div_t;
								if u_mas_v(0) = '0' then
									V <= u_mas_v_div_t;
								else
									V <= u_mas_v_mas_M_div_t;
								end if;	
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