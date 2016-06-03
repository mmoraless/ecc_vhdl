----------------------------------------------------------------------------------------------------
--											serial_multiplier.vhd											 ---
----------------------------------------------------------------------------------------------------
-- Author		: Miguel Morales-Sandoval														 ---
-- Project		: "Hardware Arquitecture for ECC and Lossless Data Compression					 ---
-- Organization	: INAOE, Computer Science Department											 ---
-- Date			: July, 2004.																	 ---
----------------------------------------------------------------------------------------------------
--	Serial multiplier for F_2^m
----------------------------------------------------------------------------------------------------
-- Coments: The input buses need to have valid data when Reset signal is asserted
-- FSM are not used.
----------------------------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
--------------------------------------------------------
entity serial_multiplier_113 is
	generic (
		NUM_BITS : positive := 113							-- The order of the finite field
	);
	port(
	 	ax : in  std_logic_vector(NUM_BITS-1 downto 0); 
		bx : in  std_logic_vector(NUM_BITS-1 downto 0);	 
		cx : out std_logic_vector(NUM_BITS-1 downto 0);		-- cx = ax*bx mod Fx
		reset : in std_logic;
		clk	  : in std_logic;
		done  : out std_logic
	);	
end serial_multiplier_113;
-----------------------------------------------------------
architecture behave of serial_multiplier_113 is		  		
-----------------------------------------------------------
-- m = 113		  x113 + x9 + 1
constant Fx: std_logic_vector(NUM_BITS-1 downto 0) := "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000001";
-----------------------------------------------------------
signal Op1  	: std_logic_vector(NUM_BITS-1 downto 0);	-- Multiplexers for ax and cx  depending upon b_i and c_m 
signal Op2 		: std_logic_vector(NUM_BITS-1 downto 0);
signal bx_shift : std_logic_vector(NUM_BITS-1 downto 0);	-- B and C shifted one position to the rigth
signal cx_shift : std_logic_vector(NUM_BITS-1 downto 0);	
signal bx_int	: std_logic_vector(NUM_BITS-1 downto 0);	-- Internal registers 
signal cx_int	: std_logic_vector(NUM_BITS-1 downto 0);	-- Internal registers

signal counter: std_logic_vector(7 downto 0);				-- 8-bit counter, controling the number of iterations: m
signal done_int : std_logic;

begin
-----------------------------------------------------------
cx <= cx_int;												-- Result of the multiplication

Bx_shift <= bx_int(NUM_BITS-2 downto 0)& '0';				-- Shift Bx and Cx to left one position
Cx_shift <= cx_int(NUM_BITS-2 downto 0)& '0';
															-- Multiplexer to determine what value is added to C_x in each iteration
Op1 <= ax when bx_int(NUM_BITS-1) = '1' else				-- The selector for these multiplexors are the most significant bits of B_x and C_x
	(others => '0');
Op2 <= Fx when cx_int(NUM_BITS-1) = '1' else
	(others => '0');	
	
done <= done_int;
------------------------------------------------------------
-- The finite state machine, it takes m cycles to compute 
-- the multiplication, a counter is used to keep this count
------------------------------------------------------------
FSM_MUL: process (CLK)
	Begin						
		if CLK'event and CLK = '1' then
			if Reset = '1' then
				counter <= "01110000"; 						-- m-1 value, in this case, it is 162, be sure to set the correct value
			 	bx_int  <= bx;
				cx_int  <= (others => '0');
				Done_int    <= '0';	  
			else   
				if done_int = '0' then
					Cx_int  <= cx_shift xor Op1 xor Op2;
					counter <= counter - 1;
					bx_int <= bx_shift;
					if counter = "00000000" then			-- The done signal is asserted at the same time that the result is computed.
						Done_int <= '1';	
					end if;	
				end if;
			end if;	
		end if;	
end process;		 
end behave;
