---------------------------------------------------------------------------------------------------
--
-- Title       : GF2m_MoC
-- Design      : someone
-- Author      : Leumig
-- Company     : INAOE
--
---------------------------------------------------------------------------------------------------
--
-- File        : multiplier_wrapper.vhd
-- Generated   : Thu May 18 12:06:43 2006
---------------------------------------------------------------------------------------------------
--
-- Description : 
--
---------------------------------------------------------------------------------------------------

library IEEE; 
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;	
use IEEE.std_logic_arith.all;

entity maia_233 is	 
		generic(	 
	
	   -- Para el bloque in
		SH_IN	 : positive := 23;	-- 29,   23,   11,    5,   :- bits que "faltan" para ser multiplo de 32
		G_IN	 : positive := 32; 	-- 32,   32,   32,   32,   :- Numero de palabra de entrada 
		ITR		 : positive := 8; 	-- 6,     8,    9,    9,   :- No. de iteraciones en la máquina de estados
		NUM_BITS : positive := 233	-- 163, 233,  277,  283, :- Orden del campo
	);
	port(
		 rst : in STD_LOGIC;
		 clk : in STD_LOGIC;
		 w1 : in STD_LOGIC_VECTOR(31 downto 0);
		 v_data : out STD_LOGIC;
		 w3 : out STD_LOGIC_VECTOR(31 downto 0)
	     );
end;

architecture behave of maia_233 is			   
-----------------------------------------------------------------------
-- conexion entre el inversor f2m y el modulo de entrada 1
signal donew1 : std_logic;							
signal Ax  	  : std_logic_vector(NUM_BITS-1 downto 0);
-----------------------------------------------------------------------
-- salidas del inversor F2m a la interface out.
signal rst_and	:  std_logic;								
signal Cx_out	: std_logic_vector(NUM_BITS-1 downto 0);
signal done_inv : std_logic;
		
begin	
	
	-----------------------------------------------------------------------
	-- WORD_TO_FIELD 1
	-----------------------------------------------------------------------
	W2F1: ENTITY work.word_to_field(behave) 
	Generic Map (SH_IN, G_IN, ITR, NUM_BITS)   
	PORT MAP(w1, clk, rst, donew1, Ax);
	-----------------------------------------------------------------------
	-- El inversor
	-----------------------------------------------------------------------
	maiaGF2m_INV: entity work.inverter_maia_233(behave) 
		Generic map (NUM_BITS)
		Port Map(Ax, clk, donew1, done_inv, Cx_out);
	-----------------------------------------------------------------------
	F2W: ENTITY work.field_to_word(behave) 
	Generic Map (SH_IN, G_IN, ITR, NUM_BITS) 		
	PORT MAP(Cx_out, clk, done_inv, w3, v_data);
	-----------------------------------------------------------------------
end behave;
