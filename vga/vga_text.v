module vga_text(pixel_clock, character, vga_hpos, vga_vpos, red_out, green_out, blue_out, h_sync, v_sync);
	// this module is based on Tim Hollabach's (former student) peripheral project from Comp Arch 2018
	
    input pixel_clock;

    input [7:0] character;
	 
	 output [10:0] vga_hpos;
    output [9:0] vga_vpos;

    output [3:0] red_out, green_out, blue_out;
    output h_sync, v_sync;

    reg [11:0] fg_color;
    reg [11:0] bg_color;

    initial begin
        fg_color <= 12'hFFF;
        bg_color <= 12'h000;
    end

    wire vga_pixel;

    wire [11:0] vga_colors;
	 // use the pixel binary value to select between the foreground and background colors
    assign vga_colors = vga_pixel ? fg_color : bg_color;

	 // the vga module will output the horizontal and vertical position as well as the VGA
	 // signals based on the clock and the pixel color input (the DE0 and DE10 have a 4-bit x 3 color depth)
    vga vga(
        .h_position(vga_hpos),
        .v_position(vga_vpos),
        .red_in(vga_colors[3:0]),
        .green_in(vga_colors[7:4]),
        .blue_in(vga_colors[11:8]),
        .red_out(red_out),
        .green_out(green_out),
        .blue_out(blue_out),
        .h_sync_out(h_sync),
        .v_sync_out(v_sync),
        .pixel_clock(pixel_clock)
    );

	 // based on the horizontal and vertical position and the character to display determine the binary
	 // pixel value
    character_lookup lookup(
        .character(character),
        .h_position(vga_hpos[2:0]),
        .v_position(vga_vpos[2:0]),
        .pixel(vga_pixel)
    );

endmodule
