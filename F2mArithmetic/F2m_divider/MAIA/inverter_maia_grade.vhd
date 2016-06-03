----------------------------------------------------------------------------------------------------
--											inverter_maia.vhd										 ---
----------------------------------------------------------------------------------------------------
--	Inverter for F_2^m 
----------------------------------------------------------------------------------------------------
-- Author		: Miguel Morales-Sandoval														 ---
-- Project		: "Hardware Arquitecture for ECC and Lossless Data Compression					 ---
-- Organization	: INAOE, Computer Science Department											 ---
-- Date			: July, 2004.																	 ---
----------------------------------------------------------------------------------------------------
-- Coments: This is an implementation of the Modified Almost Inverse Algorithm.
-- 			The input buses need to have valid data when Reset signal is asserted. 
 -- 		All internal registers and operations are performed one bit more than the input
----------------------------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all; 
use IEEE.STD_LOGIC_unsigned.all; 
use IEEE.STD_LOGIC_arith.all;
--------------------------------------------------------
entity inverter_maia is
	generic(       
		NUM_BITS : positive := 163							-- The order of the finite field
	);	  
	port( 
		 ax    : in STD_LOGIC_VECTOR(NUM_BITS-1 downto 0); 	-- input polynomial of grade m-1
		 Fx    : in STD_LOGIC_VECTOR(NUM_BITS downto 0);	-- prime polynomial of grade m 
		 clk  : in STD_LOGIC;
		 rst  : in STD_LOGIC;
		 done : out STD_LOGIC;
		 z    : out STD_LOGIC_VECTOR(NUM_BITS-1 downto 0)
	     );
end inverter_maia;
---------------------------------------------------------
architecture behave of inverter_maia is		
---------------------------------------------------------
	signal B,C,U,V  : STD_LOGIC_VECTOR(NUM_BITS downto 0);  -- Internal processing registers, one bit more
	signal Bx_Op1   : STD_LOGIC_VECTOR(NUM_BITS downto 0);  -- Multiplexer which depends on if B is ever or odd
	signal Ux_div_x : STD_LOGIC_VECTOR(NUM_BITS downto 0);  -- U and B divided by x
	signal Bx_div_x : STD_LOGIC_VECTOR(NUM_BITS downto 0);  
	constant UNO    : STD_LOGIC_VECTOR(NUM_BITS downto 0) := "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001";
	signal grade_u  : std_logic_vector(7 downto 0); 		-- Return the grade of U and V, it is assumed they are less than 256 
	signal grade_v  : std_logic_vector(7 downto 0);		  
	
	signal done_gu, done_gv, rst_grade: std_logic; 
	----------------------------------------------------------------------------------
	-- States fot the FSM controlling the execution of the algorithm
	----------------------------------------------------------------------------------
	type CurrentState_type is (END_STATE, WAIT_GRADE, LOOP_U0, CALC_GRADE, NEXT_STEP);
	signal State: CurrentState_type;
	----------------------------------------------------------------------------------
begin
	------------------------------------------------------
	Ux_div_x <= '0' & U(NUM_BITS downto 1);					-- Dividing U and B by x
	Bx_div_x <= '0' & Bx_Op1(NUM_BITS downto 1);
	------------------------------------------------------
	Bx_Op1   <= B xor Fx when B(0) = '1' else				-- Multiplexer for operand B 
		        B;
	------------------------------------------------------
	-- Two instances for computing the grade of U and V 
	------------------------------------------------------
	gradeU: entity work.grade(grade)  
		port map (rst_grade, clk, U, done_gu, grade_u);
	
	gradeV: entity work.grade(grade)  
		port map (rst_grade, clk, V, done_gv, grade_v);
		
	-------------------------------------------------------
	-- The Modified ALmost Inverse Algorithm implementation
	-------------------------------------------------------
	EEAL: process (clk)
		begin -- syncronous reset
			if CLK'event and CLK = '1' then
				if (rst = '1')then							-- initialize internal registers
					State <= LOOP_U0;	 	
					B <= UNO;
					U <= '0'&Ax;
					V <= Fx;
					C <= (others => '0');					
					z <= (others => '0');					-- set to zero the output register
					Done      <= '0';
					rst_grade <= '0';
				else	
					case State is 
						-----------------------------------------------------------------------------------
						when LOOP_U0 =>						-- Stay here while U be even
							if U(0) = '1' then
								if U = UNO then				-- The algorithm finishes when U = 1
									Z <= B(NUM_BITS-1 downto 0);
									Done <= '1';
									State <= END_STATE;
								else						-- Compute the grade of the the currents values of U and V
									rst_grade <= '1';
									State <= CALC_GRADE;
								end if;
							else							-- Divide U and B and repeat the process
								U <= Ux_div_x;
								B <= Bx_div_x;
							end if;
						-----------------------------------------------------------------------------------	
						when CALC_GRADE =>	 				 -- generate the reset signal and wait for the result
							rst_grade <= '0';
							state <= WAIT_GRADE;
						-----------------------------------------------------------------------------------		
						when WAIT_GRADE =>	 			
							if done_gu = '1' and done_gv = '1' then
								if(grade_u < grade_v) then	-- Interchange the registers U <-> V and B <-> C
									U <= V;
									V <= U;
									B <= C;
									C <= B;
								end if;	   
								State <= NEXT_STEP;			-- wait a cycle to compute with the current values assigned
							end if;
						-----------------------------------------------------------------------------------
						when NEXT_STEP => 					-- update U and B with the values previously assigned
							U <= U xor V;
							B <= B xor C;
							State <= LOOP_U0;
						 -----------------------------------------------------------------------------------
						when END_STATE =>					-- Do nothing 
							State <= END_STATE;
						-----------------------------------------------------------------------------------
						when others =>
							null;
					end case;
				end if;
			end if;			
		end process;
end behave;