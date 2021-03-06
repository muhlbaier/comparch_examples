module RegisterNbit(Q, D, L, R, clock);
	parameter N = 8; // number of bits
	output reg [N-1:0]Q; // registered output
	input [N-1:0]D; // data input
	input L; // load enable
	input R; // positive logic asynchronous reset
	input clock; // positive edge clock
	parameter RESET_VALUE = 64'b0;
	
	always @(posedge clock or posedge R) begin
		if(R)
			Q <= RESET_VALUE[N-1:0];
		else if(L)
			Q <= D;
		else
			Q <= Q;
	end
endmodule
