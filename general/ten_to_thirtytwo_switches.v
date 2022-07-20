module ten_to_thirtytwo_switches(in, out, latch);
	input [9:0] in; // ten switches from DE10 typically
	output reg [31:0] out; // 32 signals to be used for a control word or other data
	input latch; // latch signal
	
	// for example if trying to get a 32-bit signal of 0x87654321 then
	// 1. Enter 00 0010 0001 on the 10 switches
	// 2. Latch
	// 3. Enter 01 0100 0011 on the 10 switches
	// 4. Latch
	// 5. Enter 10 0110 0101 on the 10 switches
	// 6. Latch
	// 7. Enter 11 1000 0111 on the 10 switches
	// 8. Latch
	
	always @(posedge latch) begin
		case(in[9:8])
			2'b00: out[ 7: 0] <= in[7:0];
			2'b01: out[15: 8] <= in[7:0];
			2'b10: out[23:16] <= in[7:0];
			2'b11: out[31:24] <= in[7:0];
		endcase
	end
endmodule
