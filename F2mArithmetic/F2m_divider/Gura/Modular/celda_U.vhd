library IEEE;
use IEEE.STD_LOGIC_1164.all; 
use IEEE.STD_LOGIC_unsigned.all; 
use IEEE.STD_LOGIC_arith.all;
----------------------------------------------------------------------------------------------------
entity celda_U is
	generic(       
		NUM_BITS : positive := 163
	);
	 port(
	  	 U : in STD_LOGIC_VECTOR(NUM_BITS downto 0); 
	 	 V : in STD_LOGIC_VECTOR(NUM_BITS downto 0); 
		 c0 : in STD_LOGIC; 
		 c1 : in STD_LOGIC;
		 toU   : out STD_LOGIC_VECTOR(NUM_BITS downto 0)	-- U = x/y mod Fx,
	     );
end;
----------------------------------------------------------------------------------------------------
architecture behave of celda_U is		
---------------------------------------------------------------------------------------------------- 
signal U1 : STD_LOGIC_VECTOR(NUM_BITS downto 0); 
signal V1 : STD_LOGIC_VECTOR(NUM_BITS downto 0); 
begin
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------			
-- Finite state machine 
----------------------------------------------------------------------------------------------------

U1 <= U when c0 = '1' else
	(others => '0');  
V1 <= V when c1 = '1' else
	  (others => '0');  

toU <= U1 xor V1;
end behave;