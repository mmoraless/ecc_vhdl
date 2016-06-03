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
entity squarer_163 is
	generic(   					
		NUM_BITS : positive := 163	-- 163,	233,	277,	283,	409,	571	 	-- Orden del campo finito		
	);
	port(
--		clk     : in std_logic;	
--		en      : in std_logic;
		Ax		: in std_logic_vector(NUM_BITS-1 downto 0);--			  2	
		C_out	: out std_logic_vector(NUM_BITS-1 downto 0)-- A2_x = (A_x) mod Fx
	);												 
end;
---------------------------------------------------------------------------------------------------	
architecture behave of squarer_163 is

--constant F_x: std_logic_vector(NUM_BITS-1 downto 0) := "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000011001001";

begin
	
C_out(162) <= ( Ax(81) xor Ax(159) ) xor Ax(161);
C_out(161) <= Ax(159) xor Ax(162);
C_out(160) <= ( Ax(80) xor Ax(158) ) xor Ax(160);
C_out(159) <= Ax(158) xor Ax(161);
C_out(158) <= ( Ax(79) xor Ax(157) ) xor Ax(159);
C_out(157) <= Ax(157) xor Ax(160);
C_out(156) <= ( Ax(78) xor Ax(156) ) xor Ax(158);
C_out(155) <= Ax(156) xor Ax(159);
C_out(154) <= ( Ax(77) xor Ax(155) ) xor Ax(157);
C_out(153) <= Ax(155) xor Ax(158);
C_out(152) <= ( Ax(76) xor Ax(154) ) xor Ax(156);
C_out(151) <= Ax(154) xor Ax(157);
C_out(150) <= ( Ax(75) xor Ax(153) ) xor Ax(155);
C_out(149) <= Ax(153) xor Ax(156);
C_out(148) <= ( Ax(74) xor Ax(152) ) xor Ax(154);
C_out(147) <= Ax(152) xor Ax(155);
C_out(146) <= ( Ax(73) xor Ax(151) ) xor Ax(153);
C_out(145) <= Ax(151) xor Ax(154);
C_out(144) <= ( Ax(72) xor Ax(150) ) xor Ax(152);
C_out(143) <= Ax(150) xor Ax(153);
C_out(142) <= ( Ax(71) xor Ax(149) ) xor Ax(151);
C_out(141) <= Ax(149) xor Ax(152);
C_out(140) <= ( Ax(70) xor Ax(148) ) xor Ax(150);
C_out(139) <= Ax(148) xor Ax(151);
C_out(138) <= ( Ax(69) xor Ax(147) ) xor Ax(149);
C_out(137) <= Ax(147) xor Ax(150);
C_out(136) <= ( Ax(68) xor Ax(146) ) xor Ax(148);
C_out(135) <= Ax(146) xor Ax(149);
C_out(134) <= ( Ax(67) xor Ax(145) ) xor Ax(147);
C_out(133) <= Ax(145) xor Ax(148);
C_out(132) <= ( Ax(66) xor Ax(144) ) xor Ax(146);
C_out(131) <= Ax(144) xor Ax(147);
C_out(130) <= ( Ax(65) xor Ax(143) ) xor Ax(145);
C_out(129) <= Ax(143) xor Ax(146);
C_out(128) <= ( Ax(64) xor Ax(142) ) xor Ax(144);
C_out(127) <= Ax(142) xor Ax(145);
C_out(126) <= ( Ax(63) xor Ax(141) ) xor Ax(143);
C_out(125) <= Ax(141) xor Ax(144);
C_out(124) <= ( Ax(62) xor Ax(140) ) xor Ax(142);
C_out(123) <= Ax(140) xor Ax(143);
C_out(122) <= ( Ax(61) xor Ax(139) ) xor Ax(141);
C_out(121) <= Ax(139) xor Ax(142);
C_out(120) <= ( Ax(60) xor Ax(138) ) xor Ax(140);
C_out(119) <= Ax(138) xor Ax(141);
C_out(118) <= ( Ax(59) xor Ax(137) ) xor Ax(139);
C_out(117) <= Ax(137) xor Ax(140);
C_out(116) <= ( Ax(58) xor Ax(136) ) xor Ax(138);
C_out(115) <= Ax(136) xor Ax(139);
C_out(114) <= ( Ax(57) xor Ax(135) ) xor Ax(137);
C_out(113) <= Ax(135) xor Ax(138);
C_out(112) <= ( Ax(56) xor Ax(134) ) xor Ax(136);
C_out(111) <= Ax(134) xor Ax(137);
C_out(110) <= ( Ax(55) xor Ax(133) ) xor Ax(135);
C_out(109) <= Ax(133) xor Ax(136);
C_out(108) <= ( Ax(54) xor Ax(132) ) xor Ax(134);
C_out(107) <= Ax(132) xor Ax(135);
C_out(106) <= ( Ax(53) xor Ax(131) ) xor Ax(133);
C_out(105) <= Ax(131) xor Ax(134);
C_out(104) <= ( Ax(52) xor Ax(130) ) xor Ax(132);
C_out(103) <= Ax(130) xor Ax(133);
C_out(102) <= ( Ax(51) xor Ax(129) ) xor Ax(131);
C_out(101) <= Ax(129) xor Ax(132);
C_out(100) <= ( Ax(50) xor Ax(128) ) xor Ax(130);
C_out(99) <= Ax(128) xor Ax(131);
C_out(98) <= ( Ax(49) xor Ax(127) ) xor Ax(129);
C_out(97) <= Ax(127) xor Ax(130);
C_out(96) <= ( Ax(48) xor Ax(126) ) xor Ax(128);
C_out(95) <= Ax(126) xor Ax(129);
C_out(94) <= ( Ax(47) xor Ax(125) ) xor Ax(127);
C_out(93) <= Ax(125) xor Ax(128);
C_out(92) <= ( Ax(46) xor Ax(124) ) xor Ax(126);
C_out(91) <= Ax(124) xor Ax(127);
C_out(90) <= ( Ax(45) xor Ax(123) ) xor Ax(125);
C_out(89) <= Ax(123) xor Ax(126);
C_out(88) <= ( Ax(44) xor Ax(122) ) xor Ax(124);
C_out(87) <= Ax(122) xor Ax(125);
C_out(86) <= ( Ax(43) xor Ax(121) ) xor Ax(123);
C_out(85) <= Ax(121) xor Ax(124);
C_out(84) <= ( Ax(42) xor Ax(120) ) xor Ax(122);
C_out(83) <= Ax(120) xor Ax(123);
C_out(82) <= ( Ax(41) xor Ax(119) ) xor Ax(121);
C_out(81) <= Ax(119) xor Ax(122);
C_out(80) <= ( Ax(40) xor Ax(118) ) xor Ax(120);
C_out(79) <= Ax(118) xor Ax(121);
C_out(78) <= ( Ax(39) xor Ax(117) ) xor Ax(119);
C_out(77) <= Ax(117) xor Ax(120);
C_out(76) <= ( Ax(38) xor Ax(116) ) xor Ax(118);
C_out(75) <= Ax(116) xor Ax(119);
C_out(74) <= ( Ax(37) xor Ax(115) ) xor Ax(117);
C_out(73) <= Ax(115) xor Ax(118);
C_out(72) <= ( Ax(36) xor Ax(114) ) xor Ax(116);
C_out(71) <= Ax(114) xor Ax(117);
C_out(70) <= ( Ax(35) xor Ax(113) ) xor Ax(115);
C_out(69) <= Ax(113) xor Ax(116);
C_out(68) <= ( Ax(34) xor Ax(112) ) xor Ax(114);
C_out(67) <= Ax(112) xor Ax(115);
C_out(66) <= ( Ax(33) xor Ax(111) ) xor Ax(113);
C_out(65) <= Ax(111) xor Ax(114);
C_out(64) <= ( Ax(32) xor Ax(110) ) xor Ax(112);
C_out(63) <= Ax(110) xor Ax(113);
C_out(62) <= ( Ax(31) xor Ax(109) ) xor Ax(111);
C_out(61) <= Ax(109) xor Ax(112);
C_out(60) <= ( Ax(30) xor Ax(108) ) xor Ax(110);
C_out(59) <= Ax(108) xor Ax(111);
C_out(58) <= ( Ax(29) xor Ax(107) ) xor Ax(109);
C_out(57) <= Ax(107) xor Ax(110);
C_out(56) <= ( Ax(28) xor Ax(106) ) xor Ax(108);
C_out(55) <= Ax(106) xor Ax(109);
C_out(54) <= ( Ax(27) xor Ax(105) ) xor Ax(107);
C_out(53) <= Ax(105) xor Ax(108);
C_out(52) <= ( Ax(26) xor Ax(104) ) xor Ax(106);
C_out(51) <= Ax(104) xor Ax(107);
C_out(50) <= ( Ax(25) xor Ax(103) ) xor Ax(105);
C_out(49) <= Ax(103) xor Ax(106);
C_out(48) <= ( Ax(24) xor Ax(102) ) xor Ax(104);
C_out(47) <= Ax(102) xor Ax(105);
C_out(46) <= ( Ax(23) xor Ax(101) ) xor Ax(103);
C_out(45) <= Ax(101) xor Ax(104);
C_out(44) <= ( Ax(22) xor Ax(100) ) xor Ax(102);
C_out(43) <= Ax(100) xor Ax(103);
C_out(42) <= ( Ax(21) xor Ax(99) ) xor Ax(101);
C_out(41) <= Ax(99) xor Ax(102);
C_out(40) <= ( Ax(20) xor Ax(98) ) xor Ax(100);
C_out(39) <= Ax(98) xor Ax(101);
C_out(38) <= ( Ax(19) xor Ax(97) ) xor Ax(99);
C_out(37) <= Ax(97) xor Ax(100);
C_out(36) <= ( Ax(18) xor Ax(96) ) xor Ax(98);
C_out(35) <= Ax(96) xor Ax(99);
C_out(34) <= ( Ax(17) xor Ax(95) ) xor Ax(97);
C_out(33) <= Ax(95) xor Ax(98);
C_out(32) <= ( Ax(16) xor Ax(94) ) xor Ax(96);
C_out(31) <= Ax(94) xor Ax(97);
C_out(30) <= ( Ax(15) xor Ax(93) ) xor Ax(95);
C_out(29) <= Ax(93) xor Ax(96);
C_out(28) <= ( Ax(14) xor Ax(92) ) xor Ax(94);
C_out(27) <= Ax(92) xor Ax(95);
C_out(26) <= ( Ax(13) xor Ax(91) ) xor Ax(93);
C_out(25) <= Ax(91) xor Ax(94);
C_out(24) <= ( Ax(12) xor Ax(90) ) xor Ax(92);
C_out(23) <= Ax(90) xor Ax(93);
C_out(22) <= ( Ax(11) xor Ax(89) ) xor Ax(91);
C_out(21) <= Ax(89) xor Ax(92);
C_out(20) <= ( Ax(10) xor Ax(88) ) xor Ax(90);
C_out(19) <= Ax(88) xor Ax(91);
C_out(18) <= ( Ax(9) xor Ax(87) ) xor Ax(89);
C_out(17) <= Ax(87) xor Ax(90);
C_out(16) <= ( Ax(8) xor Ax(86) ) xor Ax(88);
C_out(15) <= Ax(86) xor Ax(89);
C_out(14) <= ( Ax(7) xor Ax(85) ) xor Ax(87);
C_out(13) <= Ax(85) xor Ax(88);

C_out(12) <= ( Ax(6) xor Ax(84) ) xor (Ax(86) xor Ax(162));

C_out(11) <= Ax(84) xor Ax(87);

C_out(10) <= Ax(5) xor Ax(83) xor Ax(85) xor Ax(161) xor Ax(162);

C_out(9)  <= Ax(83) xor Ax(86);

C_out(8) <= Ax(4) xor Ax(82) xor Ax(84) xor Ax(160) xor Ax(161);

C_out(7)  <= Ax(82) xor Ax(85);

C_out(6) <= Ax(3) xor Ax(83) xor Ax(160) xor Ax(161);

C_out(5) <= Ax(84) xor Ax(161) xor Ax(162);

C_out(4) <= Ax(2) xor Ax(82) xor Ax(160);

C_out(3) <= Ax(83) xor Ax(160) xor Ax(161);

C_out(2) <= Ax(1) xor Ax(161);

C_out(1) <= Ax(82) xor Ax(160) xor Ax(162);

C_out(0) <= Ax(0) xor Ax(160);

end behave;

