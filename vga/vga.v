module vga(pixel_clock, h_position, v_position, red_in, green_in, blue_in, red_out, green_out, blue_out, h_sync_out, v_sync_out);
	// this module is based on Tim Hollabach's (former student) peripheral project from Comp Arch 2018
    input pixel_clock;
    input [3:0] red_in, green_in, blue_in;
    output [3:0] red_out, green_out, blue_out;
    output reg h_sync_out, v_sync_out;
    output reg [11:0] h_position;
    output reg [10:0] v_position;

    // Sync signals looks like this
    //
    // ------\   /--------------------------------------\   /-----------------
    // H_SYNC|   |                                      |   |
    //       \---/                                      \---/
    //                  /----------------------\                    /---------
    // Data             |                      |                    |
    // -----------------+----------------------+--------------------+---------
    //       |===|======|======================|========|===|=======|=========
    //       Sync  Back |   Display Interval     Front  Sync  Back  |Display
    //             porch|                        porch        porch |Interval
    //==================|===========================================|=========
    //Prev. Line                  Current Line                       Next Line

	// VGA spec for 640x480 25.175MHz clock
	
	//Scanline part	Clocks	Time [µs]
	//Visible area		640		25.422045680238
	//Front porch		16			0.63555114200596
	//Sync pulse		96			3.8133068520357
	//Back porch		48			1.9066534260179
	//Whole line		800		31.777557100298

    parameter H_DISPLAY_INTERVAL = 640;
    parameter H_FRONT_PORCH = 16;
    parameter H_SYNC = 96;
    parameter H_BACK_PORCH = 48;

    // Timing for vertical sync in lines
    parameter V_DISPLAY_INTERVAL = 480;
    parameter V_FRONT_PORCH = 10;
    parameter V_SYNC = 2;
    parameter V_BACK_PORCH = 33;

    reg h_pixel_enable;
    reg v_pixel_enable;

    initial begin
        //red_out <= 4'b0000;
        //green_out <= 4'b0000;
        //blue_out <= 4'b0000;
        h_sync_out <= 1'b1;
        v_sync_out <= 1'b1;
        //pixel_clock <= 1'b0;
        h_position <= 11'd0;
        v_position <= 10'd0;
        h_pixel_enable <= 1'b0;
        v_pixel_enable <= 1'b0;
    end

    // generate the horizontal sync signal, pixel enable, and position index
    always @(posedge pixel_clock) begin
        if (h_position < H_DISPLAY_INTERVAL) begin
            h_sync_out <= 1'b1;
            h_pixel_enable <= 1'b1;
            h_position <= h_position + 1'b1;
        end else if (h_position < H_DISPLAY_INTERVAL + H_FRONT_PORCH) begin
            h_sync_out <= 1'b1;
            h_pixel_enable <= 1'b0;
            h_position <= h_position + 1'b1;
        end else if (h_position < H_DISPLAY_INTERVAL + H_FRONT_PORCH + H_SYNC) begin
            h_sync_out <= 1'b0;
            h_pixel_enable <= 1'b0;
            h_position <= h_position + 1'b1;
        end else if (h_position < H_DISPLAY_INTERVAL + H_FRONT_PORCH + H_SYNC + H_BACK_PORCH) begin
            h_sync_out <= 1'b1;
            h_pixel_enable <= 1'b0;
            h_position <= h_position + 1'b1;
        end else begin
            h_position <= 1'b0;
        end
    end

    // generate the vertical sync signal, pixel enable, and position index
    always @(posedge h_sync_out) begin
        if (v_position < V_DISPLAY_INTERVAL) begin
            v_sync_out <= 1'b1;
            v_pixel_enable <= 1'b1;
            v_position <= v_position + 1'b1;
        end else if (v_position < V_DISPLAY_INTERVAL + V_FRONT_PORCH) begin
            v_sync_out <= 1'b1;
            v_pixel_enable <= 1'b0;
            v_position <= v_position + 1'b1;
        end else if (v_position < V_DISPLAY_INTERVAL + V_FRONT_PORCH + V_SYNC) begin
            v_sync_out <= 1'b0;
            v_pixel_enable <= 1'b0;
            v_position <= v_position + 1'b1;
        end else if (v_position < V_DISPLAY_INTERVAL + V_FRONT_PORCH + V_SYNC + V_BACK_PORCH) begin
            v_sync_out <= 1'b1;
            v_pixel_enable <= 1'b0;
            v_position <= v_position + 1'b1;
        end else begin
            v_position <= 1'b0;
        end
    end

    // output the pixel color only when the horizontal and vertical scans are in the visible range
	 wire pixel_enable;
	 assign pixel_enable = h_pixel_enable & v_pixel_enable;
    assign red_out = pixel_enable ? red_in : 4'b0;
    assign green_out = pixel_enable ? green_in : 4'b0;
    assign blue_out = pixel_enable ? blue_in : 4'b0;
endmodule

