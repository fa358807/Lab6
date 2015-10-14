`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:38:45 09/02/2015 
// Design Name: 
// Module Name:    subtractor 
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
module subtractor(
A2,
B2,
A1,
B1,
s2,
s1,
minus

    );

input [3:0]A2,A1,B2,B1;
output [3:0]s2,s1,minus;


reg [3:0]s2,s1,minus;


always@*
begin
	if(A2>B2 && A1>B1)
	begin
		minus=4'd0;
		s2 = A2 - B2;
		s1 = A1 - B1;
	end
	else if(A2>B2 && A1<B1)
	begin
		minus=4'd0;
		s2 = A2-B2-4'd1;
		s1 =4'd10-B1+A1;
	end
	else if(A2<B2 && A1>B1)
	begin
		minus=4'd10;
		s2=B2-A2-4'd1;
		s1=4'd10-A1+B1;
	end
	else if(A2<B2 && A1<B1)
	begin
		minus=4'd10;
		s2=B2-A2;
		s1=B1-A1;
	end
	else if(A2==B2 && A1>B1)
	begin
		minus=4'd0;
		s2 = A2 - B2;
		s1 = A1 - B1;
	end
	else if(A2==B2 && A1<B1)
	begin
		minus=4'd10;
		s2=B2-A2;
		s1=B1-A1;
	end
	else if(A2>B2 && A1==B1)
	begin
		minus=4'd0;
		s2 = A2 - B2;
		s1 = A1 - B1;
	end
	else if(A2<B2 && A1==B1)
	begin
		minus=4'd10;
		s2=B2-A2;
		s1=B1-A1;
	end
end

endmodule
