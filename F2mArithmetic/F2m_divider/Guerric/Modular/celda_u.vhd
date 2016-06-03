library IEEE;
use IEEE.STD_LOGIC_1164.all; 
use IEEE.STD_LOGIC_unsigned.all; 
use IEEE.STD_LOGIC_arith.all;
----------------------------------------------------------------------------------------------------
entity celda_u is
	generic(       
		NUM_BITS : positive := 163
	);
	 port(
	  	 V_div_2 : in STD_LOGIC_VECTOR(NUM_BITS-1 downto 0); 
	 	 U_div_2 : in STD_LOGIC_VECTOR(NUM_BITS-1 downto 0);
		 c_0  : in STD_LOGIC;
		 clk  : in STD_LOGIC;
		 rst  : in STD_LOGIC;
		 U    : out STD_LOGIC_VECTOR(NUM_BITS-1 downto 0)	-- U = x/y mod Fx,
	     );
end;
----------------------------------------------------------------------------------------------------
architecture behave of celda_u is		
----------------------------------------------------------------------------------------------------
begin
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------			
-- Finite state machine 
----------------------------------------------------------------------------------------------------
Celda_u_process: process (clk)
	begin -- syncronous reset
		if CLK'event and CLK = '1' then
			if (rst = '1')then
				U <= (others => '0');		   
			else	
				if c_0 = '1' then 
					U <= V_div_2 xor U_div_2;
				else
					U <= U_div_2;
				end if;
			end if;			 
		end if;			
	end process;
end behave;