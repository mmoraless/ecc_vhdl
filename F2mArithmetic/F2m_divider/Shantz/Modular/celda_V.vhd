
library IEEE;
use IEEE.STD_LOGIC_1164.all; 
use IEEE.STD_LOGIC_unsigned.all; 
use IEEE.STD_LOGIC_arith.all;
----------------------------------------------------------------------------------------------------
entity celda_V is
	generic(       
		NUM_BITS : positive := 163
	);
	 port(
	     R : in STD_LOGIC_VECTOR(NUM_BITS downto 0);  
	 	 X2 : in STD_LOGIC_VECTOR(NUM_BITS downto 0);
		 c1 : in STD_LOGIC; 
		 c2 : in STD_LOGIC; 
		 c3 : in STD_LOGIC; 
		 clk : in STD_LOGIC;
		 RegV   : out STD_LOGIC_VECTOR(NUM_BITS downto 0)
	     );
end;
----------------------------------------------------------------------------------------------------
architecture behave of celda_V is		
----------------------------------------------------------------------------------------------------
signal toV : STD_LOGIC_VECTOR(NUM_BITS downto 0);  

begin
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------			
-- Finite state machine 
----------------------------------------------------------------------------------------------------
toV <= X2 when c1 = '0' and c2 = '0' else
	   (others => '0') when c1 = '0' and c2 = '1' else
		R;
		
celda_V_process: process (clk)
	begin -- syncronous reset
		if CLK'event and CLK = '1' then
			if c3 = '1' then
				RegV <= toV;
			end if;	
		end if;			
	end process;

end behave;
