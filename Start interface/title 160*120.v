
module vga
	(
		CLOCK_50,						//	On Board 50 MHz
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
			
	// for the VGA controller, in addition to any other functionality your design may require.

	wire L_x, L_y, L_c,plot_enable, black_enable, done;
	assign resetn = KEY[0];
				
	datapath U2(resetn, CLOCK_50,x,y);
	vga_pic U1(CLOCK_50, resetn, x,y,colour);
					
endmodule


module vga_pic(
input wire clk , 
input wire reset , 
input wire [7:0] x , //x coordinate
input wire [6:0] y , //y coordinate

output reg [2:0] colour//output color
);

parameter x_initial= 10'd24,  //title begins at
y_initial= 10'd30 ; //title begins at

parameter width = 10'd112 ,  // title width
height = 10'd16 ; //title height

wire [6:0] char_x ; //title coordinate 0-111
wire [4:0] char_y ; //title y coordinate 0-15

//Check if it reaches the area of title
assign char_x = (((x >= x_initial) && (x < (x_initial + width)))
&&((y >= y_initial)&&(y < (y_initial + height))))
? (x - x_initial) : 0;
assign char_y = (((x >= x_initial) && (x < (x_initial + width)))
&&((y >= y_initial)&&(y < (y_initial + height))))
? (y - y_initial) : 0;

//char:Title 
reg [111:0] char [15:0] ; //Title LCD character font
always@(posedge clk)
begin
char[0] <= 112'h0;
char[1] <= 112'h0;
char[2] <= 112'h000070000C0000000C0000000000;
char[3] <= 112'hEE00100004000030040000000000;
char[4] <= 112'h6C00100004000048040000000000;
char[5] <= 112'h6C00100004000084040000000000;
char[6] <= 112'h6C3810383CEE00843CEE3C3C38EE;
char[7] <= 112'h5444104444440084444444444444;
char[8] <= 112'h547C104444280084442830307C28;
char[9] <= 112'h5440104444280084442808084028;
char[10] <= 112'h5444104444100048441044444410;
char[11] <= 112'hD6387C383E1000303E1078783810;
char[12] <= 112'h0000000000100000001000000010;
char[13] <= 112'h0000000000E0000000E0000000E0;
char[14] <= 112'h0;
char[15] <= 112'h0;
end

 always@(posedge clk or negedge reset)
 if(!reset)
 colour <= 3'b111;
 else if((((x >= (x_initial - 1'b1))
 && (x < (x_initial + width -1'b1)))
 && ((y >= y_initial) && (y < (y_initial + height))))
 && (char[char_y][10'd112 - char_x] == 1'b1))
 colour <= 3'b101;
 else
 colour <= 3'b111;

 endmodule


module datapath(reset,clk,xout, yout);
input reset,clk;
output reg [7:0] xout;
output reg[6:0] yout;
reg [14:0] counter;

always@(posedge clk)
begin
	if(!reset)
	begin
		counter <=0;
	end
	else 
	begin
		if (counter == 15'b111111111111111)
		begin
			xout <= counter[7:0];
			yout <= counter[14:8];
			counter <= 15'b0;
		end
		else
		begin
		counter <= counter + 1;
		xout <= counter[7:0];
		yout <= counter[14:8];
		end
	end
end

endmodule
