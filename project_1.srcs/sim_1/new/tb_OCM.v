`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/01/23 17:35:05
// Design Name: 
// Module Name: tb_OCM
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


module tb_OCM(
    );

parameter CLK_PERIOD = 10;

reg Clk=0;

reg [15:0] waddr=0;
reg [31:0] wdata=0;
reg wr_byte=0;
reg wr_halfword=0;
reg wr_word=0;

reg [15:0] raddr=0;
wire [31:0] rdata;

always 
begin
	Clk = 1'b0;
	#(CLK_PERIOD/2) Clk = 1'b1;
	#(CLK_PERIOD/2);
end
	
OCM OCM_inst(
/*    input 			*/.Clk(Clk),
	
/*	input		[15:0]	*/.waddr(waddr),
/*	input		[31:0] 	*/.wdata(wdata),
/*	input 				*/.wr_byte(wr_byte),
/*	input 				*/.wr_halfword(wr_halfword),
/*	input 				*/.wr_word(wr_word),
	
/*	input		[15:0]	*/.raddr(raddr),
/*	output	reg	[31:0] 	*/.rdata(rdata)
    );

initial
begin
	#(CLK_PERIOD*10)
		waddr <= 16'h0004;
		wdata <= 32'h12345678;
		wr_word <= 1;
	#(CLK_PERIOD*1)
		wr_word <= 0;
		
	#(CLK_PERIOD*10)
		raddr <= 16'h0004;
	#(CLK_PERIOD*1)
		raddr <= 16'h0007;
	#(CLK_PERIOD*1)
		raddr <= 16'h0000;		
		
end
	
endmodule
