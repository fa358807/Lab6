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
  flag,//output for debug
  state,//output for debug
  add,//decimal_adder add
  out_pulse,//output for debug
  en //output for debug
);
// Declare I/Os
input clk; // clock from crystal oscillator
input rst_n; // active low reset
input add;
input [`KEYPAD_ROW_WIDTH-1:0] col_n; // pressed column index
output flag;
output wire [1:0]state;
output [`KEYPAD_ROW_WIDTH-1:0] row_n;  // scanned row index
output [`FTSD_BIT_WIDTH-1:0] display; // 14-segment display
output [`KEYPAD_COL_WIDTH-1:0] col_out; // output for debug (column index)
output [`KEYPAD_ROW_WIDTH-1:0] row_out; // output for debig (row index)
output [`FTSD_NUM-1:0] ftsd_ctl; // 14-segment display scan control
output pressed; // whether keypad pressed (1) or not (0)
output out_pulse;
output [1:0]en;
// Declare internal nodes
wire pb_debounced; // push button debounced output
wire out_pulse;
wire clk_d; // divided clock
wire clk_debounce;
wire clk_l;// generated 1 Hz clock
wire clk_100; // generated 100 Hz clock
//wire [3:0] db_col;
wire [3:0] key; // pressed key
wire [1:0] ftsd_ctl_en;
wire [3:0] ftsd_in;
wire [3:0]keyA;
wire [3:0]keyB;
wire [3:0]S;
wire Cout;
wire [1:0]en;
wire led_1;
wire led_pb;
wire pressed;




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
  //.keyA(keyA), 
  //.keyB(keyB),
  .key(key),// returned pressed key
  .pressed(pressed),// whether key pressed (1) or not (0)
  .pressed_detected(pressed_detected)
);

// Scan control
scan_ctl U_SC(
  .in0(keyA), // 1st input
  .in1(keyB), // 2nd input
  .in2(Cout), // 3rd input
  .in3(S),  // 4th input
  .ftsd_ctl_en(ftsd_ctl_en), // divided clock for scan control
  .ftsd_ctl(ftsd_ctl), // ftsd display control signal
  .ftsd_in(ftsd_in) // output to ftsd display
);

ftsd U_D(
  .in(ftsd_in),  // binary input
  .display(display) // 14-segment display output
);

decimal_adder U_DA(
.A(keyA),
.B(keyB),
.S(S),
.Cout(Cout),
.add(en),
.clk(clk),
.rst_n(rst_n)
    );

debounce_circuit U_dc(
  .clk(clk_debounce), // clock control
  .rst_n(rst_n), // reset
  .pb_in(add), //push button input
  .pb_debounced(led_pb) // debounced push button output
);

one_pulse U_OP(
.clk(clk_debounce), // clock input
.rst_n(rst_n), //active low reset
.in_trig(led_pb), // input trigger
.out_pulse(out_pulse) // output one pulse
);

	 
fsm U_FS(
.count_enable(en), // if counter is enabled
.in(out_pulse), //input control
.clk(clk_debounce), // global clock signal
.state(state),
.rst_n(rst_n), // low active reset
.key(key),
.keyA(keyA),
.keyB(keyB),
.pressed(pressed)
);



endmodule
