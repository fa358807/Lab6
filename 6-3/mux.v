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
reg0,
reg1,
reg2,
reg3,
s1,
s2,
C2,
sub_s2,
sub_s1,
minus,
out0,
out1,
out2,
out3,
add_en,
sub_en
    );
	 
input [3:0]reg0,reg1,reg2,reg3,s1,s2,sub_s2,sub_s1,minus;
input C2,add_en,sub_en;
output [3:0]out0,out1,out2,out3;
reg [3:0]out0,out1,out2,out3;


always @(*)
begin
	if(add_en==1'd0 && sub_en==1'd1)
	begin
			out0=4'd0;
			out1=C2;
			out2=s2;
			out3=s1;
	end
	else if(sub_en==1'd0 && add_en==1'd1)
	begin
			out0=4'd0;
			out1=minus;
			out2=sub_s2;
			out3=sub_s1;
	end
	else
	begin
			out0=reg0;
			out1=reg1;
			out2=reg2;
			out3=reg3;
	end
end


	

endmodule
