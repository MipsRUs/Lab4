/***************************************************************/
// Copyright MIPS_R_US 2016 - All Rights Reserved 
// 
// File: memory_tb.sv
// Team: MIPS_R_US
// Members:
//		Stefan Cao (ID# 79267250)
//		Ting-Yi Huang (ID# 58106363)
//		Nehme Saikali (ID# 89201494)
//		Linda Vang (ID# 71434490)
//
// Description:
//		This is test bench for the processor
//
// History:
//		Date		Update Description		Developer
//	------------	-------------------		------------
//	2/20/2016		Created					TH, NS, LV, SC
//
/***************************************************************/

module memory_tb;

	logic ref_clk;
	logic WE;
	logic IorD;
	logic[31:0] addr;
	logic[31:0] WD;
	logic[31:0] RD;
  
memory L1(
          .ref_clk(ref_clk)
         ,.WE(WE)
         ,.IorD(IorD)
         ,.addr(addr)
         ,.WD(WD)
         ,.RD(RD)
         );

always #1 ref_clk = ~ ref_clk;

initial begin

	WE = 0;
 	IorD = 0;
 	WD = 32'b00000000000000000000000000000000;
 	#2 addr = 32'b00000000000000000000000000000000;
 	#2 addr = 32'b00000000000000000000000000000100;
 	#2 addr = 32'b00000000000000000000000000001000;
 	#2 addr = 32'b00000000000000000000000000001100;
 	#2 addr = 32'b00000000000000000000000000010000;
 	#2 addr = 32'b00000000000000000000000000010100;

	$finish;

end
endmodule
    
