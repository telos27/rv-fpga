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
	input				op_add,
	input				op_sub,
	input				op_and,
	input				op_or,
	input				op_xor,
	input				op_lt,	//less than (signed)
	input				op_ltu,	//less than (unsigned)
	input				op_shl,	//shift left
	input				op_shr,	//logic shift right
	input				op_shra,//arithmetic shift right
	input		[4:0]	shamt,
	input		[31:0] 	A,
	input		[31:0] 	B,
	
	//latency = 2
	output	reg	[31:0]	Result,
	
	//latency = 1
	output	reg			Result_lt,
	output	reg			Result_ltu,
	output	reg			Result_eq
    );

reg [31:0] Result_add;
reg [31:0] Result_sub;
reg [31:0] Result_and;
reg [31:0] Result_or;
reg [31:0] Result_xor;
// reg Result_lt;
// reg Result_ltu;
// reg Result_eq;

reg [31:0] Result_shl;
reg [31:0] Result_shr;
reg [31:0] Result_shra;

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
	Result_and <= A & B;
end

always @ (posedge Clk)
begin
	Result_or <= A | B;
end

always @ (posedge Clk)
begin
	Result_xor <= A ^ B;
end

always @ (posedge Clk)
begin
	if(A<B)
		Result_ltu <= 1;
	else
		Result_ltu <= 0;
end

always @ (posedge Clk)
begin
	if(A==B)
		Result_eq <= 1;
	else
		Result_eq <= 0;
end

always @ (posedge Clk)
begin
	case({A[31], B[31]})
	2'b00:
	begin
		if(A[30:0]<B[30:0])
			Result_lt <= 1;
		else
			Result_lt <= 0;
	end
	
	2'b01:
	begin
		Result_lt <= 0;
	end
	
	2'b10:
	begin
		Result_lt <= 1;
	end

	2'b11:
	begin
		if(A[30:0]<=B[30:0])
			Result_lt <= 0;
		else
			Result_lt <= 1;
	end	
	
	endcase
end

