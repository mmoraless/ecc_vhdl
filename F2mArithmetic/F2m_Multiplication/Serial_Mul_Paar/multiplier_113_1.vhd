library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
--------------------------------------------------------
-- Con celda y sin maquina de estados
--------------------------------------------------------

-- x ^113 + x ^9 + 1
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
Bx_shift <= bx_int(NUM_BITS-2 downto 0)& '0';				-- Shift Bx to left one position															
														
------------------------------------------------------------
-- The finite state machine, it takes m cycles to compute 
-- the multiplication, a counter is used to keep this count
------------------------------------------------------------

CELL_0: ENTITY basic_cell(behave)
	PORT MAP(Ax(0),Bx_int(NUM_BITS-1),Cx_int(NUM_BITS-1),clk,reset,Cx_int(0));

CELL_1: ENTITY basic_cell(behave)
	PORT MAP(Ax(1),Bx_int(NUM_BITS-1),Cx_int(0),clk,reset,Cx_int(1));

CELL_2: ENTITY basic_cell(behave)
	PORT MAP(Ax(2),Bx_int(NUM_BITS-1),Cx_int(1),clk,reset,Cx_int(2));

CELL_3: ENTITY basic_cell(behave)
	PORT MAP(Ax(3),Bx_int(NUM_BITS-1),Cx_int(2),clk,reset,Cx_int(3));

CELL_4: ENTITY basic_cell(behave)
	PORT MAP(Ax(4),Bx_int(NUM_BITS-1),Cx_int(3),clk,reset,Cx_int(4));

CELL_5: ENTITY basic_cell(behave)
	PORT MAP(Ax(5),Bx_int(NUM_BITS-1),Cx_int(4),clk,reset,Cx_int(5));

CELL_6: ENTITY basic_cell(behave)
	PORT MAP(Ax(6),Bx_int(NUM_BITS-1),Cx_int(5),clk,reset,Cx_int(6));

CELL_7: ENTITY basic_cell(behave)
	PORT MAP(Ax(7),Bx_int(NUM_BITS-1),Cx_int(6),clk,reset,Cx_int(7));

CELL_8: ENTITY basic_cell(behave)
	PORT MAP(Ax(8),Bx_int(NUM_BITS-1),Cx_int(7),clk,reset,Cx_int(8));

CELL_9: ENTITY basic_cell(behave)
	PORT MAP(Ax(9),Bx_int(NUM_BITS-1),xor_1,clk,reset,Cx_int(9));

CELL_10: ENTITY basic_cell(behave)
	PORT MAP(Ax(10),Bx_int(NUM_BITS-1),Cx_int(9),clk,reset,Cx_int(10));

CELL_11: ENTITY basic_cell(behave)
	PORT MAP(Ax(11),Bx_int(NUM_BITS-1),Cx_int(10),clk,reset,Cx_int(11));

CELL_12: ENTITY basic_cell(behave)
	PORT MAP(Ax(12),Bx_int(NUM_BITS-1),Cx_int(11),clk,reset,Cx_int(12));

CELL_13: ENTITY basic_cell(behave)
	PORT MAP(Ax(13),Bx_int(NUM_BITS-1),Cx_int(12),clk,reset,Cx_int(13));

CELL_14: ENTITY basic_cell(behave)
	PORT MAP(Ax(14),Bx_int(NUM_BITS-1),Cx_int(13),clk,reset,Cx_int(14));

CELL_15: ENTITY basic_cell(behave)
	PORT MAP(Ax(15),Bx_int(NUM_BITS-1),Cx_int(14),clk,reset,Cx_int(15));

CELL_16: ENTITY basic_cell(behave)
	PORT MAP(Ax(16),Bx_int(NUM_BITS-1),Cx_int(15),clk,reset,Cx_int(16));
CELL_17: ENTITY basic_cell(behave)
	PORT MAP(Ax(17),Bx_int(NUM_BITS-1),Cx_int(16),clk,reset,Cx_int(17));
CELL_18: ENTITY basic_cell(behave)
	PORT MAP(Ax(18),Bx_int(NUM_BITS-1),Cx_int(17),clk,reset,Cx_int(18));
CELL_19: ENTITY basic_cell(behave)
	PORT MAP(Ax(19),Bx_int(NUM_BITS-1),Cx_int(18),clk,reset,Cx_int(19));
CELL_20: ENTITY basic_cell(behave)
	PORT MAP(Ax(20),Bx_int(NUM_BITS-1),Cx_int(19),clk,reset,Cx_int(20));
