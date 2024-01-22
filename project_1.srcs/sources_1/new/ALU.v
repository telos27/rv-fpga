`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/01/20 20:38:22
// Design Name: 
// Module Name: ALU
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
// latency = 2
//////////////////////////////////////////////////////////////////////////////////
module ALU(
    input 				Clk,
	input				add,
	input				sub,
	input		[31:0] 	A,
	input		[31:0] 	B,
	output	reg	[31:0]	Result
    );

reg [31:0] Result_add;
reg [31:0] Result_sub;

always @ (posedge Clk)
begin
	Result_add <= A + B;
end

always @ (posedge Clk)
begin
	Result_sub <= A - B;
end

always @ (posedge Clk)
begin
	// Result <= (({32{add}} & Result_add)|
			   // ({32{sub}} & Result_sub));
			   
	if(add)	//add
		Result <= Result_add;
	else	//sub
		Result <= Result_sub;
end
	
endmodule
