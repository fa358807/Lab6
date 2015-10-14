`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:42:11 09/01/2015 
// Design Name: 
// Module Name:    mux 
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
module mux(
pressed,
reg1,
reg2,
reg3,
S,
minus,
s1,
Cout,
out0,
out1,
out2,
out3,
p2,
p1
    );
	 
input [3:0]reg1,reg2,reg3,S,minus,s1,p2,p1;
input Cout,pressed;
output [3:0]out0,out1,out2,out3;
reg [3:0]out0,out1,out2,out3;


always @(*)
begin
	if(reg3==4'd10)
	begin
			out0=reg1;
			out1=reg2;
			out2=Cout;
			out3=S;
	end
	else if(reg3==4'd13)
	begin
			out0=reg1;
			out1=reg2;
			out2=minus;
			out3=s1;
	end
	else if(reg3==4'd11)
	begin
			out0=reg1;
			out1=reg2;
			out2=p2;
			out3=p1;
	end
	else
	begin
			out0=reg1;
			out1=reg2;
			out2=4'd0;
			out3=4'd0;
	end
end


	

endmodule
