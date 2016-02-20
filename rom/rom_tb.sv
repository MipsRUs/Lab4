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


module rom_tb;
  logic ref_clk;
  logic[31:0] input1;
  wire[31:0] dataOut1;
  
  rom L1     (
              .ref_clk(ref_clk),
              .addr(input1),
                 .dataOut(dataOut1));

  always #1 ref_clk = ~ ref_clk;

  initial begin
  ref_clk = 1;
  input1 = 32'b00000000000000000000000000000000;
  #10;
  input1 = 32'b00000000000000000000000000000100;
  #10;
  input1 = 32'b00000000000000000000000000001000;
  #10;
  input1 = 32'b00000000000000000000000000001100;
  end
 endmodule 

    
