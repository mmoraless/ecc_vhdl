library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
--------------------------------------------------------
entity basic_cell is
	port(
	 	ai : in  std_logic; 
		bi : in  std_logic;	 
		c_i: in std_logic;
		clk: in std_logic; 
		rst: in std_logic;
		ci : out std_logic
	);	
end basic_cell;
-----------------------------------------------------------
architecture behave of  basic_cell is		  		
-----------------------------------------------------------
signal and_gate	 : std_logic;
signal xor_gate  : std_logic;
signal fflop : std_logic;

-----------------------------------------------------------
begin
-----------------------------------------------------------
and_gate <= ai and bi;
xor_gate <= and_gate xor c_i;  
ci <= fflop; 
------------------------------------------------------------
PROCESS_MUL: process (CLK)
	Begin						
		if CLK'event and CLK = '1' then
			if Rst = '1' then
				fflop <= '0';
			else 	
				fflop <= xor_gate;
			end if;
		end if;
end process;		 
end behave;
