-------------------------------------------------------------------
-- Copyright MIPS_R_US 2016 - All Rights Reserved 
--
-- File: processor.vhd
-- Team: MIPS_R_US
-- Members:
-- 		Stefan Cao (ID# 79267250)
--		Ting-Yi Huang (ID# 58106363)
--		Nehme Saikali (ID# 89201494)
--		Linda Vang (ID# 71434490)
--
-- Description:
--		This is a a multi cycle processor
--
-- History:
-- 		Date		Update Description			Developer
--	-----------   ----------------------   	  -------------
--	1/20/2016		Created						TH, NS, LV, SC
-------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY processor IS
	PORT (
		ref_clk : IN std_logic ;
		reset : IN std_logic
	);
END processor;

architecture behavior of processor is

---------------------------------------
-------------- components -------------
---------------------------------------

-- buffer_e
component buffer_e
	port (
		ref_clk : IN std_logic;
		WE : IN std_logic;
		DataI: IN std_logic_vector(31 DOWNTO 0);
		DataO: OUT std_logic_vector(31 DOWNTO 0)
	);
end component;

-- buffer_woe
component buffer_woe
	port (
		ref_clk : IN std_logic;
		DataI: IN std_logic_vector(31 DOWNTO 0);
		DataO: OUT std_logic_vector(31 DOWNTO 0)
	);
end component;

-- mux
component mux
	port( 
		in0: in std_logic_vector(31 downto 0);
		in1: in std_logic_vector(31 downto 0);
		sel: in std_logic;
		outb: out std_logic_vector(31 downto 0)
	);
end component;

-- memory
component memory
	port (
		ref_clk : IN std_logic;
		WE : IN std_logic;
		IorD : IN std_logic; 
		addr : IN std_logic_vector(31 DOWNTO 0); 
		WD : IN std_logic_vector(31 DOWNTO 0); 
		RD : OUT std_logic_vector(31 DOWNTO 0)
	);
end component;





-----------------------------------------------
-------------- signals ------------------------
-----------------------------------------------
signal PCEnable : std_logic;
signal PCIn : std_logic_vector(31 DOWNTO 0);
signal PCOut : std_logic_vector(31 DOWNTO 0);

signal ALUOut: std_logic_vector(31 DOWNTO 0);

signal Adr: std_logic_vector(31 DOWNTO 0);

signal WriteData: std_logic_vector(31 DOWNTO 0);
signal RD_out: std_logic_vector(31 DOWNTO 0);

signal Instr_out: std_logic_vector(31 DOWNTO 0);
signal Data_out: std_logic_vector(31 DOWNTO 0);

signal IorD: std_logic;
signal MemWrite: std_logic;
signal IRWrite: std_logic;



------------------- begin --------------------- 
begin

	pcx:	buffer_e PORT MAP(ref_clk=>ref_clk, WE=>PCEnable, DataI=>PCIn, 
						DataO=>PCOut);	
	
	IorDmuxx:	mux PORT MAP(in0=>PCOut, in1=>ALUOut, sel=>IorD, outb=>Adr);
	
	memoryx: 	memory PORT MAP(ref_clk=>ref_clk, WE=>MemWrite, IorD=>IorD, 
						addr=>Adr, WD=>WriteData, RD=>RD_out);

	Ibufferx:	buffer_e PORT MAP(ref_clk=>ref_clk, WE=>IRWrite, DataI=>RD_out,
						DataO=>Instr_out);

	Dbufferx:	buffer_woe PORT MAP(ref_clk=>ref_clk, DataI=>RD_out, DataO=>Data_out);

	
end behavior;