CELL_21: ENTITY basic_cell(behave)
	PORT MAP(Ax(21),Bx_int(NUM_BITS-1),Cx_int(20),clk,reset,Cx_int(21));
CELL_22: ENTITY basic_cell(behave)
	PORT MAP(Ax(22),Bx_int(NUM_BITS-1),Cx_int(21),clk,reset,Cx_int(22));
CELL_23: ENTITY basic_cell(behave)
	PORT MAP(Ax(23),Bx_int(NUM_BITS-1),Cx_int(22),clk,reset,Cx_int(23));
CELL_24: ENTITY basic_cell(behave)
	PORT MAP(Ax(24),Bx_int(NUM_BITS-1),Cx_int(23),clk,reset,Cx_int(24));
CELL_25: ENTITY basic_cell(behave)
	PORT MAP(Ax(25),Bx_int(NUM_BITS-1),Cx_int(24),clk,reset,Cx_int(25));
CELL_26: ENTITY basic_cell(behave)
	PORT MAP(Ax(26),Bx_int(NUM_BITS-1),Cx_int(25),clk,reset,Cx_int(26));
CELL_27: ENTITY basic_cell(behave)
	PORT MAP(Ax(27),Bx_int(NUM_BITS-1),Cx_int(26),clk,reset,Cx_int(27));
CELL_28: ENTITY basic_cell(behave)
	PORT MAP(Ax(28),Bx_int(NUM_BITS-1),Cx_int(27),clk,reset,Cx_int(28));
CELL_29: ENTITY basic_cell(behave)
	PORT MAP(Ax(29),Bx_int(NUM_BITS-1),Cx_int(28),clk,reset,Cx_int(29));
CELL_30: ENTITY basic_cell(behave)
	PORT MAP(Ax(30),Bx_int(NUM_BITS-1),Cx_int(29),clk,reset,Cx_int(30));
CELL_31: ENTITY basic_cell(behave)
	PORT MAP(Ax(31),Bx_int(NUM_BITS-1),Cx_int(30),clk,reset,Cx_int(31));
CELL_32: ENTITY basic_cell(behave)
	PORT MAP(Ax(32),Bx_int(NUM_BITS-1),Cx_int(31),clk,reset,Cx_int(32));
CELL_33: ENTITY basic_cell(behave)
	PORT MAP(Ax(33),Bx_int(NUM_BITS-1),Cx_int(32),clk,reset,Cx_int(33));
CELL_34: ENTITY basic_cell(behave)
	PORT MAP(Ax(34),Bx_int(NUM_BITS-1),Cx_int(33),clk,reset,Cx_int(34));
CELL_35: ENTITY basic_cell(behave)
	PORT MAP(Ax(35),Bx_int(NUM_BITS-1),Cx_int(34),clk,reset,Cx_int(35));
CELL_36: ENTITY basic_cell(behave)
	PORT MAP(Ax(36),Bx_int(NUM_BITS-1),Cx_int(35),clk,reset,Cx_int(36));
CELL_37: ENTITY basic_cell(behave)
	PORT MAP(Ax(37),Bx_int(NUM_BITS-1),Cx_int(36),clk,reset,Cx_int(37));
CELL_38: ENTITY basic_cell(behave)
	PORT MAP(Ax(38),Bx_int(NUM_BITS-1),Cx_int(37),clk,reset,Cx_int(38));
CELL_39: ENTITY basic_cell(behave)
	PORT MAP(Ax(39),Bx_int(NUM_BITS-1),Cx_int(38),clk,reset,Cx_int(39));
CELL_40: ENTITY basic_cell(behave)
	PORT MAP(Ax(40),Bx_int(NUM_BITS-1),Cx_int(39),clk,reset,Cx_int(40));
CELL_41: ENTITY basic_cell(behave)
	PORT MAP(Ax(41),Bx_int(NUM_BITS-1),Cx_int(40),clk,reset,Cx_int(41));
CELL_42: ENTITY basic_cell(behave)
	PORT MAP(Ax(42),Bx_int(NUM_BITS-1),Cx_int(41),clk,reset,Cx_int(42));
CELL_43: ENTITY basic_cell(behave)
	PORT MAP(Ax(43),Bx_int(NUM_BITS-1),Cx_int(42),clk,reset,Cx_int(43));
