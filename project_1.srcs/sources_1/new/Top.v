`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/01/18 22:22:52
// Design Name: 
// Module Name: Top
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


module Top(
    input 	Clk_in,	//100MHz
    output 	nLed	//D4
    );

wire [31:0] PC;
wire [31:0] Instruction;

wire ins_lui;	//U-type
wire ins_auipc;	//U-type
wire ins_jal;	//J-type
wire ins_jalr;	//I-type	
wire ins_beq;	//B-type
wire ins_bne;	//B-type
wire ins_blt;	//B-type
wire ins_bge;	//B-type
wire ins_bltu;	//B-type
wire ins_bgeu;	//B-type
wire ins_lb;	//I-type
wire ins_lh;	//I-type
wire ins_lw;	//I-type
wire ins_lbu;	//I-type
wire ins_lhu;	//I-type
wire ins_sb;	//S-type
wire ins_sh;	//S-type
wire ins_sw;	//S-type
wire ins_addi;	//I-type	
wire ins_slti;	//I-type
wire ins_sltiu;	//I-type
wire ins_xori;	//I-type
wire ins_ori;	//I-type
wire ins_andi;	//I-type
wire ins_slli;	//I-type
wire ins_srli;	//I-type
wire ins_srai;	//I-type
wire ins_add;	//R-type
wire ins_sub;	//R-type
wire ins_sll;	//R-type
wire ins_slt;	//R-type
wire ins_sltu;	//R-type
wire ins_xor;	//R-type
wire ins_srl;	//R-type
wire ins_sra;	//R-type
wire ins_or;	//R-type
wire ins_and;	//R-type

wire [4:0] rdest;
wire [4:0] rs1;
wire [4:0] rs2;
wire[11:0] imm_type_S;
wire[11:0] imm_type_I;
wire[19:0] imm_type_U;
wire[19:0] imm_type_J;
wire[11:0] imm_type_B;

wire [31:0] raddr_ram;
wire [31:0] rdata_ram;
wire [31:0] waddr_ram;
wire [31:0] wdata_ram;
wire wr_byte_ram;
wire wr_halfword_ram;
wire wr_word_ram;

wire Clk;
wire Pll_locked;
reg [11:0] Rst_cnt = 12'h800;

wire sRst;

clk_wiz_0 clk_wiz_0_inst
(
	// Clock out ports
	.clk_out1(Clk),     	// output clk_out1
	// Status and control signals
	.locked(Pll_locked),    // output locked
	// Clock in ports
	.clk_in1(Clk_in)      	// input clk_in1
);

always @ (posedge Clk or negedge Pll_locked)
begin
	if(!Pll_locked)
		Rst_cnt <= 12'h800;
	else
		Rst_cnt <= Rst_cnt + Rst_cnt[11];
end

assign sRst = Rst_cnt[11];

//latency = 1
Prog_Rom Prog_Rom_inst (
	.clka(Clk),    // input wire clka
	.addra(PC[15:2]),  // input wire [13 : 0] addra
	.douta(Instruction)  // output wire [31 : 0] douta
);

//read latency = 1
OCM OCM_inst(
/*    input 			*/.Clk(Clk),
	
/*	input		[15:0]	*/.waddr(waddr_ram[15:0]),
/*	input		[31:0] 	*/.wdata(wdata_ram),
/*	input 				*/.wr_byte(wr_byte_ram),
/*	input 				*/.wr_halfword(wr_halfword_ram),
/*	input 				*/.wr_word(wr_word_ram),
	
/*	input		[15:0]	*/.raddr(raddr_ram[15:0]),
/*	output	reg	[31:0] 	*/.rdata(rdata_ram)
    );

//latency = 0
Decoder Decoder_inst(
/*  input 	[31:0]	*/.Instruction(Instruction),

/*	output			*/.ins_lui(ins_lui),	//U-type
/*	output			*/.ins_auipc(ins_auipc),//U-type
/*	output			*/.ins_jal(ins_jal),	//J-type
/*	output			*/.ins_jalr(ins_jalr),	//I-type	
/*	output			*/.ins_beq(ins_beq),	//B-type
/*	output			*/.ins_bne(ins_bne),	//B-type
/*	output			*/.ins_blt(ins_blt),	//B-type
/*	output			*/.ins_bge(ins_bge),	//B-type
/*	output			*/.ins_bltu(ins_bltu),	//B-type
/*	output			*/.ins_bgeu(ins_bgeu),	//B-type
/*	output			*/.ins_lb(ins_lb),		//I-type
/*	output			*/.ins_lh(ins_lh),		//I-type
/*	output			*/.ins_lw(ins_lw),		//I-type
/*	output			*/.ins_lbu(ins_lbu),	//I-type
/*	output			*/.ins_lhu(ins_lhu),	//I-type
/*	output			*/.ins_sb(ins_sb),		//S-type
/*	output			*/.ins_sh(ins_sh),		//S-type
/*	output			*/.ins_sw(ins_sw),		//S-type
/*	output			*/.ins_addi(ins_addi),	//I-type	
/*	output			*/.ins_slti(ins_slti),	//I-type
/*	output			*/.ins_sltiu(ins_sltiu),//I-type
/*	output			*/.ins_xori(ins_xori),	//I-type
/*	output			*/.ins_ori(ins_ori),	//I-type
/*	output			*/.ins_andi(ins_andi),	//I-type
/*	output			*/.ins_slli(ins_slli),	//I-type
/*	output			*/.ins_srli(ins_srli),	//I-type
/*	output			*/.ins_srai(ins_srai),	//I-type
/*	output			*/.ins_add(ins_add),	//R-type
/*	output			*/.ins_sub(ins_sub),	//R-type
/*	output			*/.ins_sll(ins_sll),	//R-type
/*	output			*/.ins_slt(ins_slt),	//R-type
/*	output			*/.ins_sltu(ins_sltu),	//R-type
/*	output			*/.ins_xor(ins_xor),	//R-type
/*	output			*/.ins_srl(ins_srl),	//R-type
/*	output			*/.ins_sra(ins_sra),	//R-type
/*	output			*/.ins_or(ins_or),		//R-type
/*	output			*/.ins_and(ins_and),	//R-type
	
	
/*	output	[11:0]	*/.imm_type_S(imm_type_S),
/*	output	[11:0]	*/.imm_type_I(imm_type_I),
/*	output	[19:0]	*/.imm_type_U(imm_type_U),
/*	output	[19:0]	*/.imm_type_J(imm_type_J),
/*	output	[11:0]	*/.imm_type_B(imm_type_B),

/*	output	[4:0]	*/.rdest(rdest),
/*	output	[4:0]	*/.rs1(rs1),
/*	output	[4:0]	*/.rs2(rs2)
    );

EU EU_inst(
/*  input 				*/.Clk(Clk),
// /*	input 				*/.sRst(sRst),	//synchronous reset
/*	input 				*/.sRst(1'b0),	//synchronous reset
	
	//instruction
/*	input				*/.ins_lui(ins_lui),	//U-type
/*	input				*/.ins_auipc(ins_auipc),//U-type
/*	input				*/.ins_jal(ins_jal),	//J-type
/*	input				*/.ins_jalr(ins_jalr),	//I-type	
/*	input				*/.ins_beq(ins_beq),	//B-type
/*	input				*/.ins_bne(ins_bne),	//B-type
/*	input				*/.ins_blt(ins_blt),	//B-type
/*	input				*/.ins_bge(ins_bge),	//B-type
/*	input				*/.ins_bltu(ins_bltu),	//B-type
/*	input				*/.ins_bgeu(ins_bgeu),	//B-type
/*	input				*/.ins_lb(ins_lb),		//I-type
/*	input				*/.ins_lh(ins_lh),		//I-type
/*	input				*/.ins_lw(ins_lw),		//I-type
/*	input				*/.ins_lbu(ins_lbu),	//I-type
/*	input				*/.ins_lhu(ins_lhu),	//I-type
/*	input				*/.ins_sb(ins_sb),		//S-type
/*	input				*/.ins_sh(ins_sh),		//S-type
/*	input				*/.ins_sw(ins_sw),		//S-type
/*	input				*/.ins_addi(ins_addi),	//I-type	
/*	input				*/.ins_slti(ins_slti),	//I-type
/*	input				*/.ins_sltiu(ins_sltiu),//I-type
/*	input				*/.ins_xori(ins_xori),	//I-type
/*	input				*/.ins_ori(ins_ori),	//I-type
/*	input				*/.ins_andi(ins_andi),	//I-type
/*	input				*/.ins_slli(ins_slli),	//I-type
/*	input				*/.ins_srli(ins_srli),	//I-type
/*	input				*/.ins_srai(ins_srai),	//I-type
/*	input				*/.ins_add(ins_add),	//R-type
/*	input				*/.ins_sub(ins_sub),	//R-type
/*	input				*/.ins_sll(ins_sll),	//R-type
/*	input				*/.ins_slt(ins_slt),	//R-type
/*	input				*/.ins_sltu(ins_sltu),	//R-type
/*	input				*/.ins_xor(ins_xor),	//R-type
/*	input				*/.ins_srl(ins_srl),	//R-type
/*	input				*/.ins_sra(ins_sra),	//R-type
/*	input				*/.ins_or(ins_or),		//R-type
/*	input				*/.ins_and(ins_and),	//R-type
	
/*	input		[4:0]	*/.rdest(rdest),
/*	input		[4:0]	*/.rs1(rs1),
/*	input		[4:0]	*/.rs2(rs2),
/*	input		[11:0]	*/.imm_type_S(imm_type_S),
/*	input		[11:0]	*/.imm_type_I(imm_type_I),
/*	input		[19:0]	*/.imm_type_U(imm_type_U),
/*	input		[19:0]	*/.imm_type_J(imm_type_J),
/*	input		[11:0]	*/.imm_type_B(imm_type_B),

/*	output	reg	[31:0]	*/.PC(PC),
	
/*	output	reg	[31:0]	*/.raddr_ram(raddr_ram),
/*	input		[31:0]	*/.rdata_ram(rdata_ram),
/*	output	reg	[31:0]	*/.waddr_ram(waddr_ram),
/*	output	reg	[31:0]	*/.wdata_ram(wdata_ram),
/*	output 	reg			*/.wr_byte_ram(wr_byte_ram),
/*	output 	reg			*/.wr_halfword_ram(wr_halfword_ram),
/*	output 	reg			*/.wr_word_ram(wr_word_ram),

/*	output				*/.Test(nLed)
    );
	
endmodule
