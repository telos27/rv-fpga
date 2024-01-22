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
    input Clk	//100MHz
    );

reg [31:0] PC=0;
wire [31:0] Instruction;

wire ins_add;
wire ins_sub;
wire ins_addi;
wire ins_lb;

wire [4:0] rdest;
wire [4:0] rs1;
wire [4:0] rs2;
wire [11:0] imm12;

wire PC_inc_en;
wire [31:0] raddr_ram;
wire [31:0] rdata_ram;

always @ (posedge Clk)
begin
	if(PC_inc_en)
		PC <= PC + 3'd4;
end

//latency = 1
Prog_Rom Prog_Rom_inst (
	.clka(Clk),    // input wire clka
	.addra(PC[15:2]),  // input wire [13 : 0] addra
	.douta(Instruction)  // output wire [31 : 0] douta
);

CPU_Ram CPU_Ram_inst (
	.clka(Clk),    // input wire clka
	.wea(0),      // input wire [3 : 0] wea
	.addra(0),  // input wire [13 : 0] addra
	.dina(0),    // input wire [31 : 0] dina
	.clkb(Clk),    // input wire clkb
	.addrb(raddr_ram[15:2]),  	// input wire [13 : 0] addrb
	.doutb(rdata_ram)  			// output wire [31 : 0] doutb
);

//latency = 0
Decoder Decoder_inst(
/*  input 	[31:0]	*/.Instruction(Instruction),

	//R-type
/*	output			*/.ins_add(ins_add),
/*	output			*/.ins_sub(ins_sub),

	//I-type
/*	output			*/.ins_addi(ins_addi),
/*	output			*/.ins_lb(ins_lb),

/*	output	[31:0]	*/.imm12(imm12),
/*	output	[4:0]	*/.rdest(rdest),
/*	output	[4:0]	*/.rs1(rs1),
/*	output	[4:0]	*/.rs2(rs2)
    );

EU EU_inst(
/*  input 				*/.Clk(Clk),
/*	input 				*/.sRst(1'b0),	//synchronous reset
	
	//instruction
		//R-type	
/*	input				*/.ins_add(ins_add),
/*	input				*/.ins_sub(ins_sub),

		//I-type
/*	input				*/.ins_addi(ins_addi),
/*	input				*/.ins_lb(ins_lb),	
	
/*	input		[4:0]	*/.rdest(rdest),
/*	input		[4:0]	*/.rs1(rs1),
/*	input		[4:0]	*/.rs2(rs2),
/*	input		[11:0]	*/.imm12(imm12),

/*	output				*/.PC_inc_en(PC_inc_en),

/*	output	reg	[31:0]	*/.raddr_ram(raddr_ram),
/*	input		[31:0]	*/.rdata_ram(rdata_ram)
    );
	
endmodule
