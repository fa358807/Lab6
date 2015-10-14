`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:55:30 08/25/2015 
// Design Name: 
// Module Name:    decimal_adder 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module decimal_adder(
	A1,
	B1,
	A2,
	B2,
	s1,
	s2,
	C2,
	add,
	clk,
	rst_n
    );
/*input*/
input [3:0]A1;
input [3:0]B1;
input [3:0]A2;
input [3:0]B2;
input add;
input clk;
input rst_n;
//input Cin;
/*output*/
output [3:0]s1;
output [3:0]s2;
//output C1;
output C2;
	 
reg [4:0]Sum1;
reg [4:0]Sum2;
reg [4:0]S1;
reg [4:0]S2;
reg [3:0]s1;
reg [3:0]s2;
reg C1;
reg C2;

//1-digit adder
always@(*)
begin
	S1 <= Sum1;
	Sum1 <= A1 + B1;
	S2 <= Sum2;
	Sum2 <= A2 + B2 + C1;
	if(Sum1 > 4'd9)
	begin
		S1 <= Sum1 + 4'd6;
	end
	if(Sum2 > 4'd9)
	begin
		S2 <= Sum2 + 4'd6;
	end
end

always@(posedge clk or negedge rst_n)
begin
	if(~rst_n)
	begin
		C1<=1'b0;
		C2<=1'b0;
		s1 <= 4'd0;
		s2 <= 4'd0;
 	end
	else
	begin
		if(add==1'b0)
		begin
			C1 <= S1[4];
			s1 <= S1[3:0];
			C2 <= S2[4];
			s2 <= S2[3:0];
		end
	end
end




endmodule
