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
  pressed, // whether keypad pressed (1) or not (0)
  out_pulse,
  en,
  add,
  sub,
  add_en,
  sub_en
  //state
);
// Declare I/Os
input clk; // clock from crystal oscillator
input rst_n; // active low reset
input [`KEYPAD_ROW_WIDTH-1:0] col_n; // pressed column index
input add,sub;
output [`KEYPAD_ROW_WIDTH-1:0] row_n;  // scanned row index
output [`FTSD_BIT_WIDTH-1:0] display; // 14-segment display
output [`KEYPAD_COL_WIDTH-1:0] col_out; // output for debug (column index)
output [`KEYPAD_ROW_WIDTH-1:0] row_out; // output for debig (row index)
output [`FTSD_NUM-1:0] ftsd_ctl; // 14-segment display scan control
output pressed; // whether keypad pressed (1) or not (0)
output out_pulse;//output for debug (one_pulse index)
//output [1:0]state;
output [1:0]en;
output add_en,sub_en;

// Declare internal nodes
wire clk_d; // divided clock
wire clk_debounce;
//wire [3:0] db_col;
wire [3:0] key; // pressed key
wire [1:0] ftsd_ctl_en;
wire [3:0] ftsd_in;
wire pressed;// whether key_detected pressed_detected (1) or not (0)
wire out_pulse;//output for debug (one_pulse index)
wire [1:0]state;
wire [1:0]en;
wire [3:0]reg0;
wire [3:0]reg1;
wire [3:0]reg2;
wire [3:0]reg3;
wire [3:0]out0;
wire [3:0]out1;
wire [3:0]out2;
wire [3:0]out3;
wire [3:0]s1,s2;
wire C2;
wire [3:0]sub_s2,sub_s1,minus;
wire add_en,sub_en,out_sub,out_add;

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

one_pulse U_OP(
.clk(clk_d), // clock input
.rst_n(rst_n), //active low reset
.in_trig(pressed), // input trigger
.out_pulse(out_pulse) // output one pulse
);

addone_pulse U_OPAD(
.clk(clk_debounce), // clock input
.rst_n(rst_n), //active low reset
.in_trig(add), // input trigger
.out_pulse(out_add) // output one pulse
);

subone_pulse U_OPSUB(
.clk(clk_debounce), // clock input
.rst_n(rst_n), //active low reset
.in_trig(sub), // input trigger
.out_pulse(out_sub) // output one pulse
);

fsm U_FS(
.count_enable(en), // if counter is enabled
.in(out_pulse), //input control
.clk(clk_d), // global clock signal
.state(state),
.rst_n(rst_n), // low active reset
.key(key),
//keyA,
//keyB,
.pressed(pressed),
.reg0(reg0),
.reg1(reg1),
.reg2(reg2),
.reg3(reg3)
);

fsm_addsub U_FSMADDSUB(
.clk(clk_debounce),
.rst_n(rst_n),
.add_en(add_en),
.sub_en(sub_en),
.add(out_add),
.sub(out_sub)
    );


decimal_adder U_DA(
	.A1(reg1),
	.B1(reg3),
	.A2(reg0),
	.B2(reg2),
	.s1(s1),
	.s2(s2),
	.C2(C2),
	.add(add),
	.clk(clk),
	.rst_n(rst_n)
    );

subtractor U_SUB(
.A2(reg0),
.B2(reg2),
.A1(reg1),
.B1(reg3),
.s2(sub_s2),
.s1(sub_s1),
.minus(minus)
);

mux U_M(
.reg0(reg0),
.reg1(reg1),
.reg2(reg2),
.reg3(reg3),
.s1(s1),
.s2(s2),
.C2(C2),
.sub_s2(sub_s2),
.sub_s1(sub_s1),
.minus(minus),
.out0(out0),
.out1(out1),
.out2(out2),
.out3(out3),
.add_en(add_en),
.sub_en(sub_en)
);

endmodule
