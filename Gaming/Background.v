
module gaming
	(
		CLOCK_50,						//	On Board 50 MHz
		// Your inputs and outputs here
		KEY,		
		SW,// On Board Keys
		// The ports below are for the VGA output.  Do not change.
		VGA_CLK,   						//	VGA Clock
		VGA_HS,							//	VGA H_SYNC
		VGA_VS,							//	VGA V_SYNC
		VGA_BLANK_N,						//	VGA BLANK
		VGA_SYNC_N,						//	VGA SYNC
		VGA_R,   						//	VGA Red[9:0]
		VGA_G,	 						//	VGA Green[9:0]
		VGA_B   						//	VGA Blue[9:0]
	);

	input			CLOCK_50;				//	50 MHz
	input	[3:0]	KEY;		
	input [9:0] SW;
	// Declare your inputs and outputs here
	// Do not change the following outputs
	output			VGA_CLK;   				//	VGA Clock
	output			VGA_HS;					//	VGA H_SYNC
	output			VGA_VS;					//	VGA V_SYNC
	output			VGA_BLANK_N;				//	VGA BLANK
	output			VGA_SYNC_N;				//	VGA SYNC
	output	[7:0]	VGA_R;   				//	VGA Red[7:0] Changed from 10 to 8-bit DAC
	output	[7:0]	VGA_G;	 				//	VGA Green[7:0]
	output	[7:0]	VGA_B;   				//	VGA Blue[7:0]
	
	wire resetn;
	assign resetn = KEY[0];
	
	// Create the colour, x, y and writeEn wires that are inputs to the controller.

	wire [2:0] colour;
	wire [8:0] x;
	wire [7:0] y;
	wire writeEn;

	// Create an Instance of a VGA controller - there can be only one!
	// Define the number of colours as well as the initial background
	// image file (.MIF) for the controller.
	vga_adapter VGA(
			.resetn(resetn),
			.clock(CLOCK_50),
			.colour(colour),
			.x(x),
			.y(y),
			.plot(1'b1),
			/* Signals for the DAC to drive the monitor. */
			.VGA_R(VGA_R),
			.VGA_G(VGA_G),
			.VGA_B(VGA_B),
			.VGA_HS(VGA_HS),
			.VGA_VS(VGA_VS),
			.VGA_BLANK(VGA_BLANK_N),
			.VGA_SYNC(VGA_SYNC_N),
			.VGA_CLK(VGA_CLK));
		defparam VGA.RESOLUTION = "320x240";
		defparam VGA.MONOCHROME = "FALSE";
		defparam VGA.BITS_PER_COLOUR_CHANNEL = 1;
		defparam VGA.BACKGROUND_IMAGE = "black.mif";
			
	wire L_x, L_y, L_c,plot_enable, black_enable, done;
	assign resetn = KEY[0];
				
	Counter U2(resetn, CLOCK_50,x,y);
	vga_pic U1(CLOCK_50, resetn, x,y,colour);
					
endmodule


module vga_pic(
input wire clk , 
input wire reset , 
input wire [8:0] x , //x coordinate
input wire [7:0] y , //y coordinate

output reg [2:0] colour//output color
);

parameter x_initial= 10'd114,  //begins at
y_initial= 10'd0 ; //begins at

parameter width = 10'd93,  //width
height = 10'd240 ; //height


wire [6:0] char_x ; //x coordinate 0-89
wire [7:0] char_y ; //y coordinate 0-239


//Check if it reaches the area of title
assign char_x = (((x >= x_initial) && (x < (x_initial + width)))
&&((y >= y_initial)&&(y < (y_initial + height))))
? (x - x_initial) : 0;

assign char_y = (((x >= x_initial) && (x < (x_initial + width)))
&&((y >= y_initial)&&(y < (y_initial + height))))
? (y - y_initial) : 0;

reg [89:0] initial_value = 90'h80000300000C0000300001;
//char:Title 
reg [91:0] char [239:0]; //Title LCD character font
always@(*)
begin
	 char[0]  <= 92'h300000c0000300000c00003;
    char[1]  <= 92'h300000c0000300000c00003;
    char[2]  <= 92'h300000c0000300000c00003;
    char[3]  <= 92'h300000c0000300000c00003;
    char[4]  <= 92'h300000c0000300000c00003;
    char[5]  <= 92'h300000c0000300000c00003;
    char[6]  <= 92'h300000c0000300000c00003;
    char[7]  <= 92'h300000c0000300000c00003;
    char[8]  <= 92'h300000c0000300000c00003;
    char[9]  <= 92'h300000c0000300000c00003;
    char[10] <= 92'h300000c0000300000c00003;
    char[11] <= 92'h300000c0000300000c00003;
    char[12] <= 92'h300000c0000300000c00003;
    char[13] <= 92'h300000c0000300000c00003;
    char[14] <= 92'h300000c0000300000c00003;
    char[15] <= 92'h300000c0000300000c00003;
    char[16] <= 92'h300000c0000300000c00003;
    char[17] <= 92'h300000c0000300000c00003;
    char[18] <= 92'h300000c0000300000c00003;
    char[19] <= 92'h300000c0000300000c00003;
    char[20] <= 92'h300000c0000300000c00003;
    char[21] <= 92'h300000c0000300000c00003;
    char[22] <= 92'h300000c0000300000c00003;
    char[23] <= 92'h300000c0000300000c00003;
    char[24] <= 92'h300000c0000300000c00003;
    char[25] <= 92'h300000c0000300000c00003;
    char[26] <= 92'h300000c0000300000c00003;
    char[27] <= 92'h300000c0000300000c00003;
    char[28] <= 92'h300000c0000300000c00003;
    char[29] <= 92'h300000c0000300000c00003;
    char[30] <= 92'h300000c0000300000c00003;
    char[31] <= 92'h300000c0000300000c00003;
    char[32] <= 92'h300000c0000300000c00003;
    char[33] <= 92'h300000c0000300000c00003;
    char[34] <= 92'h300000c0000300000c00003;
    char[35] <= 92'h300000c0000300000c00003;
    char[36] <= 92'h300000c0000300000c00003;
    char[37] <= 92'h300000c0000300000c00003;
    char[38] <= 92'h300000c0000300000c00003;
    char[39] <= 92'h300000c0000300000c00003;
    char[40] <= 92'h300000c0000300000c00003;
    char[41] <= 92'h300000c0000300000c00003;
    char[42] <= 92'h300000c0000300000c00003;
    char[43] <= 92'h300000c0000300000c00003;
    char[44] <= 92'h300000c0000300000c00003;
    char[45] <= 92'h300000c0000300000c00003;
    char[46] <= 92'h300000c0000300000c00003;
    char[47] <= 92'h300000c0000300000c00003;
    char[48] <= 92'h300000c0000300000c00003;
    char[49] <= 92'h300000c0000300000c00003;
    char[50] <= 92'h300000c0000300000c00003;
    char[51] <= 92'h300000c0000300000c00003;
    char[52] <= 92'h300000c0000300000c00003;
    char[53] <= 92'h300000c0000300000c00003;
    char[54] <= 92'h300000c0000300000c00003;
    char[55] <= 92'h300000c0000300000c00003;
    char[56] <= 92'h300000c0000300000c00003;
    char[57] <= 92'h300000c0000300000c00003;
    char[58] <= 92'h300000c0000300000c00003;
    char[59] <= 92'h300000c0000300000c00003;
    char[60] <= 92'h300000c0000300000c00003;
    char[61] <= 92'h300000c0000300000c00003;
    char[62] <= 92'h300000c0000300000c00003;
    char[63] <= 92'h300000c0000300000c00003;
    char[64] <= 92'h300000c0000300000c00003;
    char[65] <= 92'h300000c0000300000c00003;
    char[66] <= 92'h300000c0000300000c00003;
    char[67] <= 92'h300000c0000300000c00003;
    char[68] <= 92'h300000c0000300000c00003;
    char[69] <= 92'h300000c0000300000c00003;
    char[70] <= 92'h300000c0000300000c00003;
    char[71] <= 92'h300000c0000300000c00003;
    char[72] <= 92'h300000c0000300000c00003;
    char[73] <= 92'h300000c0000300000c00003;
    char[74] <= 92'h300000c0000300000c00003;
    char[75] <= 92'h300000c0000300000c00003;
    char[76] <= 92'h300000c0000300000c00003;
    char[77] <= 92'h300000c0000300000c00003;
    char[78] <= 92'h300000c0000300000c00003;
    char[79] <= 92'h300000c0000300000c00003;
    char[80] <= 92'h300000c0000300000c00003;
    char[81] <= 92'h300000c0000300000c00003;
    char[82] <= 92'h300000c0000300000c00003;
    char[83] <= 92'h300000c0000300000c00003;
    char[84] <= 92'h300000c0000300000c00003;
    char[85] <= 92'h300000c0000300000c00003;
    char[86] <= 92'h300000c0000300000c00003;
    char[87] <= 92'h300000c0000300000c00003;
    char[88] <= 92'h300000c0000300000c00003;
    char[89] <= 92'h300000c0000300000c00003;
    char[90] <= 92'h300000c0000300000c00003;
    char[91] <= 92'h300000c0000300000c00003;
    char[92] <= 92'h300000c0000300000c00003;
    char[93] <= 92'h300000c0000300000c00003;
    char[94] <= 92'h300000c0000300000c00003;
    char[95] <= 92'h300000c0000300000c00003;
    char[96] <= 92'h300000c0000300000c00003;
    char[97] <= 92'h300000c0000300000c00003;
    char[98] <= 92'h300000c0000300000c00003;
    char[99] <= 92'h300000c0000300000c00003;
    char[100] <=92'h300000c0000300000c00003;
    char[101] <=92'h300000c0000300000c00003;
    char[102] <=92'h300000c0000300000c00003;
    char[103] <=92'h300000c0000300000c00003;
    char[104] <=92'h300000c0000300000c00003;
    char[105] <=92'h300000c0000300000c00003;
    char[106] <=92'h300000c0000300000c00003;
    char[107] <=92'h300000c0000300000c00003;
    char[108] <=92'h300000c0000300000c00003;
    char[109] <=92'h300000c0000300000c00003;
    char[110] <=92'h300000c0000300000c00003;
    char[111] <=92'h300000c0000300000c00003;
    char[112] <=92'h300000c0000300000c00003;
    char[113] <=92'h300000c0000300000c00003;
    char[114] <=92'h300000c0000300000c00003;
    char[115] <=92'h300000c0000300000c00003;
    char[116] <=92'h300000c0000300000c00003;
    char[117] <=92'h300000c0000300000c00003;
    char[118] <=92'h300000c0000300000c00003;
    char[119] <=92'h300000c0000300000c00003;
    char[120] <=92'h300000c0000300000c00003;
    char[121] <=92'h300000c0000300000c00003;
    char[122] <=92'h300000c0000300000c00003;
    char[123] <=92'h300000c0000300000c00003;
    char[124] <=92'h300000c0000300000c00003;
    char[125] <=92'h300000c0000300000c00003;
    char[126] <=92'h300000c0000300000c00003;
    char[127] <=92'h300000c0000300000c00003;
    char[128] <=92'h300000c0000300000c00003;
    char[129] <=92'h300000c0000300000c00003;
    char[130] <=92'h300000c0000300000c00003;
    char[131] <=92'h300000c0000300000c00003;
    char[132] <=92'h300000c0000300000c00003;
    char[133] <=92'h300000c0000300000c00003;
    char[134] <=92'h300000c0000300000c00003;
    char[135] <=92'h300000c0000300000c00003;
    char[136] <=92'h300000c0000300000c00003;
    char[137] <=92'h300000c0000300000c00003;
    char[138] <=92'h300000c0000300000c00003;
    char[139] <=92'h300000c0000300000c00003;
    char[140] <=92'h300000c0000300000c00003;
    char[141] <=92'h300000c0000300000c00003;
    char[142] <=92'h300000c0000300000c00003;
    char[143] <=92'h300000c0000300000c00003;
    char[144] <=92'h300000c0000300000c00003;
    char[145] <=92'h300000c0000300000c00003;
    char[146] <=92'h300000c0000300000c00003;
    char[147] <=92'h300000c0000300000c00003;
    char[148] <=92'h300000c0000300000c00003;
    char[149] <=92'h300000c0000300000c00003;
    char[150] <=92'h300000c0000300000c00003;
    char[151] <=92'h300000c0000300000c00003;
    char[152] <=92'h300000c0000300000c00003;
    char[153] <=92'h300000c0000300000c00003;
    char[154] <=92'h300000c0000300000c00003;
    char[155] <=92'h300000c0000300000c00003;
    char[156] <=92'h300000c0000300000c00003;
    char[157] <=92'h300000c0000300000c00003;
    char[158] <=92'h300000c0000300000c00003;
    char[159] <=92'h300000c0000300000c00003;
    char[160] <=92'h300000c0000300000c00003;
    char[161] <=92'h300000c0000300000c00003;
    char[162] <=92'h300000c0000300000c00003;
    char[163] <=92'h300000c0000300000c00003;
    char[164] <=92'h300000c0000300000c00003;
    char[165] <=92'h300000c0000300000c00003;
    char[166] <=92'h300000c0000300000c00003;
    char[167] <=92'h300000c0000300000c00003;
    char[168] <=92'h300000c0000300000c00003;
    char[169] <=92'h300000c0000300000c00003;
    char[170] <=92'h300000c0000300000c00003;
    char[171] <=92'h300000c0000300000c00003;
    char[172] <=92'h300000c0000300000c00003;
    char[173] <=92'h300000c0000300000c00003;
    char[174] <=92'h300000c0000300000c00003;
    char[175] <=92'h300000c0000300000c00003;
    char[176] <=92'h300000c0000300000c00003;
    char[177] <=92'h300000c0000300000c00003;
    char[178] <=92'h300000c0000300000c00003;
    char[179] <=92'h300000c0000300000c00003;
    char[180] <=92'h300000c0000300000c00003;
    char[181] <=92'h300000c0000300000c00003;
    char[182] <=92'h300000c0000300000c00003;
    char[183] <=92'h300000c0000300000c00003;
    char[184] <=92'h300000c0000300000c00003;
    char[185] <=92'h300000c0000300000c00003;
    char[186] <=92'h300000c0000300000c00003;
    char[187] <=92'h300000c0000300000c00003;
    char[188] <=92'h300000c0000300000c00003;
    char[189] <=92'h300000c0000300000c00003;
    char[190] <=92'h300000c0000300000c00003;
    char[191] <=92'h300000c0000300000c00003;
    char[192] <=92'h300000c0000300000c00003;
    char[193] <=92'h300000c0000300000c00003;
    char[194] <=92'h300000c0000300000c00003;
    char[195] <=92'h300000c0000300000c00003;
    char[196] <=92'h300000c0000300000c00003;
    char[197] <=92'h300000c0000300000c00003;
    char[198] <=92'h300000c0000300000c00003;
    char[199] <=92'h300000c0000300000c00003;
    char[200] <=92'h300000c0000300000c00003;
    char[201] <=92'h300000c0000300000c00003;
    char[202] <=92'h300000c0000300000c00003;
    char[203] <=92'h300000c0000300000c00003;
    char[204] <=92'h300000c0000300000c00003;
    char[205] <=92'h300000c0000300000c00003;
    char[206] <=92'h300000c0000300000c00003;
    char[207] <=92'h300000c0000300000c00003;
    char[208] <=92'h300000c0000300000c00003;
    char[209] <=92'h300000c0000300000c00003;
    char[210] <=92'h300000c0000300000c00003;
    char[211] <=92'h300000c0000300000c00003;
    char[212] <=92'h300000c0000300000c00003;
    char[213] <=92'h300000c0000300000c00003;
    char[214] <=92'h300000c0000300000c00003;
    char[215] <=92'h300000c0000300000c00003;
    char[216] <=92'h300000c0000300000c00003;
    char[217] <=92'h300000c0000300000c00003;
    char[218] <=92'h3FFFFFFFFFFFFFFFFFFFFFF;
    char[219] <=92'h3FFFFFFFFFFFFFFFFFFFFFF;
    char[220] <=92'h300000c0000300000c00003;
    char[221] <=92'h300000c0000300000c00003;
    char[222] <=92'h300000c0000300000c00003;
    char[223] <=92'h300000c0000300000c00003;
    char[224] <=92'h300000c0000300000c00003;
    char[225] <=92'h300000c0000300000c00003;
    char[226] <=92'h300000c0000300000c00003;
    char[227] <=92'h300000c0000300000c00003;
    char[228] <=92'h300000c0000300000c00003;
    char[229] <=92'h300000c0000300000c00003;
    char[230] <=92'h300000c0000300000c00003;
    char[231] <=92'h300000c0000300000c00003;
    char[232] <=92'h300000c0000300000c00003;
    char[233] <=92'h300000c0000300000c00003;
    char[234] <=92'h300000c0000300000c00003;
    char[235] <=92'h300000c0000300000c00003;
    char[236] <=92'h300000c0000300000c00003;
    char[237] <=92'h300000c0000300000c00003;
    char[238] <=92'h300000c0000300000c00003;
    char[239] <=92'h300000c0000300000c00003;
end

 always@(posedge clk or negedge reset)
 if(!reset)
 colour <= 3'b111;
 
 else if((((x >= (x_initial - 1'b1))
 && (x < (x_initial + width -1'b1)))
 && ((y >= y_initial) && (y < (y_initial + height))))
 && (char[char_y][10'd91 - char_x] == 1'b1))
 colour <= 3'b000;
 else
 colour <= 3'b111;

endmodule


module Counter(reset,clk,xout, yout);
input reset,clk;
output reg [8:0] xout;
output reg[7:0] yout;
reg [16:0] counter;

always@(posedge clk)
begin
	if(!reset)
	begin
		counter <=0;
	end
	else 
	begin
		if (counter == 17'b11111111111111111)
		begin
			xout <= counter[8:0];
			yout <= counter[16:9];
			counter <= 17'b0;
		end
		else
		begin
		counter <= counter + 1;
		xout <= counter[8:0];
		yout <= counter[16 :9];
		end
	end
end

endmodule
