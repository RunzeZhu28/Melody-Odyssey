module game
	(
		CLOCK_50,						//	On Board 50 MHz
		// Your inputs and outputs here
		KEY,							// On Board Keys
		// The ports below are for the VGA output.  Do not change.
		VGA_CLK,   						//	VGA Clock
		VGA_HS,							//	VGA H_SYNC
		VGA_VS,							//	VGA V_SYNC
		VGA_BLANK_N,						//	VGA BLANK
		VGA_SYNC_N,						//	VGA SYNC
		VGA_R,   						//	VGA Red[9:0]
		VGA_G,	 						//	VGA Green[9:0]
		VGA_B,   						//	VGA Blue[9:0]
		HEX3,
		SW,
		LEDR,
		AUD_ADCDAT,
	// Bidirectionals
	AUD_BCLK,
	AUD_ADCLRCK,
	AUD_DACLRCK,
	FPGA_I2C_SDAT,
	// Outputs
	AUD_XCK,
	AUD_DACDAT,
	FPGA_I2C_SCLK,
	PS2_CLK,
	PS2_DAT
	);
 
	input			CLOCK_50;				//	50 MHz
	input	[3:0]	KEY;	
	input [9:0] SW;
	output[9:0]LEDR;
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
	output   [6:0] HEX3;
	
	wire resetn;
	assign resetn = SW[0];
	
	// Create the colour, x, y and writeEn wires that are inaputs to the controller.

	wire [2:0] colour;
	wire [8:0] x;
	wire [7:0] y;
	wire writeEn;
	wire Start;
	input				AUD_ADCDAT;

// Bidirectionals
	inout				AUD_BCLK;
	inout				AUD_ADCLRCK;
	inout				AUD_DACLRCK;

	inout				FPGA_I2C_SDAT;
	inout PS2_CLK;
	inout PS2_DAT;

// Outputs
	output				AUD_XCK;
	output				AUD_DACDAT;

	output				FPGA_I2C_SCLK;
	
	//assign writeEn = ~VGA_VS;
	// Create an Instance of a VGA controller - there can be only one!
	// Define the number of colours as well as the initial background
	// image file (.MIF) for the controller.
	vga_adapter VGA(
			.resetn(resetn),
			.clock(CLOCK_50),
			.colour(colour),
			.x(x),
			.y(y),
			.plot(1),
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
		
		
		wire l0,l1,l2,l3,l4,l5,l6,l7,l8;

	KeyboardDecoder U3(CLOCK_50, SW[0],PS2_CLK,PS2_DAT, l0,l1,l2,l3,l4,l5,l6,l7,l8);
 audio  U2(
	CLOCK_50,
	AUD_ADCDAT,
	// Bidirectionals
	AUD_BCLK,
	AUD_ADCLRCK,
	AUD_DACLRCK,
	FPGA_I2C_SDAT,
	// Outputs
	AUD_XCK,
	AUD_DACDAT,
	FPGA_I2C_SCLK,
	Start
);	
	// Put your code here. Your code should produce signals x,y,colour and writeEn
	// for the VGA controller, in addition to any other functionality your design may require.
beat U1(CLOCK_50, resetn, (~KEY[0] || l3), (~KEY[1]||l2), (~KEY[2] || l1), (~KEY[3] || l0), (SW[1] || l4) , (SW[2] ||l4) , (l6 ||SW[3]),(l7 ||SW[4]) ,(SW[5] || l8),VGA_VS,x, y, colour,HEX3,Start);
	//beat U1(CLOCK_50, resetn, ~KEY[0], ~KEY[1], ~KEY[2], ~KEY[3], SW[1]  , SW[2] , SW[3],SW[4] ,SW[5],VGA_VS,x, y, colour,HEX3 ,Start);
endmodule
