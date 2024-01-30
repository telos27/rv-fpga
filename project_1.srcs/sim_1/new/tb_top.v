`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/01/21 10:56:12
// Design Name: 
// Module Name: tb_top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_top(
    );

parameter CLK_PERIOD = 10;

reg Clk=0;

always 
begin
	Clk = 1'b0;
	#(CLK_PERIOD/2) Clk = 1'b1;
	#(CLK_PERIOD/2);
end
	
Top Top_inst(
/*    input */.Clk_in(Clk)	//100MHz
    );
	
endmodule
