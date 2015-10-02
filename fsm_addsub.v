`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:53:52 09/02/2015 
// Design Name: 
// Module Name:    fsm_addsub 
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
module fsm_addsub(
clk,
rst_n,
sub,
add,
sub_en,
add_en
    );
input sub,add;
input clk; // global clock signal
input rst_n; // low active reset
output add_en,sub_en;
reg state_add,next_state_add,add_en;
reg state_sub,next_state_sub,sub_en;
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

endmodule