CELL_44: ENTITY basic_cell(behave)
	PORT MAP(Ax(44),Bx_int(NUM_BITS-1),Cx_int(43),clk,reset,Cx_int(44));
CELL_45: ENTITY basic_cell(behave)
	PORT MAP(Ax(45),Bx_int(NUM_BITS-1),Cx_int(44),clk,reset,Cx_int(45));
CELL_46: ENTITY basic_cell(behave)
	PORT MAP(Ax(46),Bx_int(NUM_BITS-1),Cx_int(45),clk,reset,Cx_int(46));
CELL_47: ENTITY basic_cell(behave)
	PORT MAP(Ax(47),Bx_int(NUM_BITS-1),Cx_int(46),clk,reset,Cx_int(47));
CELL_48: ENTITY basic_cell(behave)
	PORT MAP(Ax(48),Bx_int(NUM_BITS-1),Cx_int(47),clk,reset,Cx_int(48));
CELL_49: ENTITY basic_cell(behave)
	PORT MAP(Ax(49),Bx_int(NUM_BITS-1),Cx_int(48),clk,reset,Cx_int(49));
CELL_50: ENTITY basic_cell(behave)
	PORT MAP(Ax(50),Bx_int(NUM_BITS-1),Cx_int(49),clk,reset,Cx_int(50));
CELL_51: ENTITY basic_cell(behave)
	PORT MAP(Ax(51),Bx_int(NUM_BITS-1),Cx_int(50),clk,reset,Cx_int(51));
CELL_52: ENTITY basic_cell(behave)
	PORT MAP(Ax(52),Bx_int(NUM_BITS-1),Cx_int(51),clk,reset,Cx_int(52));
CELL_53: ENTITY basic_cell(behave)
	PORT MAP(Ax(53),Bx_int(NUM_BITS-1),Cx_int(52),clk,reset,Cx_int(53));
CELL_54: ENTITY basic_cell(behave)
	PORT MAP(Ax(54),Bx_int(NUM_BITS-1),Cx_int(53),clk,reset,Cx_int(54));
CELL_55: ENTITY basic_cell(behave)
	PORT MAP(Ax(55),Bx_int(NUM_BITS-1),Cx_int(54),clk,reset,Cx_int(55));
CELL_56: ENTITY basic_cell(behave)
	PORT MAP(Ax(56),Bx_int(NUM_BITS-1),Cx_int(55),clk,reset,Cx_int(56));
CELL_57: ENTITY basic_cell(behave)
	PORT MAP(Ax(57),Bx_int(NUM_BITS-1),Cx_int(56),clk,reset,Cx_int(57));
CELL_58: ENTITY basic_cell(behave)
	PORT MAP(Ax(58),Bx_int(NUM_BITS-1),Cx_int(57),clk,reset,Cx_int(58));
CELL_59: ENTITY basic_cell(behave)
	PORT MAP(Ax(59),Bx_int(NUM_BITS-1),Cx_int(58),clk,reset,Cx_int(59));
CELL_60: ENTITY basic_cell(behave)
	PORT MAP(Ax(60),Bx_int(NUM_BITS-1),Cx_int(59),clk,reset,Cx_int(60));
CELL_61: ENTITY basic_cell(behave)
	PORT MAP(Ax(61),Bx_int(NUM_BITS-1),Cx_int(60),clk,reset,Cx_int(61));
CELL_62: ENTITY basic_cell(behave)
	PORT MAP(Ax(62),Bx_int(NUM_BITS-1),Cx_int(61),clk,reset,Cx_int(62));
CELL_63: ENTITY basic_cell(behave)
	PORT MAP(Ax(63),Bx_int(NUM_BITS-1),Cx_int(62),clk,reset,Cx_int(63));
CELL_64: ENTITY basic_cell(behave)
	PORT MAP(Ax(64),Bx_int(NUM_BITS-1),Cx_int(63),clk,reset,Cx_int(64));
CELL_65: ENTITY basic_cell(behave)
	PORT MAP(Ax(65),Bx_int(NUM_BITS-1),Cx_int(64),clk,reset,Cx_int(65));
CELL_66: ENTITY basic_cell(behave)
	PORT MAP(Ax(66),Bx_int(NUM_BITS-1),Cx_int(65),clk,reset,Cx_int(66));
CELL_67: ENTITY basic_cell(behave)
	PORT MAP(Ax(67),Bx_int(NUM_BITS-1),Cx_int(66),clk,reset,Cx_int(67));
