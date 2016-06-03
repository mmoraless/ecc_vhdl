library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;  
---------------------------------------------------------------------------------------------
entity lut_3inadd is				
	
	generic(  	 
		NUM_BITS: positive := 113
	);	
	port (
		I: in STD_LOGIC_VECTOR(NUM_BITS-1 downto 0);
		B: in STD_LOGIC_VECTOR(NUM_BITS-1 downto 0);
		C: in STD_LOGIC_VECTOR(NUM_BITS-1 downto 0);
		D: out STD_LOGIC_VECTOR(NUM_BITS-1 downto 0)
	);
end;
---------------------------------------------------------------------------------------------
architecture behave of lut_3inadd is		   
---------------------------------------------------------------------------
---------------------------------------------------------------------------
constant a    : std_logic_vector(NUM_BITS-1 downto 0):= "00011000010001000001001010000110010100110111001111100011111111110011001001001110011101000010110000010000011110111";

begin																	   
D(0) <= I(0) xor B(0) xor C(0) xor a(0);
D(1) <= I(1) xor B(1) xor C(1) xor a(1);
D(2) <= I(2) xor B(2) xor C(2) xor a(2);
D(3) <= I(3) xor B(3) xor C(3) xor a(3);
D(4) <= I(4) xor B(4) xor C(4) xor a(4);
D(5) <= I(5) xor B(5) xor C(5) xor a(5);
D(6) <= I(6) xor B(6) xor C(6) xor a(6);
D(7) <= I(7) xor B(7) xor C(7) xor a(7);
D(8) <= I(8) xor B(8) xor C(8) xor a(8);
D(9) <= I(9) xor B(9) xor C(9) xor a(9);
D(10) <= I(10) xor B(10) xor C(10) xor a(10);
D(11) <= I(11) xor B(11) xor C(11) xor a(11);
D(12) <= I(12) xor B(12) xor C(12) xor a(12);
D(13) <= I(13) xor B(13) xor C(13) xor a(13);
D(14) <= I(14) xor B(14) xor C(14) xor a(14);
D(15) <= I(15) xor B(15) xor C(15) xor a(15);
D(16) <= I(16) xor B(16) xor C(16) xor a(16);
D(17) <= I(17) xor B(17) xor C(17) xor a(17);
D(18) <= I(18) xor B(18) xor C(18) xor a(18);
D(19) <= I(19) xor B(19) xor C(19) xor a(19);
D(20) <= I(20) xor B(20) xor C(20) xor a(20);
D(21) <= I(21) xor B(21) xor C(21) xor a(21);
D(22) <= I(22) xor B(22) xor C(22) xor a(22);
D(23) <= I(23) xor B(23) xor C(23) xor a(23);
D(24) <= I(24) xor B(24) xor C(24) xor a(24);
D(25) <= I(25) xor B(25) xor C(25) xor a(25);
D(26) <= I(26) xor B(26) xor C(26) xor a(26);
D(27) <= I(27) xor B(27) xor C(27) xor a(27);
D(28) <= I(28) xor B(28) xor C(28) xor a(28);
D(29) <= I(29) xor B(29) xor C(29) xor a(29);
D(30) <= I(30) xor B(30) xor C(30) xor a(30);
D(31) <= I(31) xor B(31) xor C(31) xor a(31);
D(32) <= I(32) xor B(32) xor C(32) xor a(32);
D(33) <= I(33) xor B(33) xor C(33) xor a(33);
D(34) <= I(34) xor B(34) xor C(34) xor a(34);
D(35) <= I(35) xor B(35) xor C(35) xor a(35);
D(36) <= I(36) xor B(36) xor C(36) xor a(36);
D(37) <= I(37) xor B(37) xor C(37) xor a(37);
D(38) <= I(38) xor B(38) xor C(38) xor a(38);
D(39) <= I(39) xor B(39) xor C(39) xor a(39);
D(40) <= I(40) xor B(40) xor C(40) xor a(40);
D(41) <= I(41) xor B(41) xor C(41) xor a(41);
D(42) <= I(42) xor B(42) xor C(42) xor a(42);
D(43) <= I(43) xor B(43) xor C(43) xor a(43);
D(44) <= I(44) xor B(44) xor C(44) xor a(44);
D(45) <= I(45) xor B(45) xor C(45) xor a(45);
D(46) <= I(46) xor B(46) xor C(46) xor a(46);
D(47) <= I(47) xor B(47) xor C(47) xor a(47);
D(48) <= I(48) xor B(48) xor C(48) xor a(48);
D(49) <= I(49) xor B(49) xor C(49) xor a(49);
D(50) <= I(50) xor B(50) xor C(50) xor a(50);
D(51) <= I(51) xor B(51) xor C(51) xor a(51);
D(52) <= I(52) xor B(52) xor C(52) xor a(52);
D(53) <= I(53) xor B(53) xor C(53) xor a(53);
D(54) <= I(54) xor B(54) xor C(54) xor a(54);
D(55) <= I(55) xor B(55) xor C(55) xor a(55);
D(56) <= I(56) xor B(56) xor C(56) xor a(56);
D(57) <= I(57) xor B(57) xor C(57) xor a(57);
D(58) <= I(58) xor B(58) xor C(58) xor a(58);
D(59) <= I(59) xor B(59) xor C(59) xor a(59);
D(60) <= I(60) xor B(60) xor C(60) xor a(60);
D(61) <= I(61) xor B(61) xor C(61) xor a(61);
D(62) <= I(62) xor B(62) xor C(62) xor a(62);
D(63) <= I(63) xor B(63) xor C(63) xor a(63);
D(64) <= I(64) xor B(64) xor C(64) xor a(64);
D(65) <= I(65) xor B(65) xor C(65) xor a(65);
D(66) <= I(66) xor B(66) xor C(66) xor a(66);
D(67) <= I(67) xor B(67) xor C(67) xor a(67);
D(68) <= I(68) xor B(68) xor C(68) xor a(68);
D(69) <= I(69) xor B(69) xor C(69) xor a(69);
D(70) <= I(70) xor B(70) xor C(70) xor a(70);
D(71) <= I(71) xor B(71) xor C(71) xor a(71);
D(72) <= I(72) xor B(72) xor C(72) xor a(72);
D(73) <= I(73) xor B(73) xor C(73) xor a(73);
D(74) <= I(74) xor B(74) xor C(74) xor a(74);
D(75) <= I(75) xor B(75) xor C(75) xor a(75);
D(76) <= I(76) xor B(76) xor C(76) xor a(76);
D(77) <= I(77) xor B(77) xor C(77) xor a(77);
D(78) <= I(78) xor B(78) xor C(78) xor a(78);
D(79) <= I(79) xor B(79) xor C(79) xor a(79);
D(80) <= I(80) xor B(80) xor C(80) xor a(80);
D(81) <= I(81) xor B(81) xor C(81) xor a(81);
D(82) <= I(82) xor B(82) xor C(82) xor a(82);
D(83) <= I(83) xor B(83) xor C(83) xor a(83);
D(84) <= I(84) xor B(84) xor C(84) xor a(84);
D(85) <= I(85) xor B(85) xor C(85) xor a(85);
D(86) <= I(86) xor B(86) xor C(86) xor a(86);
D(87) <= I(87) xor B(87) xor C(87) xor a(87);
D(88) <= I(88) xor B(88) xor C(88) xor a(88);
D(89) <= I(89) xor B(89) xor C(89) xor a(89);
D(90) <= I(90) xor B(90) xor C(90) xor a(90);
D(91) <= I(91) xor B(91) xor C(91) xor a(91);
D(92) <= I(92) xor B(92) xor C(92) xor a(92);
D(93) <= I(93) xor B(93) xor C(93) xor a(93);
D(94) <= I(94) xor B(94) xor C(94) xor a(94);
D(95) <= I(95) xor B(95) xor C(95) xor a(95);
D(96) <= I(96) xor B(96) xor C(96) xor a(96);
D(97) <= I(97) xor B(97) xor C(97) xor a(97);
D(98) <= I(98) xor B(98) xor C(98) xor a(98);
D(99) <= I(99) xor B(99) xor C(99) xor a(99);
D(100) <= I(100) xor B(100) xor C(100) xor a(100);
D(101) <= I(101) xor B(101) xor C(101) xor a(101);
D(102) <= I(102) xor B(102) xor C(102) xor a(102);
D(103) <= I(103) xor B(103) xor C(103) xor a(103);
D(104) <= I(104) xor B(104) xor C(104) xor a(104);
D(105) <= I(105) xor B(105) xor C(105) xor a(105);
D(106) <= I(106) xor B(106) xor C(106) xor a(106);
D(107) <= I(107) xor B(107) xor C(107) xor a(107);
D(108) <= I(108) xor B(108) xor C(108) xor a(108);
D(109) <= I(109) xor B(109) xor C(109) xor a(109);
D(110) <= I(110) xor B(110) xor C(110) xor a(110);
D(111) <= I(111) xor B(111) xor C(111) xor a(111);
D(112) <= I(112) xor B(112) xor C(112) xor a(112);

end;