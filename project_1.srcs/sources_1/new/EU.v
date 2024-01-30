`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/01/20 21:20:42
// Design Name: 
// Module Name: EU
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


module EU(
    input 				Clk,
	input 				sRst,	//synchronous reset
	
	//instruction
	input				ins_lui,	//U-type
	input				ins_auipc,	//U-type
	input				ins_jal,	//J-type
	input				ins_jalr,	//I-type	
	input				ins_beq,	//B-type
	input				ins_bne,	//B-type
	input				ins_blt,	//B-type
	input				ins_bge,	//B-type
	input				ins_bltu,	//B-type
	input				ins_bgeu,	//B-type
	input				ins_lb,		//I-type
	input				ins_lh,		//I-type
	input				ins_lw,		//I-type
	input				ins_lbu,	//I-type
	input				ins_lhu,	//I-type
	input				ins_sb,		//S-type
	input				ins_sh,		//S-type
	input				ins_sw,		//S-type
	input				ins_addi,	//I-type	
	input				ins_slti,	//I-type
	input				ins_sltiu,	//I-type
	input				ins_xori,	//I-type
	input				ins_ori,	//I-type
	input				ins_andi,	//I-type
	input				ins_slli,	//I-type
	input				ins_srli,	//I-type
	input				ins_srai,	//I-type
	input				ins_add,	//R-type
	input				ins_sub,	//R-type
	input				ins_sll,	//R-type
	input				ins_slt,	//R-type
	input				ins_sltu,	//R-type
	input				ins_xor,	//R-type
	input				ins_srl,	//R-type
	input				ins_sra,	//R-type
	input				ins_or,		//R-type
	input				ins_and,	//R-type
	
	input		[4:0]	rdest,
	input		[4:0]	rs1,
	input		[4:0]	rs2,
	input		[11:0]	imm_type_S,
	input		[11:0]	imm_type_I,
	input		[19:0]	imm_type_U,
	input		[19:0]	imm_type_J,
	input		[11:0]	imm_type_B,
	
	output	reg	[31:0]	PC=0,
	
	output	reg	[31:0]	raddr_ram,
	input		[31:0]	rdata_ram,
	output	reg	[31:0]	waddr_ram,
	output	reg	[31:0]	wdata_ram,
	output 	reg			wr_byte_ram,
	output 	reg			wr_halfword_ram,
	output 	reg			wr_word_ram,
	
	output				Test
    );

localparam INSTRUCT_PERIOD = 5;

wire [31:0] data_rs1;	
wire [31:0] data_rs2;	
reg [31:0] data_rdest;
reg wr_rdest;	

reg ALU_Add;
reg ALU_Sub;
reg ALU_Lt;
reg ALU_Ltu;
reg ALU_Xor;
reg ALU_Or;
reg ALU_And;
reg ALU_Shl;
reg ALU_Shr;
reg ALU_Shra;
reg [4:0] ALU_shamt;
reg [31:0] ALU_A;
reg [31:0] ALU_B;
wire [31:0] ALU_Result;	
wire ALU_Result_lt;	
wire ALU_Result_ltu;	
wire ALU_Result_eq;	

reg [2:0] exec_cnt=0;


reg PC_inc=0;
reg [31:0] PC_inc_value=4;
reg PC_set=0;
reg [31:0] PC_set_value=0;

always @ (posedge Clk)
begin
	if(sRst)
		exec_cnt <= 0;
	else
	begin
		if(exec_cnt==(INSTRUCT_PERIOD-1))
			exec_cnt <= 0;
		else
			exec_cnt <= exec_cnt + 1'b1;
	end
end

////////////////////////////////////////////
// PC
always @ (posedge Clk)
begin
	if(sRst)
		PC <= 0;
	else
	begin
		if(PC_set)
			PC <= PC_set_value;
		else if(PC_inc)
			// PC <= PC + 3'd4;
			PC <= PC + PC_inc_value;
		else
			PC <= PC;
	end
end

always @ (*)
begin
	// PC_set = 0;
	PC_inc_value = 4;
end

always @ (posedge Clk)
begin
	if(ins_jal)
		PC_set_value <= PC + {{11{imm_type_J[19]}}, imm_type_J, 1'b0};
	else if(ins_jalr)
		PC_set_value <= (data_rs1 + {{20{imm_type_I[11]}}, imm_type_I}) & 32'hFFFFFFFE;
	else	//ins_beq ins_bne ins_blt ins_bge ins_bltu ins_bgeu
		PC_set_value <= PC + {{19{imm_type_B[11]}}, imm_type_B, 1'b0};
end

// always @ (posedge Clk)
// begin
	// begin
		// if(ins_jalr)
			// PC_inc_value <= data_rs1 + {{20{imm_type_I[11]}}, imm_type_I};
		// else
			// PC_inc_value <= 4;
	// end
// end

always @ (posedge Clk)
begin
	if((exec_cnt==(INSTRUCT_PERIOD-2))&&
	   (ins_jalr ||
	    ins_jal  ||
		(ins_beq && ALU_Result_eq)||
		(ins_bne && (!ALU_Result_eq))||
		(ins_blt && ALU_Result_lt)||
		(ins_bge && ((!ALU_Result_lt)||ALU_Result_eq))||
		(ins_bltu && ALU_Result_ltu)||
		(ins_bgeu && ((!ALU_Result_ltu)||ALU_Result_eq))
		))
		PC_set <= 1;
	else
		PC_set <= 0;
end

always @ (posedge Clk)
begin
	if(exec_cnt==(INSTRUCT_PERIOD-2))
		PC_inc <= 1;
	else
		PC_inc <= 0;
end

//////////////////////////////////////////////////////
//
always @ (posedge Clk)
begin
	if((exec_cnt==(INSTRUCT_PERIOD-2))&&
	   (ins_lui || ins_auipc || 
	    ins_jal || ins_jalr || 
		ins_lb || ins_lh || ins_lw || ins_lbu || ins_lhu || 
		ins_add || ins_sub || ins_sll || ins_slt || ins_sltu || ins_xor || ins_srl || ins_sra || ins_or || ins_and ||
		 ins_addi || ins_slti || ins_sltiu || ins_xori || ins_ori || ins_andi || ins_slli || ins_srli || ins_srai)
	  )
		wr_rdest <= 1;
	else
		wr_rdest <= 0;
end

always @ (*)
begin
	if(ins_lui)
		data_rdest = {imm_type_U, {12{1'b0}}};
	else if(ins_auipc)
		data_rdest = PC + {imm_type_U, {12{1'b0}}};
	else if(ins_jal||ins_jalr)	
		data_rdest = PC + 3'h4;
	// else if(ins_addi || ins_add || ins_sub)
		// data_rdest = ALU_Result;
	else if(ins_lb)	//lb
		data_rdest = {{24{rdata_ram[7]}}, rdata_ram[7:0]};
	else if(ins_lh)	//lh
		data_rdest = {{16{rdata_ram[15]}}, rdata_ram[15:0]};
	else if(ins_lw)	//lw
		data_rdest = rdata_ram;
	else if(ins_lbu)//lbu
		data_rdest = {{24{1'b0}}, rdata_ram[7:0]};
	else if(ins_lhu)//lhu
		data_rdest = {{16{1'b0}}, rdata_ram[15:0]};
	else
		data_rdest = ALU_Result;
end

//////////////////////////////////////////////////////////
//ALU
always @ (*)
begin
	ALU_Add = ins_addi || ins_add;
end

always @ (*)
begin
	ALU_Lt = ins_slti || ins_slt;
end

always @ (*)
begin
	ALU_Ltu = ins_sltiu || ins_sltu;
end

always @ (*)
begin
	ALU_Xor = ins_xori || ins_xor;
end

always @ (*)
begin
	ALU_Or = ins_ori || ins_or;
end

always @ (*)
begin
	ALU_And = ins_andi || ins_and;
end

always @ (*)
begin
	ALU_Shl = ins_slli || ins_sll;
end

always @ (*)
begin
	ALU_Shr = ins_srli || ins_srl;
end

always @ (*)
begin
	ALU_Shra = ins_srai || ins_sra;
end

always @ (*)
begin
	ALU_Sub = ins_sub;
end

always @ (*)
begin
	ALU_A = data_rs1;
end

always @ (*)
begin
	if(ins_addi||ins_slti||ins_sltiu||ins_xori||ins_ori||ins_andi||ins_slli||ins_srli||ins_srai)
		ALU_B = {{20{imm_type_I[11]}}, imm_type_I[11:0]};
	else	//ins_beq ins_bne ins_blt
		ALU_B = data_rs2;
end

always @ (*)
begin
	if(ins_slli||ins_srli||ins_srai)
		ALU_shamt = imm_type_I[4:0];
	else	//ins_beq ins_bne ins_blt
		ALU_shamt = data_rs2[4:0];
end

// latency = 1 or 2	
ALU ALU_inst(
/*  input 				*/.Clk(Clk),
/*	input				*/.op_add(ALU_Add),
/*	input				*/.op_sub(ALU_Sub),
/*	input				*/.op_and(ALU_And),
/*	input				*/.op_or(ALU_Or),
/*	input				*/.op_xor(ALU_Xor),
/*	input				*/.op_lt(ALU_Lt),	//less than (signed)
/*	input				*/.op_ltu(ALU_Ltu),	//less than (unsigned)
/*	input				*/.op_shl(ALU_Shl),	//shift left
/*	input				*/.op_shr(ALU_Shr),	//logic shift right
/*	input				*/.op_shra(ALU_Shra),//arithmetic shift right
/*	input		[4:0]	*/.shamt(ALU_shamt),
/*	input		[31:0] 	*/.A(ALU_A),
/*	input		[31:0] 	*/.B(ALU_B),

	//latency = 2
/*	output	reg	[31:0]	*/.Result(ALU_Result),
	
	//latency = 1
/*	output	reg			*/.Result_lt(ALU_Result_lt),
/*	output	reg			*/.Result_ltu(ALU_Result_ltu),
/*	output	reg			*/.Result_eq(ALU_Result_eq)

    );
	
////////////////////////////////////////////////////
//	read on chip SRAM
always @ (posedge Clk)
begin
	raddr_ram <= data_rs1 + {{20{imm_type_I[11]}},imm_type_I[11:0]};
end

//	Write on chip SRAM
always @ (*)
begin
	wdata_ram = data_rs2;
end

always @ (posedge Clk)
begin
	waddr_ram <= data_rs1 + {{20{imm_type_S[11]}},imm_type_S[11:0]};
end

always @ (posedge Clk)
begin
	if((exec_cnt==(INSTRUCT_PERIOD-2))&&ins_sb)
		wr_byte_ram <= 1;
	else
		wr_byte_ram <= 0;
end

always @ (posedge Clk)
begin
	if((exec_cnt==(INSTRUCT_PERIOD-2))&&ins_sh)
		wr_halfword_ram <= 1;
	else
		wr_halfword_ram <= 0;
end

always @ (posedge Clk)
begin
	if((exec_cnt==(INSTRUCT_PERIOD-2))&&ins_sw)
		wr_word_ram <= 1;
	else
		wr_word_ram <= 0;
end

//Read Latency = 1
GenReg GenReg_inst(
/*    input 			*/.Clk(Clk),
/*    input 			*/.sRst(sRst),	//synchronous reset
	
/*	input		[31:0]	*/.data_rdest(data_rdest),
/*	input		[4:0]	*/.rdest(rdest),
/*	input				*/.wr_rdest(wr_rdest),
/*	input		[4:0]	*/.rs1(rs1),
/*	input		[4:0]	*/.rs2(rs2),
/*	output	reg	[31:0]	*/.data_rs1(data_rs1),
/*	output	reg	[31:0]	*/.data_rs2(data_rs2),
/*	output	reg			*/.Test(Test)
    );	
endmodule
