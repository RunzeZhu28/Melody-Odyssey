
// This is the template for Part 2 of Lab 7.
//
// Paul Chow
// November 2021
//
// Part 2 skeleton

module vga
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
	wire [7:0] x;
	wire [6:0] y;
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
		defparam VGA.RESOLUTION = "160x120";
		defparam VGA.MONOCHROME = "FALSE";
		defparam VGA.BITS_PER_COLOUR_CHANNEL = 1;
		defparam VGA.BACKGROUND_IMAGE = "black.mif";
			
	// Put your code here. Your code should produce signals x,y,colour and writeEn
	// for the VGA controller, in addition to any other functionality your design may require.
	

   //
   // Your code goes here
   //
	wire L_x, L_y, L_c,plot_enable, black_enable, done;
	assign resetn = KEY[0];
				
	datapath U2(resetn, CLOCK_50,x,y,colour);
					
endmodule


module datapath(reset,clk,xout, yout, cout);
input reset,clk;
output reg [7:0] xout;
output reg[6:0] yout;
output reg[2:0] cout;

reg [14:0] black_counter;



always@(posedge clk)
begin
	if(!reset)
	begin
		black_counter <=0;
	end
	else 
	begin
		if (black_counter == 15'b111111111111111)
		begin
			cout <= 3'b101;
			xout <= black_counter[7:0];
			yout <= black_counter[14:8];
			black_counter <= 15'b0;
		end
		else
		begin
		black_counter <= black_counter + 1;
		cout <= 3'b101;
		xout <= black_counter[7:0];
		yout <= black_counter[14:8];
		end
	end
end

endmodule
