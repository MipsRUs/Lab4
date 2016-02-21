-------------------------------------------------------------------
-- Copyright MIPS_R_US 2016 - All Rights Reserved 
--
-- File: control.vhd
-- Team: MIPS_R_US
-- Members:
-- 		Stefan Cao (ID# 79267250)
--		Ting-Yi Huang (ID# 58106363)
--		Nehme Saikali (ID# 89201494)
--		Linda Vang (ID# 71434490)
--
-- Description:
--		This is a control unit of the processor (multi-cycle)
--
-- History:
-- 		Date		Update Description			Developer
--	-----------   ----------------------   	  -------------
--	2/20/2016		Created						TH, NS, LV, SC			
-------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY control IS
	PORT (
		
		ref_clk : IN std_logic;
		reset : IN std_logic;


		instruction : IN std_logic_vector (31 DOWNTO 0);

		-----------------------------------------------
		--------------- Control Enables ---------------
		-----------------------------------------------
		-- write enable for regfile
		-- '0' if read, '1' if write
		RegWrite: OUT std_logic;

		-- selecting sign extend OR raddr_2
		-- '0' if raddr_2 result, '1' if sign extend result
		ALUSrc: OUT std_logic;

		-- write ebable for data memory
		-- '0' if not writing to mem, '1' if writing to mem
		MemWrite: OUT std_logic;

		-- selecting output data from memory OR ALU result
		-- '1' if ALU result, '0' if mem result
		MemToReg: OUT std_logic;

		-- selecting if 'rs' or 'rt' is selected to write destination (regfile)
		-- '1' if rd, '0' if rt
		RegDst: OUT std_logic;

		-- '1' if branching, '0' if not branching
		Branch: OUT std_logic;

		-- '1' if jump instruction, else '0' 
		Jump: OUT std_logic;

		-- '1' if JR instruction, else '0'
		JRControl: OUT std_logic;

		-- '1' if JAL instruction and saves current address to register '31' else '0' 
		JALAddr: OUT std_logic;

		-- "00" (LB/LH, and whatever comes out from memReg)
		-- "01" for LUI instruction,
		-- "10" for JAL, saves data of current instruction (or the next one)		 
		JALData: OUT std_logic_vector(1 DOWNTO 0);

		-- '1' if shift, else '0' (SLL, SRL, SRA ONLY)
		ShiftControl: OUT std_logic;

		-- "000" if LB; "001" if LH; "010" if LBU; "011" if LHU; 
		-- "100" if normal, (don't do any manipulation to input) 
		LoadControl: OUT std_logic_vector(2 DOWNTO 0);

		-- func for ALU
		ALUControl: OUT std_logic_vector(5 DOWNTO 0);


		-- to regfile
		-- operand A
		rs: OUT std_logic_vector(4 DOWNTO 0);

		-- operand B
		rt: OUT std_logic_vector(4 DOWNTO 0);

		-- write address
		rd: OUT std_logic_vector(4 DOWNTO 0);

		-- immediant, (rd+shamt+func)
		imm: OUT std_logic_vector(15 DOWNTO 0);

		-- shamt
		shamt: OUT std_logic_vector(4 DOWNTO 0);

		-- jump shift left
		jumpshiftleft: OUT std_logic_vector(25 DOWNTO 0)
	);
END control;

architecture behavior of control is

	type state_type is (s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11)

	signal state : state_type;

begin

	process(ref_clk, reset)
	begin
		if reset = '1' then 
			state <= s0;
		elsif (rising_edge(ref_clk)) then

			case state is 
				when s0=>
					state <= s1;

				when s1=>
					if(
						-- LW
						(instruction(31 DOWNTO 26) = "100011") OR

						-- SW
						(instruction(31 DOWNTO 26) = "101011")
					) then

						state <= s2;

					elsif( 

						-- R-type
						(instruction(31 DOWNTO 26) = "000000")
					) then

						state <= s6;

					elsif(

						-- BEQ
						(instruction(31 DOWNTO 26) = "000100") OR

						-- BNE
						(instruction(31 DOWNTO 26) = "000101") OR

						-- BLTZ or BGEZ
						(instruction(31 DOWNTO 26) = "000001") OR

						-- BLEZ
						(instruction(31 DOWNTO 26) = "000110") OR

						-- BGTZ
						(instruction(31 DOWNTO 26) = "000111") 
					) then

						state <= s8;

					elsif(

						--Addi

					) then 

						state <= s9;

					elsif(

						-- JUMP
						(instruction(31 DOWNTO 26) = "000010") OR

						-- JR or JALR
						((instruction(31 DOWNTO 26) = "000000") AND
							((instruction(5 DOWNTO 0) = "001000") OR
							  (instruction(5 DOWNTO 0) = "001001"))) OR

						-- JAL
						(instruction(31 DOWNTO 26) = "000011") 
					) then 

						state <= s11;
					end if;

				when s2=>

					if(

						-- LW
						(instruction(31 DOWNTO 26) = "100011") 
					) then

						state <= s3;

					elsif(

						-- SW
						(instruction(31 DOWNTO 26) = "101011")
					) then

						state <= s5;
					end if;

				when s3=>

					state <= s4;

				when s4=>

					state <= s0;

				when s5=>

					state <= s0;

				when s6=>

					state <= s7;

				when s7=> 

					state <= s0;

				when s8=>
					state <= s0;

				when s9=>
					state <= s10;

				when s10=>
					state <= s0;

				when s11=>
					state <= s0;

			end case;

		end if;
	end process;

	process(state)
	begin
		case state is
			when s0=>

			when s1=>

			when s2=>

			when s3=>

			when s4=>

			when s5=>

			when s6=>

			when s7=>

			when s8=>

			when s9=>

			when s10=>

			when s11=>



		end case;
	end process;

end behavior;

