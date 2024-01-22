`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/01/19 14:01:09
// Design Name: 
// Module Name: Decoder
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
// latency = 0
//////////////////////////////////////////////////////////////////////////////////


module Decoder(
    input 	[31:0]	Instruction,
	
	//R-type
	output	ins_add,
	output	ins_sub,
	
	//I-type
	output	ins_addi,	
	output	ins_lb,	
	
	output	[11:0]	imm12,
	output	[4:0]	rdest,
	output	[4:0]	rs1,
	output	[4:0]	rs2
    );

wire [6:0] opcode;	
wire [2:0] funct3;	
wire [6:0] funct7;	
	
assign rdest = Instruction[11:7];
assign rs1 = Instruction[19:15];
assign rs2 = Instruction[24:20];
assign opcode = Instruction[6:0];
assign funct3 = Instruction[14:12];
assign funct7 = Instruction[31:25];
assign imm12 = Instruction[31:20];
 
// type_R					 
assign ins_add = (opcode[6:2]==5'b01100) && (funct3==3'h0) && (funct7==7'h00);
assign ins_sub = (opcode[6:2]==5'b01100) && (funct3==3'h0) && (funct7==7'h20);

// type_I
assign ins_addi = (opcode[6:2]==5'b00100) && (funct3==3'h0);
assign ins_lb = (opcode[6:2]==5'b00000) && (funct3==3'h0);

endmodule
