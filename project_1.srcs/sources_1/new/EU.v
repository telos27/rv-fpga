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
		//R-type
	input				ins_add,
	input				ins_sub,
		//I-type
	input				ins_addi,
	input				ins_lb,		
	
	input		[4:0]	rdest,
	input		[4:0]	rs1,
	input		[4:0]	rs2,
	input		[11:0]	imm12,
	
	output	reg			PC_inc_en=0,
	
	output	reg	[31:0]	raddr_ram,
	input		[31:0]	rdata_ram
    );

localparam INSTRUCT_PERIOD = 5;

wire [31:0] ALU_Result;	
wire [31:0] data_rs1;	
wire [31:0] data_rs2;	
reg wr_rdest;	

reg ALU_Add;
reg ALU_Sub;
reg [31:0] ALU_A;
reg [31:0] ALU_B;

reg [2:0] exec_cnt=0;

reg [31:0] data_rdest;

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

always @ (posedge Clk)
begin
	if(exec_cnt==(INSTRUCT_PERIOD-2))
		PC_inc_en <= 1;
	else
		PC_inc_en <= 0;
end

always @ (posedge Clk)
begin
	if((exec_cnt==(INSTRUCT_PERIOD-2))&&
	   (ins_add || ins_addi || ins_sub || ins_lb)
	  )
		wr_rdest <= 1;
	else
		wr_rdest <= 0;
end

always @ (*)
begin
	if(ins_add || ins_addi || ins_sub)
		data_rdest = ALU_Result;
	else	//lb, lh, lw, lbu, lhu
	begin
		if(ins_lb)
		begin
			case(raddr_ram[1:0])
			2'b00:
				data_rdest = {{24{rdata_ram[7]}}, rdata_ram[7:0]};
			2'b01:
				data_rdest = {{24{rdata_ram[15]}}, rdata_ram[15:7]};
			2'b10:
				data_rdest = {{24{rdata_ram[23]}}, rdata_ram[23:16]};
			2'b11:
				data_rdest = {{24{rdata_ram[31]}}, rdata_ram[31:24]};
			default:
				data_rdest = {{24{rdata_ram[7]}}, rdata_ram[7:0]};
			endcase
		end
		else
			data_rdest = {{24{rdata_ram[7]}}, rdata_ram[7:0]};
	end
end

//////////////////////////////////////////////////////////
//ALU
always @ (*)
begin
	ALU_Add = ins_add || ins_addi;
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
	if(ins_addi)
		ALU_B = {{20{imm12[11]}}, imm12[11:0]};
	else
		ALU_B = data_rs2;
end

// latency = 2	
ALU ALU_inst(
/*  input 				*/.Clk(Clk),
/*	input				*/.add(ALU_Add),
/*	input				*/.sub(ALU_Sub),
/*	input		[31:0] 	*/.A(ALU_A),
/*	input		[31:0] 	*/.B(ALU_B),
/*	output	reg	[31:0]	*/.Result(ALU_Result)
    );
	
////////////////////////////////////////////////////
//	read on chip SRAM
always @ (posedge Clk)
begin
	raddr_ram <= data_rs1 + {{20{imm12[11]}},imm12[11:0]};
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
/*	output	reg	[31:0]	*/.data_rs2(data_rs2)
    );	
endmodule
