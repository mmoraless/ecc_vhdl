----------------------------------------------------------------------------------------------------
--										poly_grade.vhd	 										 ---
----------------------------------------------------------------------------------------------------
-- Author		: Miguel Morales-Sandoval														 ---
-- Project		: "Hardware Arquitecture for ECC and Lossless Data Compression					 ---
-- Organization	: INAOE, Computer Science Department											 ---
-- Date			: July, 2004.																	 ---
----------------------------------------------------------------------------------------------------
--	Inverter for F_2^m 
----------------------------------------------------------------------------------------------------
-- Coments: It calculates the grade of the input polynomial
----------------------------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
----------------------------------------------------------------------------------------------------
entity grade is 
	port(			
		rst 	: in std_logic;
		clk 	: in std_logic;
	 	a		: in std_logic_vector(163 downto 0); 
		done	: out std_logic; 
		c		: out std_logic_vector(7 downto 0)
	);
end grade;
----------------------------------------------------------------------------------------------------
architecture grade of grade is		  
----------------------------------------------------------------------------------------------------
signal counter : std_logic_vector (7 downto 0);					-- keeps the track of the grade 
signal a_int   : std_logic_vector(163 downto 0); 		-- register and shifter for the input a
signal a_shift : std_logic_vector(163 downto 0); 		
----------------------------------------------------------------------------------------------------
type CurrentState_type is (END_STATE, E0);						-- the finite stte machine
signal State: CurrentState_type;
----------------------------------------------------------------------------------------------------
begin
----------------------------------------------------------------------------------------------------	
c <= counter;													-- Output
a_shift <= a_int(162 downto 0) & '0';					-- shift to lefts of the internal register for the input
---------------------------------------------------------------------------------------------------- 
-- Finite state machine for computing the grade of the input polynomial
----------------------------------------------------------------------------------------------------
GRADE_FST :	process(clk)	
begin 
	if CLK'event and CLK = '1' then
		if (rst = '1')then			-- synchronous resert signal, the input needs to be valid at the moment
			a_int   <= a;
			counter <= "10100011";	-- NUM_BITS , in this case it is 163
			Done    <= '0';
			State   <= E0;			
		else
			case State is	 
			------------------------------------------------------------------------------
			when E0 => 			-- The operation concludes when it founds the most significant bit of the input
				if a_int(163) = '1' or counter = "00000000" then	
					done <= '1';
					State <= END_STATE;
				else				 
					counter <= counter - 1;
					a_int <= a_shift;  	-- Check out if the next bit of the input is '1'
				end if;
			------------------------------------------------------------------------------
			when END_STATE =>	 		-- Do nothing, just wait the reset signal again
				 State <= END_STATE;
			------------------------------------------------------------------------------
			when others =>
				null;
			end case;
		end if;	 
	end if;
end process;	 
end;