always @ (posedge Clk)
begin
	case(shamt)
	0:
		Result_shl <= A[31:0];
	1:
		Result_shl <= {A[30:0], {1{1'b0}}};
	2:
		Result_shl <= {A[29:0], {2{1'b0}}};
	3:
		Result_shl <= {A[28:0], {3{1'b0}}};
	4:
		Result_shl <= {A[27:0], {4{1'b0}}};
	5:
		Result_shl <= {A[26:0], {5{1'b0}}};
	6:
		Result_shl <= {A[25:0], {6{1'b0}}};
	7:
		Result_shl <= {A[24:0], {7{1'b0}}};
	8:
		Result_shl <= {A[23:0], {8{1'b0}}};
	9:
		Result_shl <= {A[22:0], {9{1'b0}}};
	10:
		Result_shl <= {A[21:0], {10{1'b0}}};
	11:
		Result_shl <= {A[20:0], {11{1'b0}}};
	12:
		Result_shl <= {A[19:0], {12{1'b0}}};
	13:
		Result_shl <= {A[18:0], {13{1'b0}}};
	14:
		Result_shl <= {A[17:0], {14{1'b0}}};
	15:
		Result_shl <= {A[16:0], {15{1'b0}}};
	16:
		Result_shl <= {A[15:0], {16{1'b0}}};
	17:
		Result_shl <= {A[14:0], {17{1'b0}}};
	18:
		Result_shl <= {A[13:0], {18{1'b0}}};
	19:
		Result_shl <= {A[12:0], {19{1'b0}}};
	20:
		Result_shl <= {A[11:0], {20{1'b0}}};
	21:
		Result_shl <= {A[10:0], {21{1'b0}}};
	22:
		Result_shl <= {A[9:0], {22{1'b0}}};
	23:
		Result_shl <= {A[8:0], {23{1'b0}}};
	24:
		Result_shl <= {A[7:0], {24{1'b0}}};
	25:
		Result_shl <= {A[6:0], {25{1'b0}}};
	26:
		Result_shl <= {A[5:0], {26{1'b0}}};
	27:
		Result_shl <= {A[4:0], {27{1'b0}}};
	28:
		Result_shl <= {A[3:0], {28{1'b0}}};
	29:
		Result_shl <= {A[2:0], {29{1'b0}}};
	30:
		Result_shl <= {A[1:0], {30{1'b0}}};
	31:
		Result_shl <= {A[0:0], {31{1'b0}}};
	endcase
end

always @ (posedge Clk)
begin
	case(shamt)
	0:
		Result_shr <= A[31:0];
	1:
		Result_shr <= {{1{1'b0}}, A[31:1]};
	2:
		Result_shr <= {{2{1'b0}}, A[31:2]};
	3:
		Result_shr <= {{3{1'b0}}, A[31:3]};
	4:
		Result_shr <= {{4{1'b0}}, A[31:4]};
	5:
		Result_shr <= {{5{1'b0}}, A[31:5]};
	6:
		Result_shr <= {{6{1'b0}}, A[31:6]};
	7:
		Result_shr <= {{7{1'b0}}, A[31:7]};
	8:
		Result_shr <= {{8{1'b0}}, A[31:8]};
	9:
		Result_shr <= {{9{1'b0}}, A[31:9]};
	10:
		Result_shr <= {{10{1'b0}}, A[31:10]};
	11:
		Result_shr <= {{11{1'b0}}, A[31:11]};
	12:
		Result_shr <= {{12{1'b0}}, A[31:12]};
	13:
		Result_shr <= {{13{1'b0}}, A[31:13]};
	14:
		Result_shr <= {{14{1'b0}}, A[31:14]};
	15:
		Result_shr <= {{15{1'b0}}, A[31:15]};
	16:
		Result_shr <= {{16{1'b0}}, A[31:16]};
	17:
		Result_shr <= {{17{1'b0}}, A[31:17]};
	18:
		Result_shr <= {{18{1'b0}}, A[31:18]};
	19:
		Result_shr <= {{19{1'b0}}, A[31:19]};
	20:
		Result_shr <= {{20{1'b0}}, A[31:20]};
	21:
		Result_shr <= {{21{1'b0}}, A[31:21]};
	22:
		Result_shr <= {{22{1'b0}}, A[31:22]};
	23:
		Result_shr <= {{23{1'b0}}, A[31:23]};
	24:
		Result_shr <= {{24{1'b0}}, A[31:24]};
	25:
		Result_shr <= {{25{1'b0}}, A[31:25]};
	26:
		Result_shr <= {{26{1'b0}}, A[31:26]};
	27:
		Result_shr <= {{27{1'b0}}, A[31:27]};
	28:
		Result_shr <= {{28{1'b0}}, A[31:28]};
	29:
		Result_shr <= {{29{1'b0}}, A[31:29]};
	30:
		Result_shr <= {{30{1'b0}}, A[31:30]};
	31:
		Result_shr <= {{31{1'b0}}, A[31:31]};
	endcase
end

always @ (posedge Clk)
begin
	case(shamt)
	0:
		Result_shra <= A[31:0];
	1:
		Result_shra <= {{1{A[31]}}, A[31:1]};
	2:
		Result_shra <= {{2{A[31]}}, A[31:2]};
	3:
		Result_shra <= {{3{A[31]}}, A[31:3]};
	4:
		Result_shra <= {{4{A[31]}}, A[31:4]};
	5:
		Result_shra <= {{5{A[31]}}, A[31:5]};
	6:
		Result_shra <= {{6{A[31]}}, A[31:6]};
	7:
		Result_shra <= {{7{A[31]}}, A[31:7]};
	8:
		Result_shra <= {{8{A[31]}}, A[31:8]};
	9:
		Result_shra <= {{9{A[31]}}, A[31:9]};
	10:
		Result_shra <= {{10{A[31]}}, A[31:10]};
	11:
		Result_shra <= {{11{A[31]}}, A[31:11]};
	12:
		Result_shra <= {{12{A[31]}}, A[31:12]};
	13:
		Result_shra <= {{13{A[31]}}, A[31:13]};
	14:
		Result_shra <= {{14{A[31]}}, A[31:14]};
	15:
		Result_shra <= {{15{A[31]}}, A[31:15]};
	16:
		Result_shra <= {{16{A[31]}}, A[31:16]};
	17:
		Result_shra <= {{17{A[31]}}, A[31:17]};
	18:
		Result_shra <= {{18{A[31]}}, A[31:18]};
	19:
		Result_shra <= {{19{A[31]}}, A[31:19]};
	20:
		Result_shra <= {{20{A[31]}}, A[31:20]};
	21:
		Result_shra <= {{21{A[31]}}, A[31:21]};
	22:
		Result_shra <= {{22{A[31]}}, A[31:22]};
	23:
		Result_shra <= {{23{A[31]}}, A[31:23]};
	24:
		Result_shra <= {{24{A[31]}}, A[31:24]};
	25:
		Result_shra <= {{25{A[31]}}, A[31:25]};
	26:
		Result_shra <= {{26{A[31]}}, A[31:26]};
	27:
		Result_shra <= {{27{A[31]}}, A[31:27]};
	28:
		Result_shra <= {{28{A[31]}}, A[31:28]};
	29:
		Result_shra <= {{29{A[31]}}, A[31:29]};
	30:
		Result_shra <= {{30{A[31]}}, A[31:30]};
	31:
		Result_shra <= {{31{A[31]}}, A[31:31]};
	endcase
end

always @ (posedge Clk)
begin
	// Result <= (({32{add}} & Result_add)|
			   // ({32{sub}} & Result_sub));
			   
	if(op_add)		//add
		Result <= Result_add;
	else if(op_sub)	//sub
		Result <= Result_sub;
	else if(op_and)	//and
		Result <= Result_and;
	else if(op_or)	//or
		Result <= Result_or;
	else if(op_xor)	//xor
		Result <= Result_xor;
	else if(op_ltu)	//less than (unsigned)
		Result <= {31'h00000000, Result_ltu};
	else if(op_lt) 	//less than (signed)
		Result <= {31'h00000000, Result_lt};
	else if(op_shl) //shift left	
		Result <= Result_shl;
	else if(op_shr) //logic shift right	
		Result <= Result_shr;
	else 			//arithmetic shift right
		Result <= Result_shra;
end
	
endmodule
