module DummyALU_bit (S, A, B, F, C_in, A_from_next_bit, C_out);
	input [4:0]S;
	input A, B, C_in, A_from_next_bit;
	output F, C_out;

	assign F = ~A;
	
endmodule
