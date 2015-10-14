`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:18:40 09/09/2015 
// Design Name: 
// Module Name:    array_multiplier 
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
module array_multiplier(
x,
y,
p1,
p2
    );

input [3:0]x,y;
output [3:0]p1,p2;
reg [3:0]p1,p2;
wire [3:0]c1,c2,c3;
wire [3:0]s1,s2,s3;
wire [3:0]xy0,xy1,xy2,xy3;
wire [7:0]p;

and u0(xy0[0],x[0],y[0]);
and u1(xy0[1],x[1],y[0]);
and u2(xy0[2],x[2],y[0]);
and u3(xy0[3],x[3],y[0]);

and a0(xy1[0],x[0],y[1]);
and a1(xy1[1],x[1],y[1]);
and a2(xy1[2],x[2],y[1]);
and a3(xy1[3],x[3],y[1]);

and b0(xy2[0],x[0],y[2]);
and b1(xy2[1],x[1],y[2]);
and b2(xy2[2],x[2],y[2]);
and b3(xy2[3],x[3],y[2]);

and d0(xy3[0],x[0],y[3]);
and d1(xy3[1],x[1],y[3]);
and d2(xy3[2],x[2],y[3]);
and d3(xy3[3],x[3],y[3]);

FA fa1(.x(xy0[2]),.y(xy1[1]),.cin(c1[0]),.s(s1[1]),.cout(c1[1]));
FA fa2(.x(xy0[3]),.y(xy1[2]),.cin(c1[1]),.s(s1[2]),.cout(c1[2]));
FA fa3(.x(s1[2]),.y(xy2[1]),.cin(c2[0]),.s(s2[1]),.cout(c2[1]));
FA fa4(.x(s1[3]),.y(xy2[2]),.cin(c2[1]),.s(s2[2]),.cout(c2[2]));
FA fa5(.x(c1[3]),.y(xy2[3]),.cin(c2[2]),.s(s2[3]),.cout(c2[3]));
FA fa6(.x(s2[2]),.y(xy3[1]),.cin(c3[0]),.s(s3[1]),.cout(c3[1]));
FA fa7(.x(s2[3]),.y(xy3[2]),.cin(c3[1]),.s(s3[2]),.cout(c3[2]));
FA fa8(.x(c2[3]),.y(xy3[3]),.cin(c3[2]),.s(s3[3]),.cout(c3[3]));
FA hfa1(.x(xy0[1]),.y(xy1[0]),.s(s1[0]),.cout(c1[0]));
FA hfa2(.x(xy1[3]),.y(c1[2]),.s(s1[3]),.cout(c1[3]));
FA hfa3(.x(s1[1]),.y(xy2[0]),.s(s2[0]),.cout(c2[0]));
FA hfa4(.x(s2[1]),.y(xy3[0]),.s(s3[0]),.cout(c3[0]));

assign		p[0]=xy0[0];
assign		p[1]=s1[0];
assign		p[2]=s2[0];
assign		p[3]=s3[0];
assign		p[4]=s3[1];
assign		p[5]=s3[2];
assign		p[6]=s3[3];
assign		p[7]=c3[3];

always@*
begin
 p2=p/4'd10;
 p1=p%4'd10;
end

	


endmodule