CELL_68: ENTITY basic_cell(behave)
	PORT MAP(Ax(68),Bx_int(NUM_BITS-1),Cx_int(67),clk,reset,Cx_int(68));
CELL_69: ENTITY basic_cell(behave)
	PORT MAP(Ax(69),Bx_int(NUM_BITS-1),Cx_int(68),clk,reset,Cx_int(69));
CELL_70: ENTITY basic_cell(behave)
	PORT MAP(Ax(70),Bx_int(NUM_BITS-1),Cx_int(69),clk,reset,Cx_int(70));
CELL_71: ENTITY basic_cell(behave)
	PORT MAP(Ax(71),Bx_int(NUM_BITS-1),Cx_int(70),clk,reset,Cx_int(71));
CELL_72: ENTITY basic_cell(behave)
	PORT MAP(Ax(72),Bx_int(NUM_BITS-1),Cx_int(71),clk,reset,Cx_int(72));
CELL_73: ENTITY basic_cell(behave)
	PORT MAP(Ax(73),Bx_int(NUM_BITS-1),Cx_int(72),clk,reset,Cx_int(73));
CELL_74: ENTITY basic_cell(behave)
	PORT MAP(Ax(74),Bx_int(NUM_BITS-1),Cx_int(73),clk,reset,Cx_int(74));
CELL_75: ENTITY basic_cell(behave)
	PORT MAP(Ax(75),Bx_int(NUM_BITS-1),Cx_int(74),clk,reset,Cx_int(75));
CELL_76: ENTITY basic_cell(behave)
	PORT MAP(Ax(76),Bx_int(NUM_BITS-1),Cx_int(75),clk,reset,Cx_int(76));
CELL_77: ENTITY basic_cell(behave)
	PORT MAP(Ax(77),Bx_int(NUM_BITS-1),Cx_int(76),clk,reset,Cx_int(77));
CELL_78: ENTITY basic_cell(behave)
	PORT MAP(Ax(78),Bx_int(NUM_BITS-1),Cx_int(77),clk,reset,Cx_int(78));
CELL_79: ENTITY basic_cell(behave)
	PORT MAP(Ax(79),Bx_int(NUM_BITS-1),Cx_int(78),clk,reset,Cx_int(79));
CELL_80: ENTITY basic_cell(behave)
	PORT MAP(Ax(80),Bx_int(NUM_BITS-1),Cx_int(79),clk,reset,Cx_int(80));
CELL_81: ENTITY basic_cell(behave)
	PORT MAP(Ax(81),Bx_int(NUM_BITS-1),Cx_int(80),clk,reset,Cx_int(81));
CELL_82: ENTITY basic_cell(behave)
	PORT MAP(Ax(82),Bx_int(NUM_BITS-1),Cx_int(81),clk,reset,Cx_int(82));
CELL_83: ENTITY basic_cell(behave)
	PORT MAP(Ax(83),Bx_int(NUM_BITS-1),Cx_int(82),clk,reset,Cx_int(83));
CELL_84: ENTITY basic_cell(behave)
	PORT MAP(Ax(84),Bx_int(NUM_BITS-1),Cx_int(83),clk,reset,Cx_int(84));
CELL_85: ENTITY basic_cell(behave)
	PORT MAP(Ax(85),Bx_int(NUM_BITS-1),Cx_int(84),clk,reset,Cx_int(85));
CELL_86: ENTITY basic_cell(behave)
	PORT MAP(Ax(86),Bx_int(NUM_BITS-1),Cx_int(85),clk,reset,Cx_int(86));
CELL_87: ENTITY basic_cell(behave)
	PORT MAP(Ax(87),Bx_int(NUM_BITS-1),Cx_int(86),clk,reset,Cx_int(87));
CELL_88: ENTITY basic_cell(behave)
	PORT MAP(Ax(88),Bx_int(NUM_BITS-1),Cx_int(87),clk,reset,Cx_int(88));
CELL_89: ENTITY basic_cell(behave)
	PORT MAP(Ax(89),Bx_int(NUM_BITS-1),Cx_int(88),clk,reset,Cx_int(89));
CELL_90: ENTITY basic_cell(behave)
	PORT MAP(Ax(90),Bx_int(NUM_BITS-1),Cx_int(89),clk,reset,Cx_int(90));
CELL_91: ENTITY basic_cell(behave)
	PORT MAP(Ax(91),Bx_int(NUM_BITS-1),Cx_int(90),clk,reset,Cx_int(91));
