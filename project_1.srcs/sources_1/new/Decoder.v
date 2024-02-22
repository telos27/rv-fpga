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
	
	output	ins_lui,	//U-type
	output	ins_auipc,	//U-type
	output	ins_jal,	//J-type
	output	ins_jalr,	//I-type	
	output	ins_beq,	//B-type
	output	ins_bne,	//B-type
	output	ins_blt,	//B-type
	output	ins_bge,	//B-type
	output	ins_bltu,	//B-type
	output	ins_bgeu,	//B-type
	output	ins_lb,		//I-type
	output	ins_lh,		//I-type
	output	ins_lw,		//I-type
	output	ins_lbu,	//I-type
	output	ins_lhu,	//I-type
	output	ins_sb,		//S-type
	output	ins_sh,		//S-type
	output	ins_sw,		//S-type
	output	ins_addi,	//I-type	
	output	ins_slti,	//I-type
	output	ins_sltiu,	//I-type
	output	ins_xori,	//I-type
	output	ins_ori,	//I-type
	output	ins_andi,	//I-type
	output	ins_slli,	//I-type
	output	ins_srli,	//I-type
	output	ins_srai,	//I-type
	output	ins_add,	//R-type
	output	ins_sub,	//R-type
	output	ins_sll,	//R-type
	output	ins_slt,	//R-type
	output	ins_sltu,	//R-type
	output	ins_xor,	//R-type
	output	ins_srl,	//R-type
	output	ins_sra,	//R-type
	output	ins_or,		//R-type
	output	ins_and,	//R-type

	output	ins_csrrw,	//CSR
	output	ins_csrrs,	//CSR
	output	ins_csrrc,	//CSR
	output	ins_csrrwi,	//CSR
	output	ins_csrrsi,	//CSR
	output	ins_csrrci,	//CSR
	
	output	[11:0]	imm_type_S,
	output	[11:0]	imm_type_I,
	output	[19:0]	imm_type_U,
	output	[19:0]	imm_type_J,
	output	[11:0]	imm_type_B,
	output	[11:0]	csr_index,
	output	[4:0]	rdest,
	output	[4:0]	rs1,
	output	[4:0]	rs2,
	output	[4:0]	zimm
	
    );

wire [6:0] opcode;	
wire [2:0] funct3;	
wire [6:0] funct7;	
	
assign rdest = Instruction[11:7];
assign rs1 = Instruction[19:15];
assign rs2 = Instruction[24:20];
assign zimm = Instruction[19:15];
assign opcode = Instruction[6:0];
assign funct3 = Instruction[14:12];
assign funct7 = Instruction[31:25];
assign imm_type_I = Instruction[31:20];
assign imm_type_S = {Instruction[31:25], Instruction[11:7]};
assign imm_type_U = Instruction[31:12];
assign imm_type_J = {Instruction[31], Instruction[19:12], Instruction[20], Instruction[30:21]};
assign imm_type_B = {Instruction[31], Instruction[7], Instruction[30:25], Instruction[11:8]};
assign csr_index = Instruction[31:20];

// type_U
assign ins_lui = (opcode[6:0]==7'b0110111);
assign ins_auipc = (opcode[6:0]==7'b0010111);
 
// type_J
assign ins_jal = (opcode[6:0]==7'b1101111);
 
// type_R					 
assign ins_add = (opcode[6:0]==7'b0110011) && (funct3==3'h0) && (funct7==7'h00);
assign ins_sub = (opcode[6:0]==7'b0110011) && (funct3==3'h0) && (funct7==7'h20);
assign ins_sll = (opcode[6:0]==7'b0110011) && (funct3==3'h1) && (funct7==7'h00);
assign ins_slt = (opcode[6:0]==7'b0110011) && (funct3==3'h2) && (funct7==7'h00);
assign ins_sltu = (opcode[6:0]==7'b0110011) && (funct3==3'h3) && (funct7==7'h00);
assign ins_xor = (opcode[6:0]==7'b0110011) && (funct3==3'h4) && (funct7==7'h00);
assign ins_srl = (opcode[6:0]==7'b0110011) && (funct3==3'h5) && (funct7==7'h00);
assign ins_sra = (opcode[6:0]==7'b0110011) && (funct3==3'h5) && (funct7==7'h20);
assign ins_or = (opcode[6:0]==7'b0110011) && (funct3==3'h6) && (funct7==7'h00);
assign ins_and = (opcode[6:0]==7'b0110011) && (funct3==3'h7) && (funct7==7'h00);

// type_I
assign ins_jalr = (opcode[6:0]==7'b1100111) && (funct3==3'h0);
assign ins_lb = (opcode[6:0]==7'b0000011) && (funct3==3'h0);
assign ins_lh = (opcode[6:0]==7'b0000011) && (funct3==3'h1);
assign ins_lw = (opcode[6:0]==7'b0000011) && (funct3==3'h2);
assign ins_lbu = (opcode[6:0]==7'b0000011) && (funct3==3'h4);
assign ins_lhu = (opcode[6:0]==7'b0000011) && (funct3==3'h5);
assign ins_addi = (opcode[6:0]==7'b0010011) && (funct3==3'h0);
assign ins_slti = (opcode[6:0]==7'b0010011) && (funct3==3'h2);
assign ins_sltiu = (opcode[6:0]==7'b0010011) && (funct3==3'h3);
assign ins_xori = (opcode[6:0]==7'b0010011) && (funct3==3'h4);
assign ins_ori = (opcode[6:0]==7'b0010011) && (funct3==3'h6);
assign ins_andi = (opcode[6:0]==7'b0010011) && (funct3==3'h7);
assign ins_slli = (opcode[6:0]==7'b0010011) && (funct3==3'h1);
assign ins_srli = (opcode[6:0]==7'b0010011) && (funct3==3'h5) && (funct7==7'h00);
assign ins_srai = (opcode[6:0]==7'b0010011) && (funct3==3'h5) && (funct7==7'h20);

// type_S
assign ins_sb = (opcode[6:0]==7'b0100011) && (funct3==3'h0);
assign ins_sh = (opcode[6:0]==7'b0100011) && (funct3==3'h1);
assign ins_sw = (opcode[6:0]==7'b0100011) && (funct3==3'h2);

// type_B
assign ins_beq = (opcode[6:0]==7'b1100011) && (funct3==3'h0);
assign ins_bne = (opcode[6:0]==7'b1100011) && (funct3==3'h1);
assign ins_blt = (opcode[6:0]==7'b1100011) && (funct3==3'h4);
assign ins_bge = (opcode[6:0]==7'b1100011) && (funct3==3'h5);
assign ins_bltu = (opcode[6:0]==7'b1100011) && (funct3==3'h6);
assign ins_bgeu = (opcode[6:0]==7'b1100011) && (funct3==3'h7);

//CSR
assign ins_csrrw = (opcode[6:0]==7'b1110011) && (funct3==3'h1);
assign ins_csrrs = (opcode[6:0]==7'b1110011) && (funct3==3'h2);
assign ins_csrrc = (opcode[6:0]==7'b1110011) && (funct3==3'h3);
assign ins_csrrwi = (opcode[6:0]==7'b1110011) && (funct3==3'h5);
assign ins_csrrsi = (opcode[6:0]==7'b1110011) && (funct3==3'h6);
assign ins_csrrci = (opcode[6:0]==7'b1110011) && (funct3==3'h7);
endmodule
