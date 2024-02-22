`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/01/18 22:59:44
// Design Name: 
// Module Name: GenReg
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
// Read Latency = 1
//////////////////////////////////////////////////////////////////////////////////

module GenReg(
    input 				Clk,
    input 				sRst,	//synchronous reset
	
	input		[31:0]	data_rdest,
	input		[4:0]	rdest,
	input				wr_rdest,
	input		[4:0]	rs1,
	input		[4:0]	rs2,
	output	reg	[31:0]	data_rs1,
	output	reg	[31:0]	data_rs2,
	output	reg			Test
    );
	
// reg [31:0] X0;
reg [31:0] X1=0;
reg [31:0] X2=0;
reg [31:0] X3=0;
reg [31:0] X4=0;
reg [31:0] X5=0;
reg [31:0] X6=0;
reg [31:0] X7=0;
reg [31:0] X8=0;
reg [31:0] X9=0;
reg [31:0] X10=0;
reg [31:0] X11=0;
reg [31:0] X12=0;
reg [31:0] X13=0;
reg [31:0] X14=0;
reg [31:0] X15=0;
reg [31:0] X16=0;
reg [31:0] X17=0;
reg [31:0] X18=0;
reg [31:0] X19=0;
reg [31:0] X20=0;
reg [31:0] X21=0;
reg [31:0] X22=0;
reg [31:0] X23=0;
reg [31:0] X24=0;
reg [31:0] X25=0;
reg [31:0] X26=0;
reg [31:0] X27=0;
reg [31:0] X28=0;
reg [31:0] X29=0;
reg [31:0] X30=0;
reg [31:0] X31=0;

// always @ (*)
// begin
	// X0 = 0;
// end

//////////////////// write //////////////////////////////
always @ (posedge Clk)
begin
	if(sRst)
		X1 <= 0;
	else
	begin
		if(wr_rdest && (rdest==1))
			X1 <= data_rdest;
	end
end

always @ (posedge Clk)
begin
	if(sRst)
		X2 <= 0;
	else
	begin
		if(wr_rdest && (rdest==2))
			X2 <= data_rdest;
	end
end

always @ (posedge Clk)
begin
	if(sRst)
		X3 <= 0;
	else
	begin
		if(wr_rdest && (rdest==3))
			X3 <= data_rdest;
	end
end

always @ (posedge Clk)
begin
	if(sRst)
		X4 <= 0;
	else
	begin
		if(wr_rdest && (rdest==4))
			X4 <= data_rdest;
	end
end

always @ (posedge Clk)
begin
	if(sRst)
		X5 <= 0;
	else
	begin
		if(wr_rdest && (rdest==5))
			X5 <= data_rdest;
	end
end

always @ (posedge Clk)
begin
	if(sRst)
		X6 <= 0;
	else
	begin
		if(wr_rdest && (rdest==6))
			X6 <= data_rdest;
	end
end

always @ (posedge Clk)
begin
	if(sRst)
		X7 <= 0;
	else
	begin
		if(wr_rdest && (rdest==7))
			X7 <= data_rdest;
	end
end

always @ (posedge Clk)
begin
	if(sRst)
		X8 <= 0;
	else
	begin
		if(wr_rdest && (rdest==8))
			X8 <= data_rdest;
	end
end

always @ (posedge Clk)
begin
	if(sRst)
		X9 <= 0;
	else
	begin
		if(wr_rdest && (rdest==9))
			X9 <= data_rdest;
	end
end

always @ (posedge Clk)
begin
	if(sRst)
		X10 <= 0;
	else
	begin
		if(wr_rdest && (rdest==10))
			X10 <= data_rdest;
	end
end

always @ (posedge Clk)
begin
	if(sRst)
		X11 <= 0;
	else
	begin
		if(wr_rdest && (rdest==11))
			X11 <= data_rdest;
	end
end

always @ (posedge Clk)
begin
	if(sRst)
		X12 <= 0;
	else
	begin
		if(wr_rdest && (rdest==12))
			X12 <= data_rdest;
	end
end

always @ (posedge Clk)
begin
	if(sRst)
		X13 <= 0;
	else
	begin
		if(wr_rdest && (rdest==13))
			X13 <= data_rdest;
	end
end

always @ (posedge Clk)
begin
	if(sRst)
		X14 <= 0;
	else
	begin
		if(wr_rdest && (rdest==14))
			X14 <= data_rdest;
	end
end

always @ (posedge Clk)
begin
	if(sRst)
		X15 <= 0;
	else
	begin
		if(wr_rdest && (rdest==15))
			X15 <= data_rdest;
	end
end

always @ (posedge Clk)
begin
	if(sRst)
		X16 <= 0;
	else
	begin
		if(wr_rdest && (rdest==16))
			X16 <= data_rdest;
	end
end

always @ (posedge Clk)
begin
	if(sRst)
		X17 <= 0;
	else
	begin
		if(wr_rdest && (rdest==17))
			X17 <= data_rdest;
	end
end

always @ (posedge Clk)
begin
	if(sRst)
		X18 <= 0;
	else
	begin
		if(wr_rdest && (rdest==18))
			X18 <= data_rdest;
	end
end

always @ (posedge Clk)
begin
	if(sRst)
		X19 <= 0;
	else
	begin
		if(wr_rdest && (rdest==19))
			X19 <= data_rdest;
	end
end

always @ (posedge Clk)
begin
	if(sRst)
		X20 <= 0;
	else
	begin
		if(wr_rdest && (rdest==20))
			X20 <= data_rdest;
	end
end

always @ (posedge Clk)
begin
	if(sRst)
		X21 <= 0;
	else
	begin
		if(wr_rdest && (rdest==21))
			X21 <= data_rdest;
	end
end

always @ (posedge Clk)
begin
	if(sRst)
		X22 <= 0;
	else
	begin
		if(wr_rdest && (rdest==22))
			X22 <= data_rdest;
	end
end

always @ (posedge Clk)
begin
	if(sRst)
		X23 <= 0;
	else
	begin
		if(wr_rdest && (rdest==23))
			X23 <= data_rdest;
	end
end

always @ (posedge Clk)
begin
	if(sRst)
		X24 <= 0;
	else
	begin
		if(wr_rdest && (rdest==24))
			X24 <= data_rdest;
	end
end

always @ (posedge Clk)
begin
	if(sRst)
		X25 <= 0;
	else
	begin
		if(wr_rdest && (rdest==25))
			X25 <= data_rdest;
	end
end

always @ (posedge Clk)
begin
	if(sRst)
		X26 <= 0;
	else
	begin
		if(wr_rdest && (rdest==26))
			X26 <= data_rdest;
	end
end

always @ (posedge Clk)
begin
	if(sRst)
		X27 <= 0;
	else
	begin
		if(wr_rdest && (rdest==27))
			X27 <= data_rdest;
	end
end

always @ (posedge Clk)
begin
	if(sRst)
		X28 <= 0;
	else
	begin
		if(wr_rdest && (rdest==28))
			X28 <= data_rdest;
	end
end

always @ (posedge Clk)
begin
	if(sRst)
		X29 <= 0;
	else
	begin
		if(wr_rdest && (rdest==29))
			X29 <= data_rdest;
	end
end

always @ (posedge Clk)
begin
	if(sRst)
		X30 <= 0;
	else
	begin
		if(wr_rdest && (rdest==30))
			X30 <= data_rdest;
	end
end

always @ (posedge Clk)
begin
	if(sRst)
		X31 <= 0;
	else
	begin
		if(wr_rdest && (rdest==31))
			X31 <= data_rdest;
	end
end

//////////////////// read ///////////////////////////////
always @ (posedge Clk)
begin
	case(rs1)
	0:
		data_rs1 <= 0;
	1:
		data_rs1 <= X1;
	2:
		data_rs1 <= X2;
	3:
		data_rs1 <= X3;
	4:
		data_rs1 <= X4;
	5:
		data_rs1 <= X5;
	6:
		data_rs1 <= X6;
	7:
		data_rs1 <= X7;
	8:
		data_rs1 <= X8;
	9:
		data_rs1 <= X9;
	10:
		data_rs1 <= X10;
	11:
		data_rs1 <= X11;
	12:
		data_rs1 <= X12;
	13:
		data_rs1 <= X13;
	14:
		data_rs1 <= X14;
	15:
		data_rs1 <= X15;
	16:
		data_rs1 <= X16;
	17:
		data_rs1 <= X17;
	18:
		data_rs1 <= X18;
	19:
		data_rs1 <= X19;
	20:
		data_rs1 <= X20;
	21:
		data_rs1 <= X21;
	22:
		data_rs1 <= X22;
	23:
		data_rs1 <= X23;
	24:
		data_rs1 <= X24;
	25:
		data_rs1 <= X25;
	26:
		data_rs1 <= X26;
	27:
		data_rs1 <= X27;
	28:
		data_rs1 <= X28;
	29:
		data_rs1 <= X29;
	30:
		data_rs1 <= X30;
	31:
		data_rs1 <= X31;
	endcase
end

always @ (posedge Clk)
begin
	case(rs2)
	0:
		data_rs2 <= 0;
	1:
		data_rs2 <= X1;
	2:
		data_rs2 <= X2;
	3:
		data_rs2 <= X3;
	4:
		data_rs2 <= X4;
	5:
		data_rs2 <= X5;
	6:
		data_rs2 <= X6;
	7:
		data_rs2 <= X7;
	8:
		data_rs2 <= X8;
	9:
		data_rs2 <= X9;
	10:
		data_rs2 <= X10;
	11:
		data_rs2 <= X11;
	12:
		data_rs2 <= X12;
	13:
		data_rs2 <= X13;
	14:
		data_rs2 <= X14;
	15:
		data_rs2 <= X15;
	16:
		data_rs2 <= X16;
	17:
		data_rs2 <= X17;
	18:
		data_rs2 <= X18;
	19:
		data_rs2 <= X19;
	20:
		data_rs2 <= X20;
	21:
		data_rs2 <= X21;
	22:
		data_rs2 <= X22;
	23:
		data_rs2 <= X23;
	24:
		data_rs2 <= X24;
	25:
		data_rs2 <= X25;
	26:
		data_rs2 <= X26;
	27:
		data_rs2 <= X27;
	28:
		data_rs2 <= X28;
	29:
		data_rs2 <= X29;
	30:
		data_rs2 <= X30;
	31:
		data_rs2 <= X31;
	endcase
end
////////////////////////////////////////////////////////////////////////////////
// always @ (posedge Clk)
// begin
	// if(X31==1)
		// Test <= 1;
	// else
		// Test <= 0;
// end
always @ (posedge Clk)
begin
	Test <= X31[0];
end

endmodule
