`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/01/22 22:36:37
// Design Name: 
// Module Name: OCM
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


module OCM(
    input 				Clk,
	
	input		[15:0]	waddr,
	input		[31:0] 	wdata,
	input 				wr_byte,
	input 				wr_halfword,
	input 				wr_word,
	
	input		[15:0]	raddr,
	output	reg	[31:0] 	rdata
    );

reg wea0;
reg wea1;
reg wea2;
reg wea3;
reg [13:0] addra0;
reg [13:0] addra1;
reg [13:0] addra2;
reg [13:0] addra3;
reg [7:0] wdata0;
reg [7:0] wdata1;
reg [7:0] wdata2;
reg [7:0] wdata3;

reg [13:0] addrb0;
reg [13:0] addrb1;
reg [13:0] addrb2;
reg [13:0] addrb3;

wire [7:0] doutb0;
wire [7:0] doutb1;
wire [7:0] doutb2;
wire [7:0] doutb3;

reg [1:0] raddr10_1;

//LSB	
CPU_Ram CPU_Ram_inst0 (
	.clka(Clk), 	// input wire clka
	.wea(wea0),     // input wire [0 : 0] wea
	.addra(addra0), // input wire [13 : 0] addra
	.dina(wdata0),  // input wire [7 : 0] dina
	.clkb(Clk), 	// input wire clkb
	.addrb(addrb0), // input wire [13 : 0] addrb
	.doutb(doutb0)  // output wire [7 : 0] doutb
);
	
CPU_Ram CPU_Ram_inst1 (
	.clka(Clk), 	// input wire clka
	.wea(wea1),     // input wire [0 : 0] wea
	.addra(addra1), // input wire [13 : 0] addra
	.dina(wdata1),  // input wire [7 : 0] dina
	.clkb(Clk), 	// input wire clkb
	.addrb(addrb1), // input wire [13 : 0] addrb
	.doutb(doutb1)  // output wire [7 : 0] doutb
);
	
CPU_Ram CPU_Ram_inst2 (
	.clka(Clk), 	// input wire clka
	.wea(wea2),     // input wire [0 : 0] wea
	.addra(addra2),	// input wire [13 : 0] addra
	.dina(wdata2),  // input wire [7 : 0] dina
	.clkb(Clk), 	// input wire clkb
	.addrb(addrb2), // input wire [13 : 0] addrb
	.doutb(doutb2)  // output wire [7 : 0] doutb
);

//MSB	
CPU_Ram CPU_Ram_inst3 (
	.clka(Clk), 	// input wire clka
	.wea(wea3),     // input wire [0 : 0] wea
	.addra(addra3), // input wire [13 : 0] addra
	.dina(wdata3),  // input wire [7 : 0] dina
	.clkb(Clk), 	// input wire clkb
	.addrb(addrb3), // input wire [13 : 0] addrb
	.doutb(doutb3)  // output wire [7 : 0] doutb
);

////////////////////////
//wr
always @ (*)
begin
	if((wr_byte&&(waddr[1:0]==2'b00))||
	   (wr_halfword&&((waddr[1:0]==2'b11)||(waddr[1:0]==2'b00)))||
	   wr_word)
		wea0 = 1'b1;
	else
		wea0 = 1'b0;
end

always @ (*)
begin
	if((wr_byte&&(waddr[1:0]==2'b01))||
	   (wr_halfword&&((waddr[1:0]==2'b00)||(waddr[1:0]==2'b01)))||
	   wr_word)
		wea1 = 1'b1;
	else
		wea1 = 1'b0;
end

always @ (*)
begin
	if((wr_byte&&(waddr[1:0]==2'b10))||
	   (wr_halfword&&((waddr[1:0]==2'b01)||(waddr[1:0]==2'b10)))||
	   wr_word)
		wea2 = 1'b1;
	else
		wea2 = 1'b0;
end

always @ (*)
begin
	if((wr_byte&&(waddr[1:0]==2'b11))||
	   (wr_halfword&&((waddr[1:0]==2'b10)||(waddr[1:0]==2'b11)))||
	   wr_word)
		wea3 = 1'b1;
	else
		wea3 = 1'b0;
end

//////////////////////////
//waddr
always @ (*)
begin
	if(wr_byte)
		addra0 = waddr[15:2];
	else if(wr_halfword)
	begin
		if(waddr[1:0]==2'b11)
			addra0 = waddr[15:2] + 1'b1;
		else	
			addra0 = waddr[15:2];
	end
	else	//wr_word
	begin
		case(waddr[1:0])
		2'b00:
			addra0 = waddr[15:2];
		2'b01:	
			addra0 = waddr[15:2] + 1'b1;
		2'b10:	
			addra0 = waddr[15:2] + 1'b1;
		2'b11:	
			addra0 = waddr[15:2] + 1'b1;
		endcase
	end
	
end

always @ (*)
begin
	if(wr_byte)
		addra1 = waddr[15:2];
	else if(wr_halfword)
		addra1 = waddr[15:2];
	else	//wr_word
	begin
		case(waddr[1:0])
		2'b00:
			addra1 = waddr[15:2];
		2'b01:	
			addra1 = waddr[15:2];
		2'b10:	
			addra1 = waddr[15:2] + 1'b1;
		2'b11:	
			addra1 = waddr[15:2] + 1'b1;
		endcase
	end
end

always @ (*)
begin
	if(wr_byte)
		addra2 = waddr[15:2];
	else if(wr_halfword)
		addra2 = waddr[15:2];
	else	//wr_word
	begin
		case(waddr[1:0])
		2'b00:
			addra2 = waddr[15:2];
		2'b01:	
			addra2 = waddr[15:2];
		2'b10:	
			addra2 = waddr[15:2];
		2'b11:	
			addra2 = waddr[15:2] + 1'b1;
		endcase
	end
end

always @ (*)
begin
	addra3 = waddr[15:2];
end

//////////////////////////////
//wdata	
always @ (*)
begin
	if(wr_byte)
		wdata0 = wdata[7:0];
	else if(wr_halfword)
	begin
		case(waddr[1:0])
		2'b00:
			wdata0 = wdata[7:0];
		2'b01:	
			wdata0 = wdata[7:0];
		2'b10:	
			wdata0 = wdata[7:0];
		2'b11:	
			wdata0 = wdata[15:8];
		endcase			
			
	end
	else	//word
	begin
		case(waddr[1:0])
		2'b00:
			wdata0 = wdata[7:0];
		2'b01:	
			wdata0 = wdata[31:24];
		2'b10:	
			wdata0 = wdata[23:16];
		2'b11:	
			wdata0 = wdata[15:8];
		endcase
	end
end

always @ (*)
begin
	if(wr_byte)
		wdata1 = wdata[7:0];
	else if(wr_halfword)
	begin
		case(waddr[1:0])
		2'b00:
			wdata1 = wdata[15:8];
		2'b01:	
			wdata1 = wdata[7:0];
		2'b10:	
			wdata1 = wdata[7:0];
		2'b11:	
			wdata1 = wdata[7:0];
		endcase
	end
	else	//word
	begin
		case(waddr[1:0])
		2'b00:
			wdata1 = wdata[15:8];
		2'b01:	
			wdata1 = wdata[7:0];
		2'b10:	
			wdata1 = wdata[31:24];
		2'b11:	
			wdata1 = wdata[23:16];
		endcase
	end
end

always @ (*)
begin
	if(wr_byte)
		wdata2 = wdata[7:0];
	else if(wr_halfword)
	begin
		case(waddr[1:0])
		2'b00:
			wdata2 = wdata[7:0];
		2'b01:	
			wdata2 = wdata[15:8];
		2'b10:	
			wdata2 = wdata[7:0];
		2'b11:	
			wdata2 = wdata[7:0];
		endcase
	end
	else	//word
	begin
		case(waddr[1:0])
		2'b00:
			wdata2 = wdata[23:16];
		2'b01:	
			wdata2 = wdata[15:8];
		2'b10:	
			wdata2 = wdata[7:0];
		2'b11:	
			wdata2 = wdata[31:24];
		endcase
	end
end

always @ (*)
begin
	if(wr_byte)
		wdata3 = wdata[7:0];
	else if(wr_halfword)
	begin
		case(waddr[1:0])
		2'b00:
			wdata3 = wdata[7:0];
		2'b01:	
			wdata3 = wdata[7:0];
		2'b10:	
			wdata3 = wdata[15:8];
		2'b11:	
			wdata3 = wdata[7:0];
		endcase
	end
	else	//word
	begin
		case(waddr[1:0])
		2'b00:
			wdata3 = wdata[31:24];
		2'b01:	
			wdata3 = wdata[23:16];
		2'b10:	
			wdata3 = wdata[15:8];
		2'b11:	
			wdata3 = wdata[7:0];
		endcase
	end
end

///////////////////////////////////////////////////////////////////////
//raddr
always @ (*)
begin
	case(raddr[1:0])
	2'b00:
	begin
		addrb0 = raddr[15:2];
		addrb1 = raddr[15:2];
		addrb2 = raddr[15:2];
		addrb3 = raddr[15:2];
	end
	
	2'b01:
	begin
		addrb0 = raddr[15:2] + 1'b1;
		addrb1 = raddr[15:2];
		addrb2 = raddr[15:2];
		addrb3 = raddr[15:2];
	end
	
	2'b10:
	begin
		addrb0 = raddr[15:2] + 1'b1;
		addrb1 = raddr[15:2] + 1'b1;
		addrb2 = raddr[15:2];
		addrb3 = raddr[15:2];
	end
	
	2'b11:
	begin
		addrb0 = raddr[15:2] + 1'b1;
		addrb1 = raddr[15:2] + 1'b1;
		addrb2 = raddr[15:2] + 1'b1;
		addrb3 = raddr[15:2];
	end
	endcase
end

///////////////////////////////////////////////////////////////////////
//rdata
always @ (posedge Clk)
begin
	raddr10_1 <= raddr[1:0];
end

always @ (*)
begin
	case(raddr10_1[1:0])
	2'b00:
	begin
		rdata[31:24] = doutb3;
		rdata[23:16] = doutb2;
		rdata[15:8] = doutb1;
		rdata[7:0] = doutb0;
	end
	
	2'b01:
	begin
		rdata[31:24] = doutb0;
		rdata[23:16] = doutb3;
		rdata[15:8] = doutb2;
		rdata[7:0] = doutb1;
	end
	
	2'b10:
	begin
		rdata[31:24] = doutb1;
		rdata[23:16] = doutb0;
		rdata[15:8] = doutb3;
		rdata[7:0] = doutb2;
	end
	
	2'b11:
	begin
		rdata[31:24] = doutb2;
		rdata[23:16] = doutb1;
		rdata[15:8] = doutb0;
		rdata[7:0] = doutb3;
	end
	endcase
end

endmodule
