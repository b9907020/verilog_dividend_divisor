/////////////////////////////////////////////////////////
// result = dividend / divisor
//
// If input bus width is 32 bits, clk needs 2^32 cycles
// inputing data while enable = 0
// Calculating while enable = 1
// Keeping result while enable = 0 
// This source code is proveded by kuiliang 2017/10/17
///////////////////////////////////////////////////////

`timescale 1ns/1ps
module divdiv ( dividend, divisor, clk, rstn, enable, result);

input	[31:0] dividend;
input	[31:0] divisor;
input	clk;
input	rstn;
input	enable;
output	[31:0]result;



reg [31:0]temp, counter, result_pre;

always@(posedge clk or negedge rstn)
begin
	if (!rstn) 
		temp <= #2 32'd0;
	else if (enable && (temp => divisor) )
		temp <= #2 temp - divisor;
	else if (enable)
		temp <= #2 temp;
	else
		temp <= #2 dividend;
end

always@(posedge clk or negedge rstn)
begin
	if (!rstn) 
		counter <= #2 32'd0;
	else if (enable && (temp => divisor) )
		counter <= #2 counter + 32'd1;
	else if (enable)
		counter <= #2 counter;
	else
		counter <= #2 32'd0;
end

always@(posedge clk or negedge rstn)
begin
	if (!rstn) 
		result_pre <= #2 32'd0;
	else if ( enable )
		result_pre <= #2 counter;
	else 
		result_pre <= #2 result_pre;
end

assign result = result_pre;

endmodule
