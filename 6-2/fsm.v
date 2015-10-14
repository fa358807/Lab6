`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:16:22 08/23/2015 
// Design Name: 
// Module Name:    fsm 
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
`define STAT_DEF 2'b00
`define STAT_COUNT 2'b01
`define STAT_PAUSE 2'b10
`define ENABLED 1
`define DISABLED 0
module fsm(
count_enable, // if counter is enabled
in, //input control
clk, // global clock signal
state,
rst_n, // low active reset
key,
keyA,
keyB,
pressed
);
// outputs
output [1:0]count_enable; // if counter is enabled
output [1:0]state;
output [3:0]keyA;
output [3:0]keyB;
// inputs
input pressed;
input clk; // global clock signal
input rst_n; // low active reset
input in; //input control
input [3:0]key;
reg [1:0]count_enable; // if counter is enabled
reg [1:0]state; // state of FSM
reg [1:0]next_state; // next state of FSM
//reg [3:0]key;
reg [3:0]keyA;
reg [3:0]keyB;
reg [3:0]keyA_next;
reg [3:0]keyB_next;

// FSM state decision
always @(*)
	case (state)
		`STAT_DEF:
		if (in)
		begin
			next_state = `STAT_COUNT;
			count_enable = 2'd1;
		end
		else
		begin
			next_state = `STAT_DEF;
			count_enable = 2'd0;
		end
		`STAT_COUNT:
		if (in)
		begin
			next_state = `STAT_PAUSE;
			count_enable = 2'd2;
		end
		else
		begin
			next_state = `STAT_COUNT;
			count_enable = 2'd1;
		end
		`STAT_PAUSE:
		if (in)
		begin
			next_state = `STAT_DEF;
			count_enable = 2'd0;
		end
		else
		begin
			next_state = `STAT_PAUSE;
			count_enable = 2'd2;
		end
		default:
		begin
			next_state = `STAT_DEF;
			count_enable = 2'd0;
		end
	endcase
	
// FSM state transition
always @(posedge clk or negedge rst_n)
	if (~rst_n)
		state <= `STAT_DEF;
	else
		state <= next_state;
		

//flag mux
always @(*)
begin
		if(count_enable==2'd0 && pressed==1'd1)
		begin
			keyA_next <= key;
		end
		if(count_enable==2'd1 && pressed==1'd1)
		begin
			keyB_next <= key;
		end
		if(~rst_n)
		begin
			keyA_next<=4'd0;
			keyB_next<=4'd0;
		end
end

//sequential circuit
always @(posedge clk or negedge rst_n)
begin
	if(~rst_n)
	begin
		keyA <= 4'b0;
		keyB <= 4'b0;
	end
	else
	begin
		keyA <= keyA_next;
		keyB <= keyB_next;
	end
end

endmodule
