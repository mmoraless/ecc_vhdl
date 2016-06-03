-- Author		: Miguel Morales-Sandoval														
-- Project		: "Reconfigurable ECC
-- Organization	: INAOE, Computer Science Department											 ---
-- Date			: July, 2007.

--Squarer, solo logica combinacional,
--optimizado para el polinomio de reduccion que se este empleando,
-- funciona solo si el máximo grado del polinomio de reduccion D más 2 es menor a m.

-- Se trata básicamente de un multiplicador de digito combinacional. El tamaño del digito es D+2;

library IEEE; 
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;	
use IEEE.std_logic_arith.all;
-----------------------------------------------------------------------------------
entity squarer_131 is
	generic(   					
		NUM_BITS : positive := 131	--113 163,	233,	277,	283,	409,	571	 	-- Orden del campo finito		
	);
	port(
--		clk     : in std_logic;	
--		en      : in std_logic;
		A_x		: in std_logic_vector(NUM_BITS-1 downto 0);--			  2	
		A2_x	: out std_logic_vector(NUM_BITS-1 downto 0)-- A2_x = (A_x) mod Fx
	);												 
end;
---------------------------------------------------------------------------------------------------	
architecture behave of squarer_131 is

begin	

A2_x(130) <= A_x(65) xor A_x(129);
A2_x(129) <= A_x(130) xor A_x(129) xor A_x(126);

A2_x(128) <= A_x(64) xor A_x(128);
A2_x(127) <= A_x(129) xor A_x(128) xor A_x(125);

A2_x(126) <= A_x(63) xor A_x(127);
A2_x(125) <= A_x(128) xor A_x(127) xor A_x(124);

A2_x(124) <= A_x(62) xor A_x(126);
A2_x(123) <= A_x(127) xor A_x(126) xor A_x(123);

A2_x(122) <= A_x(61) xor A_x(125);
A2_x(121) <= A_x(126) xor A_x(125) xor A_x(122);

A2_x(120) <= A_x(60) xor A_x(124);
A2_x(119) <= A_x(125) xor A_x(124) xor A_x(121);

A2_x(118) <= A_x(59) xor A_x(123);
A2_x(117) <= A_x(124) xor A_x(123) xor A_x(120);

A2_x(116) <= A_x(58) xor A_x(122);
A2_x(115) <= A_x(123) xor A_x(122) xor A_x(119);

A2_x(114) <= A_x(57) xor A_x(121);
A2_x(113) <= A_x(122) xor A_x(121) xor A_x(118);

A2_x(112) <= A_x(56) xor A_x(120);
A2_x(111) <= A_x(121) xor A_x(120) xor A_x(117);

A2_x(110) <= A_x(55) xor A_x(119);
A2_x(109) <= A_x(120) xor A_x(119) xor A_x(116);

A2_x(108) <= A_x(54) xor A_x(118);
A2_x(107) <= A_x(119) xor A_x(118) xor A_x(115);

A2_x(106) <= A_x(53) xor A_x(117);
A2_x(105) <= A_x(118) xor A_x(117) xor A_x(114);

A2_x(104) <= A_x(52) xor A_x(116);
A2_x(103) <= A_x(117) xor A_x(116) xor A_x(113);

A2_x(102) <= A_x(51) xor A_x(115);
A2_x(101) <= A_x(116) xor A_x(115) xor A_x(112);

A2_x(100) <= A_x(50) xor A_x(114);
A2_x(99) <= A_x(115) xor A_x(114) xor A_x(111);

A2_x(98) <= A_x(49) xor A_x(113);
A2_x(97) <= A_x(114) xor A_x(113) xor A_x(110);

A2_x(96) <= A_x(48) xor A_x(112);
A2_x(95) <= A_x(113) xor A_x(112) xor A_x(109);

A2_x(94) <= A_x(47) xor A_x(111);
A2_x(93) <= A_x(112) xor A_x(111) xor A_x(108);

A2_x(92) <= A_x(46) xor A_x(110);
A2_x(91) <= A_x(111) xor A_x(110) xor A_x(107);

A2_x(90) <= A_x(45) xor A_x(109);
A2_x(89) <= A_x(110) xor A_x(109) xor A_x(106);

A2_x(88) <= A_x(44) xor A_x(108);
A2_x(87) <= A_x(109) xor A_x(108) xor A_x(105);

A2_x(86) <= A_x(43) xor A_x(107);
A2_x(85) <= A_x(108) xor A_x(107) xor A_x(104);

A2_x(84) <= A_x(42) xor A_x(106);
A2_x(83) <= A_x(107) xor A_x(106) xor A_x(103);

A2_x(82) <= A_x(41) xor A_x(105);
A2_x(81) <= A_x(106) xor A_x(105) xor A_x(102);

A2_x(80) <= A_x(40) xor A_x(104);
A2_x(79) <= A_x(105) xor A_x(104) xor A_x(101);

A2_x(78) <= A_x(39) xor A_x(103);
A2_x(77) <= A_x(104) xor A_x(103) xor A_x(100);

A2_x(76) <= A_x(38) xor A_x(102);
A2_x(75) <= A_x(103) xor A_x(102) xor A_x(99);

A2_x(74) <= A_x(37) xor A_x(101);
A2_x(73) <= A_x(102) xor A_x(101) xor A_x(98);

