`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:31:06 07/27/2015 
// Design Name: 
// Module Name:    FA 
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
module FA(x,y,cin,s,cout);
	 input x;
    input y;
    input cin;
    output s;
    output cout;
	 
	 assign s=(x&(~y)&(~cin))+((~x)&(~y)&cin)+(x&y&cin)+((~x)&y&(~cin));
	 assign cout=(x&y)+(x&cin)+(y&cin);


endmodule
