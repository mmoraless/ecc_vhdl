library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
--------------------------------------------------------
-- Sin celda y sin maquina de estados
--------------------------------------------------------

-- x^113 + x ^9 + 1
entity serial_multiplier_113 is
	generic (
		NUM_BITS : positive := 113							-- The order of the finite field
	);
	port(
	 	ax : in  std_logic_vector(NUM_BITS-1 downto 0); 
		bx : in  std_logic_vector(NUM_BITS-1 downto 0);	 
		cx : out std_logic_vector(NUM_BITS-1 downto 0);		-- cx = ax*bx mod Fx
		reset : in std_logic;
		clk	  : in std_logic;
		done  : out std_logic
	);	
end serial_multiplier_113;
-----------------------------------------------------------
architecture behave of serial_multiplier_113 is		  		
-----------------------------------------------------------

signal bx_shift : std_logic_vector(NUM_BITS-1 downto 0);	-- B and C shifted one position to the rigth
signal bx_int	: std_logic_vector(NUM_BITS-1 downto 0);	-- Internal registers 
signal cx_int	: std_logic_vector(NUM_BITS-1 downto 0);	-- Internal registers
signal counter: std_logic_vector(7 downto 0);				-- 8-bit counter, controling the number of iterations: m

signal done_int : std_logic;
--señales para las xor de la reduccion:
signal xor_1 : std_logic;
-----------------------------------------------------------
-- States for the finite state machine
-----------------------------------------------------------
--type CurrentState_type is (NOTHING, END_STATE, MUL_STATE);			
--signal CurrentState: CurrentState_type;					
-----------------------------------------------------------
begin
-----------------------------------------------------------
-- Result of the multiplication

xor_1 <= Cx_int(8) xor Cx_int(NUM_BITS-1);


--Bx_shift <= bx_int(NUM_BITS-2 downto 0)& '0';				-- Shift Bx to left one position															

bx_int <= Bx_shift;				-- Shift Bx to left one position															
------------------------------------------------------------
-- The finite state machine, it takes m cycles to compute 
-- the multiplication, a counter is used to keep this count
------------------------------------------------------------

done <= done_int;
cx <= cx_int;

