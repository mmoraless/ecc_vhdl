library IEEE;
use IEEE.STD_LOGIC_1164.all; 
use IEEE.STD_LOGIC_unsigned.all; 
use IEEE.STD_LOGIC_arith.all;
----------------------------------------------------------------------------------------------------
entity celda_r is
	generic(       
		NUM_BITS : positive := 163
	);
	 port(
	  	 R_div_2 : in STD_LOGIC_VECTOR(NUM_BITS-1 downto 0); 
	 	 P_div_2 : in STD_LOGIC_VECTOR(NUM_BITS-1 downto 0); 
		 S_div_2 : in STD_LOGIC_VECTOR(NUM_BITS-1 downto 0); 
		 c_3  : in STD_LOGIC; 
		 c_0  : in STD_LOGIC;
		 clk  : in STD_LOGIC;
		 rst  : in STD_LOGIC;
		 R    : out STD_LOGIC_VECTOR(NUM_BITS-1 downto 0)	-- U = x/y mod Fx,
	     );
end;
----------------------------------------------------------------------------------------------------
architecture behave of celda_r is		
----------------------------------------------------------------------------------------------------
begin
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------			
-- Finite state machine 
----------------------------------------------------------------------------------------------------
Celda_r_process: process (clk)
	begin -- syncronous reset
		if CLK'event and CLK = '1' then
			if (rst = '1')then
				R <= (others => '0');		   
			else	
				if c_3 = '1' and C_0 = '1' then 
					R <= R_div_2 xor P_div_2 xor S_div_2;
				elsif c_3 = '1' and C_0 = '0' then 
					R <= R_div_2 xor P_div_2;
				elsif c_3 = '0' and C_0 = '1' then 	
					R <= R_div_2 xor S_div_2;
				else
					R <= R_div_2;
				end if;
			end if;			 
		end if;			
	end process;
end behave;