A2_x(72) <= A_x(36) xor A_x(100);
A2_x(71) <= A_x(101) xor A_x(100) xor A_x(97);

A2_x(70) <= A_x(35) xor A_x(99);
A2_x(69) <= A_x(100) xor A_x(99) xor A_x(96);

A2_x(68) <= A_x(34) xor A_x(98);
A2_x(67) <= A_x(99) xor A_x(98) xor A_x(95);

A2_x(66) <= A_x(33) xor A_x(97);
A2_x(65) <= A_x(98) xor A_x(97) xor A_x(94);

A2_x(64) <= A_x(32) xor A_x(96);
A2_x(63) <= A_x(97) xor A_x(96) xor A_x(93);

A2_x(62) <= A_x(31) xor A_x(95);
A2_x(61) <= A_x(96) xor A_x(95) xor A_x(92);

A2_x(60) <= A_x(30) xor A_x(94);
A2_x(59) <= A_x(95) xor A_x(94) xor A_x(91);

A2_x(58) <= A_x(29) xor A_x(93);
A2_x(57) <= A_x(94) xor A_x(93) xor A_x(90);

A2_x(56) <= A_x(28) xor A_x(92);
A2_x(55) <= A_x(93) xor A_x(92) xor A_x(89);

A2_x(54) <= A_x(27) xor A_x(91);
A2_x(53) <= A_x(92) xor A_x(91) xor A_x(88);

A2_x(52) <= A_x(26) xor A_x(90);
A2_x(51) <= A_x(91) xor A_x(90) xor A_x(87);

A2_x(50) <= A_x(25) xor A_x(89);
A2_x(49) <= A_x(90) xor A_x(89) xor A_x(86);

A2_x(48) <= A_x(24) xor A_x(88);
A2_x(47) <= A_x(89) xor A_x(88) xor A_x(85);

A2_x(46) <= A_x(23) xor A_x(87);
A2_x(45) <= A_x(88) xor A_x(87) xor A_x(84);

A2_x(44) <= A_x(22) xor A_x(86);
A2_x(43) <= A_x(87) xor A_x(86) xor A_x(83);

A2_x(42) <= A_x(21) xor A_x(85);
A2_x(41) <= A_x(86) xor A_x(85) xor A_x(82);

A2_x(40) <= A_x(20) xor A_x(84);
A2_x(39) <= A_x(85) xor A_x(84) xor A_x(81);

A2_x(38) <= A_x(19) xor A_x(83);
A2_x(37) <= A_x(84) xor A_x(83) xor A_x(80);

A2_x(36) <= A_x(18) xor A_x(82);
A2_x(35) <= A_x(83) xor A_x(82) xor A_x(79);

A2_x(34) <= A_x(17) xor A_x(81);
A2_x(33) <= A_x(82) xor A_x(81) xor A_x(78);

A2_x(32) <= A_x(16) xor A_x(80);
A2_x(31) <= A_x(81) xor A_x(80) xor A_x(77);

A2_x(30) <= A_x(15) xor A_x(79);
A2_x(29) <= A_x(80) xor A_x(79) xor A_x(76);

A2_x(28) <= A_x(14) xor A_x(78);
A2_x(27) <= A_x(79) xor A_x(78) xor A_x(75);

A2_x(26) <= A_x(13) xor A_x(77);
A2_x(25) <= A_x(78) xor A_x(77) xor A_x(74);

A2_x(24) <= A_x(12) xor A_x(76);
A2_x(23) <= A_x(77) xor A_x(76) xor A_x(73);

A2_x(22) <= A_x(11) xor A_x(75);
A2_x(21) <= A_x(76) xor A_x(75) xor A_x(72);

A2_x(20) <= A_x(10) xor A_x(74);
A2_x(19) <= A_x(75) xor A_x(74) xor A_x(71);

A2_x(18) <= A_x(9) xor A_x(73);
A2_x(17) <= A_x(74) xor A_x(73) xor A_x(70);

A2_x(16) <= A_x(8) xor A_x(72);
A2_x(15) <= A_x(73) xor A_x(72) xor A_x(69);


A2_x(14) <= A_x(7) xor A_x(71) xor A_x(130);
A2_x(13) <= A_x(72) xor A_x(71) xor A_x(68);

A2_x(12) <= A_x(6) xor A_x(70) xor A_x(129);
A2_x(11) <= A_x(71) xor A_x(70) xor A_x(67);

A2_x(10) <= A_x(5) xor A_x(69) xor A_x(128);
A2_x(9) <= A_x(70) xor A_x(69) xor A_x(66);

A2_x(8) <= A_x(4) xor A_x(68) xor A_x(127);
A2_x(7) <= A_x(69) xor A_x(68) xor A_x(129);

A2_x(6) <= A_x(3) xor A_x(67) xor A_x(130) xor A_x(129);
A2_x(5) <= A_x(68) xor A_x(67) xor A_x(128);

A2_x(4) <= A_x(2) xor A_x(66) xor A_x(130) xor A_x(129) xor A_x(128);
A2_x(3) <= A_x(67) xor A_x(66) xor A_x(127);

A2_x(2) <= A_x(1) xor A_x(130) xor A_x(128) xor A_x(127);
A2_x(1) <= A_x(66) xor A_x(130);

A2_x(0) <= A_x(0) xor A_x(130) xor A_x(127) ;
	
end behave;