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
		 P : in STD_LOGIC_VECTOR(NUM_BITS downto 0); 
		 c0 : in STD_LOGIC; 
		 c1 : in STD_LOGIC;
		 c2 : in STD_LOGIC;
		 c3 : in STD_LOGIC;
		 rst : in STD_LOGIC;
		 clk : in STD_LOGIC;
		 toU   : out STD_LOGIC_VECTOR(NUM_BITS downto 0);
		 RegU   : out STD_LOGIC_VECTOR(NUM_BITS downto 0)
	     );
end;
----------------------------------------------------------------------------------------------------
architecture behave of celda_U is		
---------------------------------------------------------------------------------------------------- 
signal U1 : STD_LOGIC_VECTOR(NUM_BITS downto 0); 
signal V1 : STD_LOGIC_VECTOR(NUM_BITS downto 0); 
signal P1 : STD_LOGIC_VECTOR(NUM_BITS downto 0); 
signal R1 : STD_LOGIC_VECTOR(NUM_BITS downto 0); 
signal xr1 : STD_LOGIC_VECTOR(NUM_BITS downto 0); 
signal xr2 : STD_LOGIC_VECTOR(NUM_BITS downto 0); 
signal divx : STD_LOGIC_VECTOR(NUM_BITS downto 0); 
begin
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------			
-- Finite state machine 
----------------------------------------------------------------------------------------------------

U1 <= U when c0 = '1' else
	(others => '0');  
V1 <= V when c1 = '1' else
	  (others => '0');  

P1 <= P when c2 = '1' else
	  (others => '0');  

xr1 <= (U1 xor V1);
xr2 <= xr1 xor P1;

R1 <= xr1 when c2 = '0' else
		xr1 when xr1(0) = '0' and c2 = '1' else
		xr2;
		
divx <= '0'&R1(NUM_BITS downto 1);
toU <= divx;

celda_U_process: process (clk)
	begin -- syncronous reset
		if CLK'event and CLK = '1' then
			if (rst = '1')then
				RegU <= (others => '0'); 
			else
				if c3 = '1' then
					RegU <= divx;
				end if;	
			end if;
		end if;			
	end process;
end behave;