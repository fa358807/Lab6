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
	A,
	B,
	S,
	Cout,
	//add,
	clk,
	rst_n
    );
/*input*/
input [3:0]A;
input [3:0]B;
//input [1:0]add;
input clk;
input rst_n;
output [3:0]S;
output Cout;
	 
reg [4:0]Sum;
reg [4:0]s1;
reg [3:0]S;
reg Cout;


always@(posedge clk or negedge rst_n)
begin
	if(~rst_n)
	begin
		Cout<=1'b0;
		S <= 4'd0;
 	end
	else
	begin
		//if(add==2'd2)
		//begin
			Cout <= s1[4];
			S <= s1[3:0];
		//end
	end
end


always@(*)
begin
	s1 <= Sum;
	Sum <= A + B;
	if(Sum > 4'd9)
	begin
		s1 <= Sum + 4'd6;
	end
end

endmodule
