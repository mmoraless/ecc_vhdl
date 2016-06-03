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
		 c1 : in STD_LOGIC; 
		 c2 : in STD_LOGIC; 
		 c3 : in STD_LOGIC; 
		 clk : in STD_LOGIC;
		 RegB   : out STD_LOGIC_VECTOR(NUM_BITS downto 0)
	     );
end;
----------------------------------------------------------------------------------------------------
architecture behave of celda_B is		
----------------------------------------------------------------------------------------------------
signal toB : STD_LOGIC_VECTOR(NUM_BITS downto 0);  

begin
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------			
-- Finite state machine 
----------------------------------------------------------------------------------------------------
toB <=	Y2 when c1 = '0' and c2 = '0' else
		P when  c1 = '0' and c2 = '1' else
		U;
		
celda_B_process: process (clk)
	begin -- syncronous reset
		if CLK'event and CLK = '1' then
			if c3 = '1' then
				RegB <= toB;
			end if;	
		end if;			
	end process;

end behave;
