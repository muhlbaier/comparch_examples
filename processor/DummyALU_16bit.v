module DummyALU_16bit (FS, A, B, F, status);
	input [4:0]FS; // Function Select
	input [15:0]A,B;
	output [15:0]F;
	output [3:0]status; // output status vector {V, C, N, Z;
	
	wire oVerflow, C_out, Negative, Zero;
	
	wire [15:0]C;
	
	// 16 single bit ALUs
	DummyALU_bit ALU0  (FS,  A[0],  B[0],  F[0],  C[0],  A[1],  C[1]);
	DummyALU_bit ALU1  (FS,  A[1],  B[1],  F[1],  C[1],  A[2],  C[2]);
	
	assign status = {oVerflow, C_out, Negative, Zero};
	
endmodule
