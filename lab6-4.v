`timescale 1ns / 1ps
//************************************************************************
// Filename      : top.v
// Author        : Hsi-Pin Ma
// Function      : Top module for keypad scan example
// Last Modified : Date: 2012-04-02
// Revision      : Revision: 1
// Copyright (c), Laboratory for Reliable Computing (LaRC), EE, NTHU
// All rights reserved
//************************************************************************
`include "global.v"
module top(
  clk, // clock from crystal oscillator
  rst_n, // sctive low reset
  col_n, // pressed column index
  row_n, // scanned row index
  display, // 14-segment display
  col_out, // output for debug (column index)
  row_out, // output for debig (row index)
  ftsd_ctl, // 14-segment display scan control
  en,
  pressed // whether keypad pressed (1) or not (0)
);
// Declare I/Os
input clk; // clock from crystal oscillator
input rst_n; // active low reset
input [`KEYPAD_ROW_WIDTH-1:0] col_n; // pressed column index
output [`KEYPAD_ROW_WIDTH-1:0] row_n;  // scanned row index
output [`FTSD_BIT_WIDTH-1:0] display; // 14-segment display
output [`KEYPAD_COL_WIDTH-1:0] col_out; // output for debug (column index)
output [`KEYPAD_ROW_WIDTH-1:0] row_out; // output for debig (row index)
output [`FTSD_NUM-1:0] ftsd_ctl; // 14-segment display scan control
output pressed; // whether keypad pressed (1) or not (0)
output [1:0]en;

// Declare internal nodes
wire clk_d; // divided clock
wire clk_debounce;
//wire [3:0] db_col;
wire [3:0]p2,p1;
wire [3:0] key; // pressed key
wire [1:0] ftsd_ctl_en;
wire [3:0] ftsd_in;
wire [3:0]S;
wire [3:0]s1,minus;
wire [3:0]reg1,reg2,reg3,reg0;
wire [3:0]out0,out1,out2,out3;
wire [1:0]en,state;
wire Cout,out_pulse;

assign col_out = ~col_n;
assign row_out = ~row_n;

// Frequency divider
freqdiv U_F(
  .clk_40M(clk), // clock from the 40MHz oscillator
  .rst_n(rst_n), // low active reset
  .clk_1(clk_d), //divided clock output
  .clk_debounce(clk_debounce), // clock control for debounce circuit
  .clk_ftsd_scan(ftsd_ctl_en) // divided clock for 14-segment display scan
);

// Keypad scan
keypad_scan U_k(
  .clk(clk_debounce), // scan clock
  .rst_n(rst_n), // active low reset
  .col_n(col_n), // pressed column index
  .row_n(row_n), // scanned row index
  .key(key), // returned pressed key
  .pressed(pressed) // whether key pressed (1) or not (0)
);

// Scan control
scan_ctl U_SC(
  .in0(out0), // 1st input
  .in1(out1), // 2nd input
  .in2(out2), // 3rd input
  .in3(out3),  // 4th input
  .ftsd_ctl_en(ftsd_ctl_en), // divided clock for scan control
  .ftsd_ctl(ftsd_ctl), // ftsd display control signal
  .ftsd_in(ftsd_in) // output to ftsd display
);

ftsd U_D(
  .in(ftsd_in),  // binary input
  .display(display) // 14-segment display output
);

decimal_adder U_DA(
	.A(reg1),
	.B(reg2),
	.S(S),
	.Cout(Cout),
	//.add(),
	.clk(clk),
	.rst_n(rst_n)
    );

subtractor U_SUB(
//A2(),
//B2(),
.A1(reg1),
.B1(reg2),
//s2,
.s1(s1),
.minus(minus)
    );
	 
array_multiplier U_MULT(
.x(reg1),
.y(reg2),
.p1(p1),
.p2(p2)
    );

one_pulse U_OP(
.clk(clk_d), // clock input
.rst_n(rst_n), //active low reset
.in_trig(pressed), // input trigger
.out_pulse(out_pulse) // output one pulse
);

fsm U_FS(
.count_enable(en), // if counter is enabled
.in(out_pulse), //input control
.clk(clk_d), // global clock signal
.state(state),
.rst_n(rst_n), // low active reset
.key(key),
.pressed(pressed),
.reg0(reg0),
.reg1(reg1),
.reg2(reg2),
.reg3(reg3)
);


mux U_MUX(
.pressed(pressed),
.reg1(reg1),
.reg2(reg2),
.reg3(reg3),
.S(S),
.minus(minus),
.s1(s1),
.Cout(Cout),
.out0(out0),
.out1(out1),
.out2(out2),
.out3(out3),
.p2(p2),
.p1(p1)
    );

endmodule
