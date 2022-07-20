module DummyRegisterFile8x16(A, B, SA, SB, D, DA, W, reset, clock, r0, r1, r2, r3, r4, r5, r6, r7);
	output [15:0]A; // A bus
	output [15:0]B; // B bus
	input [2:0]SA; // Select A - A Address
	input [2:0]SB; // Select B - B Address
	input [15:0]D; // Data input
	input [2:0]DA; // Data destination address
	input W; // write enable
	input reset; // positive logic asynchronous reset
	input clock;
	output [15:0] r0, r1, r2, r3, r4, r5, r6, r7; // outputs for visualization
	
	assign r0 = 16'd0;
	assign r1 = 16'd1;
	assign r2 = 16'd2;
	assign r3 = 16'd3;
	assign r4 = 16'd4;
	assign r5 = 16'd5;
	assign r6 = 16'd6;
	assign r7 = 16'd7;
	
endmodule
