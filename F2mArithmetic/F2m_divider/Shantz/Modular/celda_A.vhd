library IEEE;
use IEEE.STD_LOGIC_1164.all; 
use IEEE.STD_LOGIC_unsigned.all; 
use IEEE.STD_LOGIC_arith.all;
----------------------------------------------------------------------------------------------------
entity celda_A is
	generic(       
		NUM_BITS : positive := 163
	);
	 port(
	  	 A : in STD_LOGIC_VECTOR(NUM_BITS downto 0); 
	 	 B : in STD_LOGIC_VECTOR(NUM_BITS downto 0); 
		 c0 : in STD_LOGIC; 
		 c1 : in STD_LOGIC;
		 c3 : in STD_LOGIC;
		 rst : in STD_LOGIC; 
		 clk : in STD_LOGIC;
		 toA   : out STD_LOGIC_VECTOR(NUM_BITS downto 0);	-- U = x/y mod Fx,
		 RegA   : out STD_LOGIC_VECTOR(NUM_BITS downto 0)	-- U = x/y mod Fx,
	     );
end;
----------------------------------------------------------------------------------------------------
architecture behave of celda_A is		
----------------------------------------------------------------------------------------------------
signal R1,R2 : STD_LOGIC_VECTOR(NUM_BITS downto 0);  
signal A1 : STD_LOGIC_VECTOR(NUM_BITS downto 0); 
signal B1 : STD_LOGIC_VECTOR(NUM_BITS downto 0); 
begin
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------			
-- Finite state machine 
----------------------------------------------------------------------------------------------------

A1 <= A when c0 = '1' else
	(others => '0');  

B1 <= B when c1 = '1' else
	(others => '0');  
	
R1 <= A1 xor B1;  

R2 <= '0'&R1(NUM_BITS downto 1);

toA <= R2;


celda_A_process: process (clk)
	begin -- syncronous reset
		if CLK'event and CLK = '1' then
			if (rst = '1')then
				RegA <= (others => '0'); 
			else
				if c3 = '1' then
					RegA <= R2;
				end if;	
			end if;
		end if;			
	end process;
end behave;

