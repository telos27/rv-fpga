`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/02/12 10:37:39
// Design Name: 
// Module Name: CSR
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

//Read Latency = 1
module CSR(
    input 				Clk,
	input 				sRst,	//synchronous reset
	input		[11:0]	csr_index,
	input		[31:0]	csr_wdata,
	input				csr_wr,
	input				csr_setbit,
	input				csr_clrbit,
	output	reg	[31:0]	csr_rdata
    );

localparam INDEX_MSTATUS 	= 12'h300;
localparam INDEX_MISA 		= 12'h301;
localparam INDEX_MIE 		= 12'h304;
localparam INDEX_MTVEC 		= 12'h305;
localparam INDEX_MSCRATCH 	= 12'h340;
localparam INDEX_MEPC 		= 12'h341;
localparam INDEX_MCAUSE 	= 12'h342;
localparam INDEX_MTVAL 		= 12'h343;
localparam INDEX_MIP 		= 12'h344;
localparam INDEX_MVENDORID 	= 12'hF11;
	
reg [31:0] mstatus=0;
reg [31:0] misa=0;
reg [31:0] mie=0;
reg [31:0] mtvec=0;
reg [31:0] mscratch=0;
reg [31:0] mepc=0;
reg [31:0] mcause=0;
reg [31:0] mtval=0;
reg [31:0] mip=0;
reg [31:0] mvendorid=0;

reg En_mstatus;
reg En_misa;
reg En_mie;
reg En_mtvec;
reg En_mscratch;
reg En_mepc;
reg En_mcause;
reg En_mtval;
reg En_mip;
reg En_mvendorid;

always @ (*)
begin
	if(csr_index == INDEX_MSTATUS)
		En_mstatus <= 1'b1;
	else
		En_mstatus <= 1'b0;
		
	if(csr_index == INDEX_MISA)
		En_misa <= 1'b1;
	else
		En_misa <= 1'b0;
		
	if(csr_index == INDEX_MIE)
		En_mie <= 1'b1;
	else
		En_mie <= 1'b0;
		
	if(csr_index == INDEX_MTVEC)
		En_mtvec <= 1'b1;
	else
		En_mtvec <= 1'b0;
		
	if(csr_index == INDEX_MSCRATCH)
		En_mscratch <= 1'b1;
	else
		En_mscratch <= 1'b0;
		
	if(csr_index == INDEX_MEPC)
		En_mepc <= 1'b1;
	else
		En_mepc <= 1'b0;
		
	if(csr_index == INDEX_MCAUSE)
		En_mcause <= 1'b1;
	else
		En_mcause <= 1'b0;
		
	if(csr_index == INDEX_MTVAL)
		En_mtval <= 1'b1;
	else
		En_mtval <= 1'b0;
		
	if(csr_index == INDEX_MIP)
		En_mip <= 1'b1;
	else
		En_mip <= 1'b0;
		
	if(csr_index == INDEX_MVENDORID)
		En_mvendorid <= 1'b1;
	else
		En_mvendorid <= 1'b0;
end

// read
always @ (posedge Clk)
begin
	if(En_mstatus)
		csr_rdata <= mstatus;
	else if(En_misa)
		csr_rdata <= misa;
	else if(En_mie)
		csr_rdata <= mie;
	else if(En_mtvec)
		csr_rdata <= mtvec;
	else if(En_mscratch)
		csr_rdata <= mscratch;
	else if(En_mepc)
		csr_rdata <= mepc;
	else if(En_mcause)
		csr_rdata <= mcause;
	else if(En_mtval)
		csr_rdata <= mtval;
	else if(En_mip)
		csr_rdata <= mip;
	else
		csr_rdata <= mvendorid;
end

//write
always @ (posedge Clk)
begin
	if(sRst)
		mstatus <= 0;
	else
	begin
		if(En_mstatus)
		begin
			if(csr_wr)
				mstatus <= csr_wdata;
			else if(csr_setbit)
				mstatus <= mstatus | csr_wdata;
			else if(csr_clrbit)
				mstatus <= mstatus & (~csr_wdata);
			else
				mstatus <= mstatus;
		end
		else
			mstatus <= mstatus;
	end
end

always @ (posedge Clk)
begin
	if(sRst)
		misa <= 0;
	else
	begin
		if(En_misa)
		begin
			if(csr_wr)
				misa <= csr_wdata;
			else if(csr_setbit)
				misa <= misa | csr_wdata;
			else if(csr_clrbit)
				misa <= misa & (~csr_wdata);
			else
				misa <= misa;
		end
		else
			misa <= misa;
	end
end

always @ (posedge Clk)
begin
	if(sRst)
		mie <= 0;
	else
	begin
		if(En_mie)
		begin
			if(csr_wr)
				mie <= csr_wdata;
			else if(csr_setbit)
				mie <= mie | csr_wdata;
			else if(csr_clrbit)
				mie <= mie & (~csr_wdata);
			else
				mie <= mie;
		end
		else
			mie <= mie;
	end
end

always @ (posedge Clk)
begin
	if(sRst)
		mtvec <= 0;
	else
	begin
		if(En_mtvec)
		begin
			if(csr_wr)
				mtvec <= csr_wdata;
			else if(csr_setbit)
				mtvec <= mtvec | csr_wdata;
			else if(csr_clrbit)
				mtvec <= mtvec & (~csr_wdata);
			else
				mtvec <= mtvec;
		end
		else
			mtvec <= mtvec;
	end
end

always @ (posedge Clk)
begin
	if(sRst)
		mscratch <= 0;
	else
	begin
		if(En_mscratch)
		begin
			if(csr_wr)
				mscratch <= csr_wdata;
			else if(csr_setbit)
				mscratch <= mscratch | csr_wdata;
			else if(csr_clrbit)
				mscratch <= mscratch & (~csr_wdata);
			else
				mscratch <= mscratch;
		end
		else
			mscratch <= mscratch;
	end
end

always @ (posedge Clk)
begin
	if(sRst)
		mepc <= 0;
	else
	begin
		if(En_mepc)
		begin
			if(csr_wr)
				mepc <= csr_wdata;
			else if(csr_setbit)
				mepc <= mepc | csr_wdata;
			else if(csr_clrbit)
				mepc <= mepc & (~csr_wdata);
			else
				mepc <= mepc;
		end
		else
			mepc <= mepc;
	end
end

always @ (posedge Clk)
begin
	if(sRst)
		mcause <= 0;
	else
	begin
		if(En_mcause)
		begin
			if(csr_wr)
				mcause <= csr_wdata;
			else if(csr_setbit)
				mcause <= mcause | csr_wdata;
			else if(csr_clrbit)
				mcause <= mcause & (~csr_wdata);
			else
				mcause <= mcause;
		end
		else
			mcause <= mcause;
	end
end

always @ (posedge Clk)
begin
	if(sRst)
		mtval <= 0;
	else
	begin
		if(En_mtval)
		begin
			if(csr_wr)
				mtval <= csr_wdata;
			else if(csr_setbit)
				mtval <= mtval | csr_wdata;
			else if(csr_clrbit)
				mtval <= mtval & (~csr_wdata);
			else
				mtval <= mtval;
		end
		else
			mtval <= mtval;
	end
end

always @ (posedge Clk)
begin
	if(sRst)
		mip <= 0;
	else
	begin
		if(En_mip)
		begin
			if(csr_wr)
				mip <= csr_wdata;
			else if(csr_setbit)
				mip <= mip | csr_wdata;
			else if(csr_clrbit)
				mip <= mip & (~csr_wdata);
			else
				mip <= mip;
		end
		else
			mip <= mip;
	end
end

always @ (posedge Clk)
begin
	if(sRst)
		mvendorid <= 0;
	else
	begin
		if(En_mvendorid)
		begin
			if(csr_wr)
				mvendorid <= csr_wdata;
			else if(csr_setbit)
				mvendorid <= mvendorid | csr_wdata;
			else if(csr_clrbit)
				mvendorid <= mvendorid & (~csr_wdata);
			else
				mvendorid <= mvendorid;
		end
		else
			mvendorid <= mvendorid;
	end
end

endmodule