FSM_MUL: process (CLK)
	Begin						
		if CLK'event and CLK = '1' then
			if Reset = '1' then
				counter <= "00000000"; 						-- m-1 value, in this case, it is 112, be sure to set the correct value
			 	cx_int <= (others => '0');
				Done_int <= '0';				
			else 	  
				if done_int = '0' then
					counter <= counter + 1;
					Cx_int(0) <= ( Ax(0) and Bx_int(NUM_BITS-1) ) xor Cx_int(NUM_BITS-1);
					Cx_int(1) <= ( Ax(1) and Bx_int(NUM_BITS-1) ) xor Cx_int(0);
					Cx_int(2) <= ( Ax(2) and Bx_int(NUM_BITS-1) ) xor Cx_int(1);
					Cx_int(3) <= ( Ax(3) and Bx_int(NUM_BITS-1) ) xor Cx_int(2);
					Cx_int(4) <= ( Ax(4) and Bx_int(NUM_BITS-1) ) xor Cx_int(3);
					Cx_int(5) <= ( Ax(5) and Bx_int(NUM_BITS-1) ) xor Cx_int(4);
					Cx_int(6) <= ( Ax(6) and Bx_int(NUM_BITS-1) ) xor Cx_int(5);
					Cx_int(7) <= ( Ax(7) and Bx_int(NUM_BITS-1) ) xor Cx_int(6);
					Cx_int(8) <= ( Ax(8) and Bx_int(NUM_BITS-1) ) xor Cx_int(7);
					Cx_int(9) <= ( Ax(9) and Bx_int(NUM_BITS-1) ) xor xor_1; 
					Cx_int(10) <= ( Ax(10) and Bx_int(NUM_BITS-1) ) xor Cx_int(9);
					Cx_int(11) <= ( Ax(11) and Bx_int(NUM_BITS-1) ) xor Cx_int(10);
					Cx_int(12) <= ( Ax(12) and Bx_int(NUM_BITS-1) ) xor Cx_int(11);
					Cx_int(13) <= ( Ax(13) and Bx_int(NUM_BITS-1) ) xor Cx_int(12);
					Cx_int(14) <= ( Ax(14) and Bx_int(NUM_BITS-1) ) xor Cx_int(13);
					Cx_int(15) <= ( Ax(15) and Bx_int(NUM_BITS-1) ) xor Cx_int(14);
					Cx_int(16) <= ( Ax(16) and Bx_int(NUM_BITS-1) ) xor Cx_int(15);
					Cx_int(17) <= ( Ax(17) and Bx_int(NUM_BITS-1) ) xor Cx_int(16);
					Cx_int(18) <= ( Ax(18) and Bx_int(NUM_BITS-1) ) xor Cx_int(17);
					Cx_int(19) <= ( Ax(19) and Bx_int(NUM_BITS-1) ) xor Cx_int(18);
					Cx_int(20) <= ( Ax(20) and Bx_int(NUM_BITS-1) ) xor Cx_int(19);
					Cx_int(21) <= ( Ax(21) and Bx_int(NUM_BITS-1) ) xor Cx_int(20);
					Cx_int(22) <= ( Ax(22) and Bx_int(NUM_BITS-1) ) xor Cx_int(21);
					Cx_int(23) <= ( Ax(23) and Bx_int(NUM_BITS-1) ) xor Cx_int(22);
					Cx_int(24) <= ( Ax(24) and Bx_int(NUM_BITS-1) ) xor Cx_int(23);
					Cx_int(25) <= ( Ax(25) and Bx_int(NUM_BITS-1) ) xor Cx_int(24);
					Cx_int(26) <= ( Ax(26) and Bx_int(NUM_BITS-1) ) xor Cx_int(25);
					Cx_int(27) <= ( Ax(27) and Bx_int(NUM_BITS-1) ) xor Cx_int(26);
					Cx_int(28) <= ( Ax(28) and Bx_int(NUM_BITS-1) ) xor Cx_int(27);
					Cx_int(29) <= ( Ax(29) and Bx_int(NUM_BITS-1) ) xor Cx_int(28);
					Cx_int(30) <= ( Ax(30) and Bx_int(NUM_BITS-1) ) xor Cx_int(29);
					Cx_int(31) <= ( Ax(31) and Bx_int(NUM_BITS-1) ) xor Cx_int(30);
					Cx_int(32) <= ( Ax(32) and Bx_int(NUM_BITS-1) ) xor Cx_int(31);
					Cx_int(33) <= ( Ax(33) and Bx_int(NUM_BITS-1) ) xor Cx_int(32);
					Cx_int(34) <= ( Ax(34) and Bx_int(NUM_BITS-1) ) xor Cx_int(33);
					Cx_int(35) <= ( Ax(35) and Bx_int(NUM_BITS-1) ) xor Cx_int(34);
					Cx_int(36) <= ( Ax(36) and Bx_int(NUM_BITS-1) ) xor Cx_int(35);
					Cx_int(37) <= ( Ax(37) and Bx_int(NUM_BITS-1) ) xor Cx_int(36);
					Cx_int(38) <= ( Ax(38) and Bx_int(NUM_BITS-1) ) xor Cx_int(37);
					Cx_int(39) <= ( Ax(39) and Bx_int(NUM_BITS-1) ) xor Cx_int(38);
					Cx_int(40) <= ( Ax(40) and Bx_int(NUM_BITS-1) ) xor Cx_int(39);
					Cx_int(41) <= ( Ax(41) and Bx_int(NUM_BITS-1) ) xor Cx_int(40);
					Cx_int(42) <= ( Ax(42) and Bx_int(NUM_BITS-1) ) xor Cx_int(41);
					Cx_int(43) <= ( Ax(43) and Bx_int(NUM_BITS-1) ) xor Cx_int(42);
					Cx_int(44) <= ( Ax(44) and Bx_int(NUM_BITS-1) ) xor Cx_int(43);
					Cx_int(45) <= ( Ax(45) and Bx_int(NUM_BITS-1) ) xor Cx_int(44);
					Cx_int(46) <= ( Ax(46) and Bx_int(NUM_BITS-1) ) xor Cx_int(45);
					Cx_int(47) <= ( Ax(47) and Bx_int(NUM_BITS-1) ) xor Cx_int(46);
					Cx_int(48) <= ( Ax(48) and Bx_int(NUM_BITS-1) ) xor Cx_int(47);
					Cx_int(49) <= ( Ax(49) and Bx_int(NUM_BITS-1) ) xor Cx_int(48);
					Cx_int(50) <= ( Ax(50) and Bx_int(NUM_BITS-1) ) xor Cx_int(49);
					Cx_int(51) <= ( Ax(51) and Bx_int(NUM_BITS-1) ) xor Cx_int(50);
					Cx_int(52) <= ( Ax(52) and Bx_int(NUM_BITS-1) ) xor Cx_int(51);
					Cx_int(53) <= ( Ax(53) and Bx_int(NUM_BITS-1) ) xor Cx_int(52);
					Cx_int(54) <= ( Ax(54) and Bx_int(NUM_BITS-1) ) xor Cx_int(53);
					Cx_int(55) <= ( Ax(55) and Bx_int(NUM_BITS-1) ) xor Cx_int(54);
					Cx_int(56) <= ( Ax(56) and Bx_int(NUM_BITS-1) ) xor Cx_int(55);
					Cx_int(57) <= ( Ax(57) and Bx_int(NUM_BITS-1) ) xor Cx_int(56);
					Cx_int(58) <= ( Ax(58) and Bx_int(NUM_BITS-1) ) xor Cx_int(57);
					Cx_int(59) <= ( Ax(59) and Bx_int(NUM_BITS-1) ) xor Cx_int(58);
					Cx_int(60) <= ( Ax(60) and Bx_int(NUM_BITS-1) ) xor Cx_int(59);
					Cx_int(61) <= ( Ax(61) and Bx_int(NUM_BITS-1) ) xor Cx_int(60);
					Cx_int(62) <= ( Ax(62) and Bx_int(NUM_BITS-1) ) xor Cx_int(61);
					Cx_int(63) <= ( Ax(63) and Bx_int(NUM_BITS-1) ) xor Cx_int(62);
					Cx_int(64) <= ( Ax(64) and Bx_int(NUM_BITS-1) ) xor Cx_int(63);
					Cx_int(65) <= ( Ax(65) and Bx_int(NUM_BITS-1) ) xor Cx_int(64);
					Cx_int(66) <= ( Ax(66) and Bx_int(NUM_BITS-1) ) xor Cx_int(65);
					Cx_int(67) <= ( Ax(67) and Bx_int(NUM_BITS-1) ) xor Cx_int(66);
					Cx_int(68) <= ( Ax(68) and Bx_int(NUM_BITS-1) ) xor Cx_int(67);
					Cx_int(69) <= ( Ax(69) and Bx_int(NUM_BITS-1) ) xor Cx_int(68);
					Cx_int(70) <= ( Ax(70) and Bx_int(NUM_BITS-1) ) xor Cx_int(69);
					Cx_int(71) <= ( Ax(71) and Bx_int(NUM_BITS-1) ) xor Cx_int(70);
					Cx_int(72) <= ( Ax(72) and Bx_int(NUM_BITS-1) ) xor Cx_int(71);
					Cx_int(73) <= ( Ax(73) and Bx_int(NUM_BITS-1) ) xor Cx_int(72);
					Cx_int(74) <= ( Ax(74) and Bx_int(NUM_BITS-1) ) xor Cx_int(73);
					Cx_int(75) <= ( Ax(75) and Bx_int(NUM_BITS-1) ) xor Cx_int(74);
					Cx_int(76) <= ( Ax(76) and Bx_int(NUM_BITS-1) ) xor Cx_int(75);
					Cx_int(77) <= ( Ax(77) and Bx_int(NUM_BITS-1) ) xor Cx_int(76);
					Cx_int(78) <= ( Ax(78) and Bx_int(NUM_BITS-1) ) xor Cx_int(77);
					Cx_int(79) <= ( Ax(79) and Bx_int(NUM_BITS-1) ) xor Cx_int(78);
					Cx_int(80) <= ( Ax(80) and Bx_int(NUM_BITS-1) ) xor Cx_int(79);
					Cx_int(81) <= ( Ax(81) and Bx_int(NUM_BITS-1) ) xor Cx_int(80);
					Cx_int(82) <= ( Ax(82) and Bx_int(NUM_BITS-1) ) xor Cx_int(81);
					Cx_int(83) <= ( Ax(83) and Bx_int(NUM_BITS-1) ) xor Cx_int(82);
					Cx_int(84) <= ( Ax(84) and Bx_int(NUM_BITS-1) ) xor Cx_int(83);
					Cx_int(85) <= ( Ax(85) and Bx_int(NUM_BITS-1) ) xor Cx_int(84);
					Cx_int(86) <= ( Ax(86) and Bx_int(NUM_BITS-1) ) xor Cx_int(85);
					Cx_int(87) <= ( Ax(87) and Bx_int(NUM_BITS-1) ) xor Cx_int(86);
					Cx_int(88) <= ( Ax(88) and Bx_int(NUM_BITS-1) ) xor Cx_int(87);
					Cx_int(89) <= ( Ax(89) and Bx_int(NUM_BITS-1) ) xor Cx_int(88);
					Cx_int(90) <= ( Ax(90) and Bx_int(NUM_BITS-1) ) xor Cx_int(89);
					Cx_int(91) <= ( Ax(91) and Bx_int(NUM_BITS-1) ) xor Cx_int(90);
					Cx_int(92) <= ( Ax(92) and Bx_int(NUM_BITS-1) ) xor Cx_int(91);
					Cx_int(93) <= ( Ax(93) and Bx_int(NUM_BITS-1) ) xor Cx_int(92);
					Cx_int(94) <= ( Ax(94) and Bx_int(NUM_BITS-1) ) xor Cx_int(93);
					Cx_int(95) <= ( Ax(95) and Bx_int(NUM_BITS-1) ) xor Cx_int(94);
					Cx_int(96) <= ( Ax(96) and Bx_int(NUM_BITS-1) ) xor Cx_int(95);
					Cx_int(97) <= ( Ax(97) and Bx_int(NUM_BITS-1) ) xor Cx_int(96);
					Cx_int(98) <= ( Ax(98) and Bx_int(NUM_BITS-1) ) xor Cx_int(97);
					Cx_int(99) <= ( Ax(99) and Bx_int(NUM_BITS-1) ) xor Cx_int(98);
					Cx_int(100) <= ( Ax(100) and Bx_int(NUM_BITS-1) ) xor Cx_int(99);
					Cx_int(101) <= ( Ax(101) and Bx_int(NUM_BITS-1) ) xor Cx_int(100);
					Cx_int(102) <= ( Ax(102) and Bx_int(NUM_BITS-1) ) xor Cx_int(101);
					Cx_int(103) <= ( Ax(103) and Bx_int(NUM_BITS-1) ) xor Cx_int(102);
					Cx_int(104) <= ( Ax(104) and Bx_int(NUM_BITS-1) ) xor Cx_int(103);
					Cx_int(105) <= ( Ax(105) and Bx_int(NUM_BITS-1) ) xor Cx_int(104);
					Cx_int(106) <= ( Ax(106) and Bx_int(NUM_BITS-1) ) xor Cx_int(105);
					Cx_int(107) <= ( Ax(107) and Bx_int(NUM_BITS-1) ) xor Cx_int(106);
					Cx_int(108) <= ( Ax(108) and Bx_int(NUM_BITS-1) ) xor Cx_int(107);
					Cx_int(109) <= ( Ax(109) and Bx_int(NUM_BITS-1) ) xor Cx_int(108);
					Cx_int(110) <= ( Ax(110) and Bx_int(NUM_BITS-1) ) xor Cx_int(109);
					Cx_int(111) <= ( Ax(111) and Bx_int(NUM_BITS-1) ) xor Cx_int(110);
					Cx_int(112) <= ( Ax(112) and Bx_int(NUM_BITS-1) ) xor Cx_int(111);
				end if;
				
				if counter = "01110000" then
				  	done_int <= '1';	
				end if;	
				
			end if;
		end if;
end process;		 

SHIFT_REGISTER: process (CLK)
	Begin						
		if CLK'event and CLK = '1' then
			if Reset = '1' then
				Bx_shift  <= Bx;	
			else 	
				Bx_shift <= Bx_shift(NUM_BITS-2 downto 0) & '0'; -- carga paralela
			end if;
		end if;	
end process;		 

end behave;


