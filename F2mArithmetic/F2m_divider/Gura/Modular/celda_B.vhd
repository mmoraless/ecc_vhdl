library IEEE;
use IEEE.STD_LOGIC_1164.all; 
use IEEE.STD_LOGIC_unsigned.all; 
use IEEE.STD_LOGIC_arith.all;
----------------------------------------------------------------------------------------------------
entity celda_B is
	generic(       
		NUM_BITS : positive := 163
	);
	 port(
	       U : in STD_LOGIC_VECTOR(NUM_BITS downto 0);  
	 	   P : in STD_LOGIC_VECTOR(NUM_BITS downto 0); 
	 	  Y2 : in STD_LOGIC_VECTOR(NUM_BITS downto 0);
		 c_1 : in STD_LOGIC; 
		 c_2 : in STD_LOGIC; 
		 toB   : out STD_LOGIC_VECTOR(NUM_BITS downto 0)	-- U = x/y mod Fx,
	     );
end;
----------------------------------------------------------------------------------------------------
architecture behave of celda_B is		
----------------------------------------------------------------------------------------------------
begin
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------			
-- Finite state machine 
----------------------------------------------------------------------------------------------------
toB <=	Y2 when c_1 = '0' and c_2 = '0' else
		P when  c_1 = '0' and c_2 = '1' else
		U;
		
end behave;