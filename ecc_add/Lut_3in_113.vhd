library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;  
---------------------------------------------------------------------------------------------
entity lut_3in is				
	
	generic(  	 
		NUM_BITS: positive := 113
	);	
	port (
		A: in STD_LOGIC_VECTOR(NUM_BITS-1 downto 0);
		s0: in STD_LOGIC;
		B: in STD_LOGIC_VECTOR(NUM_BITS-1 downto 0);
		D: out STD_LOGIC_VECTOR(NUM_BITS-1 downto 0)
	);
end;
---------------------------------------------------------------------------------------------
architecture behave of lut_3in is		   
---------------------------------------------------------------------------
---------------------------------------------------------------------------
begin																	   
D(0) <= (A(0) and s0) xor B(0);
D(1) <= (A(1) and s0) xor B(1);
D(2) <= (A(2) and s0) xor B(2);
D(3) <= (A(3) and s0) xor B(3);
D(4) <= (A(4) and s0) xor B(4);
D(5) <= (A(5) and s0) xor B(5);
D(6) <= (A(6) and s0) xor B(6);
D(7) <= (A(7) and s0) xor B(7);
D(8) <= (A(8) and s0) xor B(8);
D(9) <= (A(9) and s0) xor B(9);
D(10) <= (A(10) and s0) xor B(10);
D(11) <= (A(11) and s0) xor B(11);
D(12) <= (A(12) and s0) xor B(12);
D(13) <= (A(13) and s0) xor B(13);
D(14) <= (A(14) and s0) xor B(14);
D(15) <= (A(15) and s0) xor B(15);
D(16) <= (A(16) and s0) xor B(16);
D(17) <= (A(17) and s0) xor B(17);
D(18) <= (A(18) and s0) xor B(18);
D(19) <= (A(19) and s0) xor B(19);
D(20) <= (A(20) and s0) xor B(20);
D(21) <= (A(21) and s0) xor B(21);
D(22) <= (A(22) and s0) xor B(22);
D(23) <= (A(23) and s0) xor B(23);
D(24) <= (A(24) and s0) xor B(24);
D(25) <= (A(25) and s0) xor B(25);
D(26) <= (A(26) and s0) xor B(26);
D(27) <= (A(27) and s0) xor B(27);
D(28) <= (A(28) and s0) xor B(28);
D(29) <= (A(29) and s0) xor B(29);
D(30) <= (A(30) and s0) xor B(30);
D(31) <= (A(31) and s0) xor B(31);
D(32) <= (A(32) and s0) xor B(32);
D(33) <= (A(33) and s0) xor B(33);
D(34) <= (A(34) and s0) xor B(34);
D(35) <= (A(35) and s0) xor B(35);
D(36) <= (A(36) and s0) xor B(36);
D(37) <= (A(37) and s0) xor B(37);
D(38) <= (A(38) and s0) xor B(38);
D(39) <= (A(39) and s0) xor B(39);
D(40) <= (A(40) and s0) xor B(40);
D(41) <= (A(41) and s0) xor B(41);
D(42) <= (A(42) and s0) xor B(42);
D(43) <= (A(43) and s0) xor B(43);
D(44) <= (A(44) and s0) xor B(44);
D(45) <= (A(45) and s0) xor B(45);
D(46) <= (A(46) and s0) xor B(46);
D(47) <= (A(47) and s0) xor B(47);
D(48) <= (A(48) and s0) xor B(48);
D(49) <= (A(49) and s0) xor B(49);
D(50) <= (A(50) and s0) xor B(50);
D(51) <= (A(51) and s0) xor B(51);
D(52) <= (A(52) and s0) xor B(52);
D(53) <= (A(53) and s0) xor B(53);
D(54) <= (A(54) and s0) xor B(54);
D(55) <= (A(55) and s0) xor B(55);
D(56) <= (A(56) and s0) xor B(56);
D(57) <= (A(57) and s0) xor B(57);
D(58) <= (A(58) and s0) xor B(58);
D(59) <= (A(59) and s0) xor B(59);
D(60) <= (A(60) and s0) xor B(60);
D(61) <= (A(61) and s0) xor B(61);
D(62) <= (A(62) and s0) xor B(62);
D(63) <= (A(63) and s0) xor B(63);
D(64) <= (A(64) and s0) xor B(64);
D(65) <= (A(65) and s0) xor B(65);
D(66) <= (A(66) and s0) xor B(66);
D(67) <= (A(67) and s0) xor B(67);
D(68) <= (A(68) and s0) xor B(68);
D(69) <= (A(69) and s0) xor B(69);
D(70) <= (A(70) and s0) xor B(70);
D(71) <= (A(71) and s0) xor B(71);
D(72) <= (A(72) and s0) xor B(72);
D(73) <= (A(73) and s0) xor B(73);
D(74) <= (A(74) and s0) xor B(74);
D(75) <= (A(75) and s0) xor B(75);
D(76) <= (A(76) and s0) xor B(76);
D(77) <= (A(77) and s0) xor B(77);
D(78) <= (A(78) and s0) xor B(78);
D(79) <= (A(79) and s0) xor B(79);
D(80) <= (A(80) and s0) xor B(80);
D(81) <= (A(81) and s0) xor B(81);
D(82) <= (A(82) and s0) xor B(82);
D(83) <= (A(83) and s0) xor B(83);
D(84) <= (A(84) and s0) xor B(84);
D(85) <= (A(85) and s0) xor B(85);
D(86) <= (A(86) and s0) xor B(86);
D(87) <= (A(87) and s0) xor B(87);
D(88) <= (A(88) and s0) xor B(88);
D(89) <= (A(89) and s0) xor B(89);
D(90) <= (A(90) and s0) xor B(90);
D(91) <= (A(91) and s0) xor B(91);
D(92) <= (A(92) and s0) xor B(92);
D(93) <= (A(93) and s0) xor B(93);
D(94) <= (A(94) and s0) xor B(94);
D(95) <= (A(95) and s0) xor B(95);
D(96) <= (A(96) and s0) xor B(96);
D(97) <= (A(97) and s0) xor B(97);
D(98) <= (A(98) and s0) xor B(98);
D(99) <= (A(99) and s0) xor B(99);
D(100) <= (A(100) and s0) xor B(100);
D(101) <= (A(101) and s0) xor B(101);
D(102) <= (A(102) and s0) xor B(102);
D(103) <= (A(103) and s0) xor B(103);
D(104) <= (A(104) and s0) xor B(104);
D(105) <= (A(105) and s0) xor B(105);
D(106) <= (A(106) and s0) xor B(106);
D(107) <= (A(107) and s0) xor B(107);
D(108) <= (A(108) and s0) xor B(108);
D(109) <= (A(109) and s0) xor B(109);
D(110) <= (A(110) and s0) xor B(110);
D(111) <= (A(111) and s0) xor B(111);
D(112) <= (A(112) and s0) xor B(112);

end;