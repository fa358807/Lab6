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
`define s0 2'b00
`define s1 2'b01
`define s2 2'b10
`define s3 2'b11
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
pressed,
reg0,
reg1,
reg2,
reg3
);
// outputs
output [1:0]count_enable; // if counter is enabled
output [1:0]state;
output [3:0]keyA;
output [3:0]keyB;
output [3:0]reg0;
output [3:0]reg1;
output [3:0]reg2;
output [3:0]reg3;
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
reg [3:0]reg0;
reg [3:0]reg1;
reg [3:0]reg2;
reg [3:0]reg3;


// FSM state decision
always @(*)
	case (state)
		`s0:
		if (in)
		begin
			next_state = `s1;
			count_enable = 2'd1;
			//reg1=key;
		end
		else
		begin
			next_state = `s0;
			count_enable = 2'd0;
			//reg0=key;
		end
		`s1:
		if (in)
		begin
			next_state = `s2;
			count_enable = 2'd2;
			//reg2=key;
		end
		else
		begin
			next_state = `s1;
			count_enable = 2'd1;
			//reg1=key;
		end
		`s2:
		if (in)
		begin
			next_state = `s3;
			count_enable = 2'd3;
			//reg3=key;
		end
		else
		begin
			next_state = `s2;
			count_enable = 2'd2;
			//reg2=key;
		end
		`s3:
		if (in)
		begin
			next_state = `s0;
			count_enable = 2'd0;
			//reg0=key;
		end
		else
		begin
			next_state = `s3;
			count_enable = 2'd3;
			//reg3=key;
		end
		default:
		begin
			next_state = `s0;
			count_enable = 2'd0;
			//reg0=key;
		end
	endcase
	
// FSM state transition
always @(posedge clk or negedge rst_n)
	if (~rst_n)
		state <= `s0;
	else
		state <= next_state;
		

//flag mux
always @(posedge clk or negedge rst_n)
begin
		if(~rst_n)
		begin
			reg1<=4'd0;
			reg2<=4'd0;
			reg3<=4'd0;
			reg0<=4'd0;
		end
		else
		begin
			if(count_enable==2'd1 && pressed==1'd1)
			begin
				reg1 <= key;
			end
			if(count_enable==2'd2 && pressed==1'd1)
			begin
				reg2 <= key;
			end
			if(count_enable==2'd3 && pressed==1'd1)
			begin
				reg3 <= key;
			end
			if(count_enable==2'd0 && pressed==1'd1)
			begin
				reg0 <= key;
			end
		end
		
end
/*
//add_fsm
always @(*)
	case (state_add)
		1'd0:
		if (add)
		begin
			next_state_add = 1'd1;
			add_en = 1'd1;
		end
		else
		begin
			next_state_add = 1'd0;
			add_en = 1'd0;
		end
		1'd1:
		if (add)
		begin
			next_state_add = 1'd0;
			add_en = 1'd0;
		end
		else
		begin
			next_state_add = 1'd1;
			add_en = 1'd1;
		end
		default:
		begin
			next_state_add = 1'd0;
			add_en = 1'd0;
		end
	endcase
	
//sub_fsm
always @(*)
	case (state_sub)
		1'd0:
		if (sub)
		begin
			next_state_sub = 1'd1;
			sub_en = 1'd1;
		end
		else
		begin
			next_state_sub = 1'd0;
			sub_en = 1'd0;
		end
		1'd1:
		if (sub)
		begin
			next_state_sub = 1'd0;
			sub_en = 1'd0;
		end
		else 
		begin
			next_state_sub = 1'd1;
			sub_en = 1'd1;
		end
		default:
		begin
			next_state_sub = 1'd0;
			sub_en = 1'd0;
		end
	endcase

always @(posedge clk or negedge rst_n)
	if (~rst_n)
	begin
		state_add <= 1'd0;
		state_sub <= 1'd0;
	end
	else
	begin
		state_add <= next_state_add;
		state_sub <= next_state_sub;
	end
*/


endmodule
