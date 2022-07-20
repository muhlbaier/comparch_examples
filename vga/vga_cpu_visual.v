module vga_cpu_visual(clock_50, red_out, green_out, blue_out, h_sync, v_sync, 
                       row0h,  row1h,  row2h,  row3h,  row4h,  row5h,  row6h,  row7h,  row8h,  row9h,
							 row10h, row11h, row12h, row13h, row14h, row15h, row16h, row17h, row18h, row19h,
							 row20h, row21h, row22h, row23h, row24h, row25h, row26h, row27h, row28h, row29h,
							 row30h, row31h, row32h, row33h, row34h, row35h, row36h, row37h, row38h, row39h,
							 row40h, row41h, row42h, row43h, row44h, row45h, row46h, row47h, row48h, row49h,
							 row50h, row51h, row52h, row53h, row54h, row55h, row56h, row57h, row58h, row59h,
							  row0l,  row1l,  row2l,  row3l,  row4l,  row5l,  row6l,  row7l,  row8l,  row9l,
							 row10l, row11l, row12l, row13l, row14l, row15l, row16l, row17l, row18l, row19l,
							 row20l, row21l, row22l, row23l, row24l, row25l, row26l, row27l, row28l, row29l,
							 row30l, row31l, row32l, row33l, row34l, row35l, row36l, row37l, row38l, row39l,
							 row40l, row41l, row42l, row43l, row44l, row45l, row46l, row47l, row48l, row49l,
							 row50l, row51l, row52l, row53l, row54l, row55l, row56l, row57l, row58l, row59l);
	// this module takes a 50MHz clock input and instantiates a VGA driver to generate a standard
	// 640 x 480 output signal. The 640 x 480 pixel space is divided into 8x8 pixel characters
	// for 80 columns and 60 rows total. The vga_rom module implements the background characters
	// to display and then data from rowXXh and rowXXl 16-bit inputs are added to certain characters in both
	// hexadecimal and binary format (where XX is the row number ranging from 0 to 59).
	// Specifically rowXXh is added to the corresponding row columns 7-10 in HEX and columns 12-28 in binary
	// and rowXXl is added to the corresponding row in columns 38-41 in HEX and 43-58 in binary
	input clock_50;
	output [3:0] red_out, green_out, blue_out;
	output h_sync, v_sync;
	input [15:0]        row0h,  row1h,  row2h,  row3h,  row4h,  row5h,  row6h,  row7h,  row8h,  row9h,
							 row10h, row11h, row12h, row13h, row14h, row15h, row16h, row17h, row18h, row19h,
							 row20h, row21h, row22h, row23h, row24h, row25h, row26h, row27h, row28h, row29h,
							 row30h, row31h, row32h, row33h, row34h, row35h, row36h, row37h, row38h, row39h,
							 row40h, row41h, row42h, row43h, row44h, row45h, row46h, row47h, row48h, row49h,
							 row50h, row51h, row52h, row53h, row54h, row55h, row56h, row57h, row58h, row59h,
							  row0l,  row1l,  row2l,  row3l,  row4l,  row5l,  row6l,  row7l,  row8l,  row9l,
							 row10l, row11l, row12l, row13l, row14l, row15l, row16l, row17l, row18l, row19l,
							 row20l, row21l, row22l, row23l, row24l, row25l, row26l, row27l, row28l, row29l,
							 row30l, row31l, row32l, row33l, row34l, row35l, row36l, row37l, row38l, row39l,
							 row40l, row41l, row42l, row43l, row44l, row45l, row46l, row47l, row48l, row49l,
							 row50l, row51l, row52l, row53l, row54l, row55l, row56l, row57l, row58l, row59l;
							 
	 /// @todo consider changing background color based on row and column to make it easier to see
	 
	 reg [31:0] row_data;
	 
	 // beharioral verilog impelemntation of a 32'bit 64-to-1 multiplexer to select the row data to use
	 always @ (*) begin
		case (vga_vpos[9:3])
			7'd00: row_data <= {row0h, row0l};
			7'd01: row_data <= {row1h, row1l};
			7'd02: row_data <= {row2h, row2l};
			7'd03: row_data <= {row3h, row3l};
			7'd04: row_data <= {row4h, row4l};
			7'd05: row_data <= {row5h, row5l};
			7'd06: row_data <= {row6h, row6l};
			7'd07: row_data <= {row7h, row7l};
			7'd08: row_data <= {row8h, row8l};
			7'd09: row_data <= {row9h, row9l};
			7'd10: row_data <= {row10h, row10l};
			7'd11: row_data <= {row11h, row11l};
			7'd12: row_data <= {row12h, row12l};
			7'd13: row_data <= {row13h, row13l};
			7'd14: row_data <= {row14h, row14l};
			7'd15: row_data <= {row15h, row15l};
			7'd16: row_data <= {row16h, row16l};
			7'd17: row_data <= {row17h, row17l};
			7'd18: row_data <= {row18h, row18l};
			7'd19: row_data <= {row19h, row19l};
			7'd20: row_data <= {row20h, row20l};
			7'd21: row_data <= {row21h, row21l};
			7'd22: row_data <= {row22h, row22l};
			7'd23: row_data <= {row23h, row23l};
			7'd24: row_data <= {row24h, row24l};
			7'd25: row_data <= {row25h, row25l};
			7'd26: row_data <= {row26h, row26l};
			7'd27: row_data <= {row27h, row27l};
			7'd28: row_data <= {row28h, row28l};
			7'd29: row_data <= {row29h, row29l};
			7'd30: row_data <= {row30h, row30l};
			7'd31: row_data <= {row31h, row31l};
			7'd32: row_data <= {row32h, row32l};
			7'd33: row_data <= {row33h, row33l};
			7'd34: row_data <= {row34h, row34l};
			7'd35: row_data <= {row35h, row35l};
			7'd36: row_data <= {row36h, row36l};
			7'd37: row_data <= {row37h, row37l};
			7'd38: row_data <= {row38h, row38l};
			7'd39: row_data <= {row39h, row39l};
			7'd40: row_data <= {row40h, row40l};
			7'd41: row_data <= {row41h, row41l};
			7'd42: row_data <= {row42h, row42l};
			7'd43: row_data <= {row43h, row43l};
			7'd44: row_data <= {row44h, row44l};
			7'd45: row_data <= {row45h, row45l};
			7'd46: row_data <= {row46h, row46l};
			7'd47: row_data <= {row47h, row47l};
			7'd48: row_data <= {row48h, row48l};
			7'd49: row_data <= {row49h, row49l};
			7'd50: row_data <= {row50h, row50l};
			7'd51: row_data <= {row51h, row51l};
			7'd52: row_data <= {row52h, row52l};
			7'd53: row_data <= {row53h, row53l};
			7'd54: row_data <= {row54h, row54l};
			7'd55: row_data <= {row55h, row55l};
			7'd56: row_data <= {row56h, row56l};
			7'd57: row_data <= {row57h, row57l};
			7'd58: row_data <= {row58h, row58l};
			7'd59: row_data <= {row59h, row59l};
			default: row_data <= 0;
		endcase
	end
	
	wire [7:0] hex0_offset, hex1_offset, hex2_offset, hex3_offset, hex4_offset, hex5_offset, hex6_offset, hex7_offset;
	// decode the 8 sets of 4'bit row data into an ASCII offset since A does not come after 9 in ASCII
	hex_to_ascii_offset h2a0 (row_data[3:0], hex0_offset);
	hex_to_ascii_offset h2a1 (row_data[7:4], hex1_offset);
	hex_to_ascii_offset h2a2 (row_data[11:8], hex2_offset);
	hex_to_ascii_offset h2a3 (row_data[15:12], hex3_offset);
	hex_to_ascii_offset h2a4 (row_data[19:16], hex4_offset);
	hex_to_ascii_offset h2a5 (row_data[23:20], hex5_offset);
	hex_to_ascii_offset h2a6 (row_data[27:24], hex6_offset);
	hex_to_ascii_offset h2a7 (row_data[31:28], hex7_offset);
	
	// beharioral verilog impelemntation of a 8'bit 64-to-1 multiplexer to select the offset to apply to the character
	reg [7:0] data_char_offset;
	always @ (*) begin
		case (vga_hpos[10:3])
			8'd07: data_char_offset <= hex7_offset; // need to properly convert to HEX
			8'd08: data_char_offset <= hex6_offset; // need to properly convert to HEX
			8'd09: data_char_offset <= hex5_offset; // need to properly convert to HEX
			8'd10: data_char_offset <= hex4_offset; // need to properly convert to HEX
			8'd12: data_char_offset <= row_data[31];
			8'd13: data_char_offset <= row_data[30];
			8'd14: data_char_offset <= row_data[29];
			8'd15: data_char_offset <= row_data[28];
			8'd16: data_char_offset <= row_data[27];
			8'd17: data_char_offset <= row_data[26];
			8'd18: data_char_offset <= row_data[25];
			8'd19: data_char_offset <= row_data[24];
			8'd21: data_char_offset <= row_data[23];
			8'd22: data_char_offset <= row_data[22];
			8'd23: data_char_offset <= row_data[21];
			8'd24: data_char_offset <= row_data[20];
			8'd25: data_char_offset <= row_data[19];
			8'd26: data_char_offset <= row_data[18];
			8'd27: data_char_offset <= row_data[17];
			8'd28: data_char_offset <= row_data[16];
			8'd38: data_char_offset <= hex3_offset; // need to properly convert to HEX
			8'd39: data_char_offset <= hex2_offset; // need to properly convert to HEX
			8'd40: data_char_offset <= hex1_offset; // need to properly convert to HEX
			8'd41: data_char_offset <= hex0_offset; // need to properly convert to HEX
			8'd43: data_char_offset <= row_data[15];
			8'd44: data_char_offset <= row_data[14];
			8'd45: data_char_offset <= row_data[13];
			8'd46: data_char_offset <= row_data[12];
			8'd47: data_char_offset <= row_data[11];
			8'd48: data_char_offset <= row_data[10];
			8'd49: data_char_offset <= row_data[9];
			8'd50: data_char_offset <= row_data[8];
			8'd52: data_char_offset <= row_data[7];
			8'd53: data_char_offset <= row_data[6];
			8'd54: data_char_offset <= row_data[5];
			8'd55: data_char_offset <= row_data[4];
			8'd56: data_char_offset <= row_data[3];
			8'd57: data_char_offset <= row_data[2];
			8'd58: data_char_offset <= row_data[1];
			default: data_char_offset <= 8'b0;
		endcase
	end
	
	// generate 25.175MHz pixel clock using PLL module
	wire pixel_clock;
	vga_clock pll_inst (clock_50, pixel_clock);

	// the vga module will output a vertical and horizontal position as it scans through to generate the output
	// signal, this will serve as an index to determine which bit from which character to display at any given
	// instant in time.
	wire [9:0] vga_vpos;
	wire [10:0] vga_hpos;
	 
	// look up static character from the "background" rom
   wire [7:0] vga_char;
	vga_rom vga_rom (vga_vpos[9:3], vga_hpos[10:3], vga_char);
	
	// the character to display will be the background character plus the offset
	wire [7:0] character; 
	assign character = vga_char + data_char_offset;
	
	// vga_text module uses the vga module to display a charcter, it is expected that the character input will
	// changed based on the horizontal and vertical position (which it does)
	vga_text vga_text (pixel_clock, character, vga_hpos, vga_vpos, red_out, green_out, blue_out, h_sync, v_sync);
endmodule

module hex_to_ascii_offset(in, out);
	input [3:0] in;
	output [7:0] out;
	// when the input is less than 10 the offset is the input to get 0 to 9 characters
	// at and above 10 the input needs to be offest by 7 to skip the ASCII characters
	// between 9 and A (see ASCII table online for details)
	assign out = in < 4'd10 ? in : in + 8'd7;
endmodule
