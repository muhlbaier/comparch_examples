module register_file_alu_vga(MAX10_CLK1_50, VGA_R, VGA_G, VGA_B, VGA_HS, VGA_VS, LEDG, SW, KEY);
	input MAX10_CLK1_50;

	output [3:0] VGA_R, VGA_G, VGA_B;
	output VGA_HS, VGA_VS;
	output [9:0] LEDG;
	input [9:0] SW;
	input [1:0] KEY;
	
	wire [15:0] A_bus, B_bus, data, R0, R1, R2, R3, R4, R5, R6, R7;
	wire [2:0] SA, SB, DA;
	wire [3:0] VCNZ_status;
	wire [4:0] FS;
	wire reset, clock, WR;
	
	// modules to test (note these are not functional)
	DummyRegisterFile8x16 reg_file_dut(
		.A(A_bus), 
		.B(B_bus), 
		.SA(SA), 
		.SB(SB), 
		.D(data), 
		.DA(DA), 
		.W(WR), 
		.reset(reset), 
		.clock(clock), 
		.r0(R0), 
		.r1(R1), 
		.r2(R2), 
		.r3(R3), 
		.r4(R4), 
		.r5(R5), 
		.r6(R6), 
		.r7(R7)
	);
		
	DummyALU_16bit alu_dut(
		.FS(FS), 
		.A(A_bus), 
		.B(B_bus), 
		.F(data), 
		.status(VCNZ_status)
	);

	// maping of switches and buttons to DUTs
	wire [1:0] button; // this will have positive logic, DE0 buttons have negative logic
	assign button = ~KEY;
	// since the DE0 and DE10 only have 10 siwtches a module is used to enter four sets of
	// eight bits from the switches where switches 8 and 9 select which set and switches
	// 7:0 are used as the data.
	// In this data the switches are mapped to the register file and ALU control signals
	wire [31:0] virtual_switch, dummy;
	ten_to_thirtytwo_switches switch_decode_inst(
		.in(SW), 
		.out(virtual_switch), 
		.latch(button[1])
	);
	assign {dummy[31:21], FS, dummy[15:12], WR, DA, dummy[7:6], SA, SB} = virtual_switch;
	assign clock = button[0];
	// use both buttons at the same time as the reset signal to the register file
	assign reset = button[0] & button[1];
	
	vga_cpu_visual vga_inst(
		.clock_50(MAX10_CLK1_50), 
		.red_out(VGA_R), 
		.green_out(VGA_G),
		.blue_out(VGA_B),
		.h_sync(VGA_HS),
		.v_sync(VGA_VS), 
		.row4h(R7), // referring to vga_rom row4h aligns with the label R7 and so on
		.row5h(R6),
		.row6h(R5),
		.row7h(R4),
		.row8h(R3),
		.row9h(R2),
		.row10h(R1),
		.row11h(R0),
		.row16h(data),
		.row17h(A_bus),
		.row18h(B_bus),
		.row26h(FS),
		.row27h(WR),
		.row28h(DA),
		.row29h(SA),
		.row30h(SB),
		.row50h(virtual_switch[31:16]),
		.row50l(virtual_switch[15:0]),
		.row54h(VCNZ_status)
	);

endmodule