CELL_92: ENTITY basic_cell(behave)
	PORT MAP(Ax(92),Bx_int(NUM_BITS-1),Cx_int(91),clk,reset,Cx_int(92));
CELL_93: ENTITY basic_cell(behave)
	PORT MAP(Ax(93),Bx_int(NUM_BITS-1),Cx_int(92),clk,reset,Cx_int(93));
CELL_94: ENTITY basic_cell(behave)
	PORT MAP(Ax(94),Bx_int(NUM_BITS-1),Cx_int(93),clk,reset,Cx_int(94));
CELL_95: ENTITY basic_cell(behave)
	PORT MAP(Ax(95),Bx_int(NUM_BITS-1),Cx_int(94),clk,reset,Cx_int(95));
CELL_96: ENTITY basic_cell(behave)
	PORT MAP(Ax(96),Bx_int(NUM_BITS-1),Cx_int(95),clk,reset,Cx_int(96));
CELL_97: ENTITY basic_cell(behave)
	PORT MAP(Ax(97),Bx_int(NUM_BITS-1),Cx_int(96),clk,reset,Cx_int(97));
CELL_98: ENTITY basic_cell(behave)
	PORT MAP(Ax(98),Bx_int(NUM_BITS-1),Cx_int(97),clk,reset,Cx_int(98));
CELL_99: ENTITY basic_cell(behave)
	PORT MAP(Ax(99),Bx_int(NUM_BITS-1),Cx_int(98),clk,reset,Cx_int(99));
CELL_100: ENTITY basic_cell(behave)
	PORT MAP(Ax(100),Bx_int(NUM_BITS-1),Cx_int(99),clk,reset,Cx_int(100));
CELL_101: ENTITY basic_cell(behave)
	PORT MAP(Ax(101),Bx_int(NUM_BITS-1),Cx_int(100),clk,reset,Cx_int(101));
CELL_102: ENTITY basic_cell(behave)
	PORT MAP(Ax(102),Bx_int(NUM_BITS-1),Cx_int(101),clk,reset,Cx_int(102));
CELL_103: ENTITY basic_cell(behave)
	PORT MAP(Ax(103),Bx_int(NUM_BITS-1),Cx_int(102),clk,reset,Cx_int(103));
CELL_104: ENTITY basic_cell(behave)
	PORT MAP(Ax(104),Bx_int(NUM_BITS-1),Cx_int(103),clk,reset,Cx_int(104));
CELL_105: ENTITY basic_cell(behave)
	PORT MAP(Ax(105),Bx_int(NUM_BITS-1),Cx_int(104),clk,reset,Cx_int(105));
CELL_106: ENTITY basic_cell(behave)
	PORT MAP(Ax(106),Bx_int(NUM_BITS-1),Cx_int(105),clk,reset,Cx_int(106));
CELL_107: ENTITY basic_cell(behave)
	PORT MAP(Ax(107),Bx_int(NUM_BITS-1),Cx_int(106),clk,reset,Cx_int(107));
CELL_108: ENTITY basic_cell(behave)
	PORT MAP(Ax(108),Bx_int(NUM_BITS-1),Cx_int(107),clk,reset,Cx_int(108));
CELL_109: ENTITY basic_cell(behave)
	PORT MAP(Ax(109),Bx_int(NUM_BITS-1),Cx_int(108),clk,reset,Cx_int(109));
CELL_110: ENTITY basic_cell(behave)
	PORT MAP(Ax(110),Bx_int(NUM_BITS-1),Cx_int(109),clk,reset,Cx_int(110));
CELL_111: ENTITY basic_cell(behave)
	PORT MAP(Ax(111),Bx_int(NUM_BITS-1),Cx_int(110),clk,reset,Cx_int(111));
CELL_112: ENTITY basic_cell(behave)
	PORT MAP(Ax(112),Bx_int(NUM_BITS-1),Cx_int(111),clk,reset,Cx_int(112));

done <= done_int;

FSM_MUL: process (CLK)
	Begin						
		if CLK'event and CLK = '1' then
			if Reset = '1' then
				counter <= "01110001"; 						-- m value, in this case, it is 112, be sure to set the correct value
					        
			 	cx <= (others => '0');
				Done_int <= '0';				
			else 	
				if counter = "0000000" then					-- The done signal is asserted at the same time that the result is computed.
					if (done_int = '0')	then
						done_int <= '1';	
						Cx <= Cx_int;				  
					end if;	
				else
				  counter <= counter - 1;
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


