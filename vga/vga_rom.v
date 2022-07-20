module vga_rom(row, column, data);
	// vga_rom basically holds the background characters to display, feel free to modify as desired.
	input [6:0] row, column;
	output reg [7:0] data;
	reg [8*80-1:0] row_data;

	// implement a asyncronous 60 word x 640 bit ROM
	// based on the row input row_data will be the 640-bit output representing the 80 8-bit characters making up the row 
	// note in character_lookup module the character for ASCII '_' and the following character have been replaced
	// with a visual representation of "off" and "on" for the purpose of visualizing binary data
	always @ (row) begin
		case(row)
	//     COLUMN             0         1         2         3         4         5         6         7
	//     NUMBER             01234567890123456789012345678901234567890123456789012345678901234567890123456789
			7'd00: row_data <= "          COMPUTER ARCHITECTURE PROCESSOR VISUALIZATION                         ";
			7'd01: row_data <= "              REGISTER FILE                      MEMORY                         ";
			7'd02: row_data <= "        HEX       BINARY               HEX       BINARY                         ";
			7'd03: row_data <= "            FEDCBA98 76543210              FEDCBA98 76543210                    ";
			7'd04: row_data <= "    R7 0000 ________ ________  MEM XX 0000 ________ ________                    ";
			7'd05: row_data <= "    R6 0000 ________ ________  MEM XX 0000 ________ ________                    ";
			7'd06: row_data <= "    R5 0000 ________ ________  MEM XX 0000 ________ ________                    ";
			7'd07: row_data <= "    R4 0000 ________ ________  MEM XX 0000 ________ ________                    ";
			7'd08: row_data <= "    R3 0000 ________ ________  MEM XX 0000 ________ ________                    ";
			7'd09: row_data <= "    R2 0000 ________ ________  MEM XX 0000 ________ ________                    ";
			7'd10: row_data <= "    R1 0000 ________ ________  MEM XX 0000 ________ ________                    ";
			7'd11: row_data <= "    R0 0000 ________ ________  MEM XX 0000 ________ ________                    ";
		   7'd12: row_data <= "                               MEM XX 0000 ________ ________                    ";
			7'd13: row_data <= "   DATA BUSSES                 MEM XX 0000 ________ ________                    ";
			7'd14: row_data <= "        HEX       BINARY       MEM XX 0000 ________ ________                    ";
			7'd15: row_data <= "            FEDCBA98 76543210  MEM XX 0000 ________ ________                    ";
			7'd16: row_data <= "  DATA 0000 ________ ________  MEM XX 0000 ________ ________                    ";
			7'd17: row_data <= "     A 0000 ________ ________  MEM XX 0000 ________ ________                    ";
			7'd18: row_data <= "     B 0000 ________ ________  MEM XX 0000 ________ ________                    ";
			7'd19: row_data <= " ADDRS 0000 ________ ________  MEM XX 0000 ________ ________                    ";
			7'd20: row_data <= "    PC 0000 ________ ________  MEM XX 0000 ________ ________                    ";
			7'd21: row_data <= " INSTR 0000 ________ ________  MEM XX 0000 ________ ________                    ";
			7'd22: row_data <= "                               MEM XX 0000 ________ ________                    ";
			7'd23: row_data <= "   CONTROL SIGNALS             MEM XX 0000 ________ ________                    ";
			7'd24: row_data <= "        HEX       BINARY       MEM XX 0000 ________ ________                    ";
			7'd25: row_data <= "            FEDCBA98 76543210  MEM XX 0000 ________ ________                    ";
			7'd26: row_data <= "    FS   00             _____  MEM XX 0000 ________ ________                    ";
			7'd27: row_data <= "    WR    0                 _  MEM XX 0000 ________ ________                    ";
			7'd28: row_data <= "    DA    0               ___  MEM XX 0000 ________ ________                    ";
			7'd29: row_data <= "    SA    0               ___  MEM XX 0000 ________ ________                    ";
			7'd30: row_data <= "    SB    0               ___  MEM XX 0000 ________ ________                    ";
			7'd31: row_data <= "  NAME 0000 ________ ________  MEM XX 0000 ________ ________                    ";
			7'd32: row_data <= "  NAME 0000 ________ ________  MEM XX 0000 ________ ________                    ";
			7'd33: row_data <= "  NAME 0000 ________ ________  MEM XX 0000 ________ ________                    ";
			7'd34: row_data <= "  NAME 0000 ________ ________  MEM XX 0000 ________ ________                    ";
			7'd35: row_data <= "  NAME 0000 ________ ________  MEM XX 0000 ________ ________                    ";
			7'd36: row_data <= "  NAME 0000 ________ ________  MEM XX 0000 ________ ________                    ";
			7'd37: row_data <= "  NAME 0000 ________ ________  MEM XX 0000 ________ ________                    ";
			7'd38: row_data <= "  NAME 0000 ________ ________  MEM XX 0000 ________ ________                    ";
			7'd39: row_data <= "  NAME 0000 ________ ________  MEM XX 0000 ________ ________                    ";
			7'd40: row_data <= "  NAME 0000 ________ ________  MEM XX 0000 ________ ________                    ";
			7'd41: row_data <= "  NAME 0000 ________ ________  MEM XX 0000 ________ ________                    ";
			7'd42: row_data <= "  NAME 0000 ________ ________  MEM XX 0000 ________ ________                    ";
			7'd43: row_data <= "  NAME 0000 ________ ________  MEM XX 0000 ________ ________                    ";
			7'd44: row_data <= "  NAME 0000 ________ ________  MEM XX 0000 ________ ________                    ";
			7'd45: row_data <= "  NAME 0000 ________ ________  MEM XX 0000 ________ ________                    ";
			7'd46: row_data <= "                                                                                ";
			7'd47: row_data <= "       CONTROL WORD HIGH              CONTROL WORD LOW                          ";
			7'd48: row_data <= "        HEX       BINARY               HEX       BINARY                         ";
			7'd49: row_data <= "            FEDCBA98 76543210              FEDCBA98 76543210                    ";
			7'd50: row_data <= "  HIGH 0000 ________ ________     LOW 0000 ________ ________                    ";
			7'd51: row_data <= "                                                                                ";
			7'd52: row_data <= "         STATUS SIGNALS                                                         ";
			7'd53: row_data <= "         HEX             VCNZ                                                   ";
			7'd54: row_data <= "          0              ____                                                   ";
			7'd55: row_data <= "                                                                                ";
			7'd56: row_data <= "                                                                                ";
			7'd57: row_data <= "                                                                                ";
			7'd58: row_data <= "                                                                                ";
			7'd59: row_data <= "                                                                                ";
			default: 
					 row_data <= "                                                                                ";
		endcase
	end
	
	// implement a 8-bit 64-to-1 multiplexer to select the 8-bits from the row corresponing with the column input
	always @ (*) begin
		case (column)
			7'd00: data <= row_data[8*80-1:8*79];
			7'd01: data <= row_data[8*79-1:8*78];
			7'd02: data <= row_data[8*78-1:8*77];
			7'd03: data <= row_data[8*77-1:8*76];
			7'd04: data <= row_data[8*76-1:8*75];
			7'd05: data <= row_data[8*75-1:8*74];
			7'd06: data <= row_data[8*74-1:8*73];
			7'd07: data <= row_data[8*73-1:8*72];
			7'd08: data <= row_data[8*72-1:8*71];
			7'd09: data <= row_data[8*71-1:8*70];
			7'd10: data <= row_data[8*70-1:8*69];
			7'd11: data <= row_data[8*69-1:8*68];
			7'd12: data <= row_data[8*68-1:8*67];
			7'd13: data <= row_data[8*67-1:8*66];
			7'd14: data <= row_data[8*66-1:8*65];
			7'd15: data <= row_data[8*65-1:8*64];
			7'd16: data <= row_data[8*64-1:8*63];
			7'd17: data <= row_data[8*63-1:8*62];
			7'd18: data <= row_data[8*62-1:8*61];
			7'd19: data <= row_data[8*61-1:8*60];
			7'd20: data <= row_data[8*60-1:8*59];
			7'd21: data <= row_data[8*59-1:8*58];
			7'd22: data <= row_data[8*58-1:8*57];
			7'd23: data <= row_data[8*57-1:8*56];
			7'd24: data <= row_data[8*56-1:8*55];
			7'd25: data <= row_data[8*55-1:8*54];
			7'd26: data <= row_data[8*54-1:8*53];
			7'd27: data <= row_data[8*53-1:8*52];
			7'd28: data <= row_data[8*52-1:8*51];
			7'd29: data <= row_data[8*51-1:8*50];
			7'd30: data <= row_data[8*50-1:8*49];
			7'd31: data <= row_data[8*49-1:8*48];
			7'd32: data <= row_data[8*48-1:8*47];
			7'd33: data <= row_data[8*47-1:8*46];
			7'd34: data <= row_data[8*46-1:8*45];
			7'd35: data <= row_data[8*45-1:8*44];
			7'd36: data <= row_data[8*44-1:8*43];
			7'd37: data <= row_data[8*43-1:8*42];
			7'd38: data <= row_data[8*42-1:8*41];
			7'd39: data <= row_data[8*41-1:8*40];
			7'd40: data <= row_data[8*40-1:8*39];
			7'd41: data <= row_data[8*39-1:8*38];
			7'd42: data <= row_data[8*38-1:8*37];
			7'd43: data <= row_data[8*37-1:8*36];
			7'd44: data <= row_data[8*36-1:8*35];
			7'd45: data <= row_data[8*35-1:8*34];
			7'd46: data <= row_data[8*34-1:8*33];
			7'd47: data <= row_data[8*33-1:8*32];
			7'd48: data <= row_data[8*32-1:8*31];
			7'd49: data <= row_data[8*31-1:8*30];
			7'd50: data <= row_data[8*30-1:8*29];
			7'd51: data <= row_data[8*29-1:8*28];
			7'd52: data <= row_data[8*28-1:8*27];
			7'd53: data <= row_data[8*27-1:8*26];
			7'd54: data <= row_data[8*26-1:8*25];
			7'd55: data <= row_data[8*25-1:8*24];
			7'd56: data <= row_data[8*24-1:8*23];
			7'd57: data <= row_data[8*23-1:8*22];
			7'd58: data <= row_data[8*22-1:8*21];
			7'd59: data <= row_data[8*21-1:8*20];
			7'd60: data <= row_data[8*20-1:8*19];
			7'd61: data <= row_data[8*19-1:8*18];
			7'd62: data <= row_data[8*18-1:8*17];
			7'd63: data <= row_data[8*17-1:8*16];
			7'd64: data <= row_data[8*16-1:8*15];
			7'd65: data <= row_data[8*15-1:8*14];
			7'd66: data <= row_data[8*14-1:8*13];
			7'd67: data <= row_data[8*13-1:8*12];
			7'd68: data <= row_data[8*12-1:8*11];
			7'd69: data <= row_data[8*11-1:8*10];
			7'd70: data <= row_data[8*10-1:8*9];
			7'd71: data <= row_data[8*9-1:8*8];
			7'd72: data <= row_data[8*8-1:8*7];
			7'd73: data <= row_data[8*7-1:8*6];
			7'd74: data <= row_data[8*6-1:8*5];
			7'd75: data <= row_data[8*5-1:8*4];
			7'd76: data <= row_data[8*4-1:8*3];
			7'd77: data <= row_data[8*3-1:8*2];
			7'd78: data <= row_data[8*2-1:8*1];
			7'd79: data <= row_data[7:0];
			default: data <= 8'b0;
		endcase
	end
		
endmodule
