library IEEE;
use IEEE.STD_LOGIC_1164.all; 
use IEEE.STD_LOGIC_unsigned.all; 
use IEEE.STD_LOGIC_arith.all;
----------------------------------------------------------------------------------------------------
entity mod_P is
	generic(       
		NUM_BITS : positive := 163
	);
	 port(
	     U : in STD_LOGIC_VECTOR(NUM_BITS downto 0);  
	 	 P : in STD_LOGIC_VECTOR(NUM_BITS downto 0); 
	 	 c0 : in STD_LOGIC; 
		 R   : out STD_LOGIC_VECTOR(NUM_BITS downto 0)	
	     );
end;
----------------------------------------------------------------------------------------------------
architecture behave of mod_P is		
----------------------------------------------------------------------------------------------------
signal R1: STD_LOGIC_VECTOR(NUM_BITS downto 0);	
begin
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------			
-- Finite state machine 
----------------------------------------------------------------------------------------------------

R1 <= U when c0 = '0' else
	 (U xor P); 

R <= '0'&R1(NUM_BITS downto 1);

end behave;