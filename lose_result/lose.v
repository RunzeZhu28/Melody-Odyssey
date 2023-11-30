
module lose
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
   //
	wire L_x, L_y, L_c,plot_enable, black_enable, done;
	assign resetn = KEY[0];
				
	datapath U2(resetn, CLOCK_50,x,y);
	vga_pic U1(CLOCK_50, resetn, x,y,colour);
					
endmodule


module vga_pic(
input wire clk , 
input wire reset , 
input wire [8:0] x , //x coordinate
input wire [7:0] y , //y coordinate

output reg [2:0] colour//output color
);

parameter x_initial= 10'd112,  //title begins at
y_initial= 10'd108 ; //title begins at

parameter width = 10'd96 ,  // title width
height = 10'd24 ; //title height


wire [6:0] char_x ; //title x coordinate
wire [4:0] char_y ; //title y coordinate 


//Check if it reaches the area of title
assign char_x = (((x >= x_initial) && (x < (x_initial + width)))
&&((y >= y_initial)&&(y < (y_initial + height))))
? (x - x_initial) : 0;

assign char_y = (((x >= x_initial) && (x < (x_initial + width)))
&&((y >= y_initial)&&(y < (y_initial + height))))
? (y - y_initial) : 0;


reg [95:0] char [23:0] ; //Title LCD character font
always@(posedge clk)
begin

char[0] <= 96'h000000000000000000000000;
char[1] <= 96'h000000000000000000000000;
char[2] <= 96'h000000000000000000000000;
char[3] <= 96'h000000000000000000000000;
char[4] <= 96'h000000000000000000000000;
char[5] <= 96'hF9F000000000F80000000000;
char[6] <= 96'h70E000000000600000000000;
char[7] <= 96'h70C000000000600000000000;
char[8] <= 96'h38C000000000600000000000;
char[9] <= 96'h398000104000600000000000;
char[10] <= 96'h1D80F071C0006000F00FC078;
char[11] <= 96'h1F819830C00060019838C18C;
char[12] <= 96'h1F030C30C00060030C304104;
char[13] <= 96'h0F060630C000600606304306;
char[14] <= 96'h0E060630C0006006061C0306;
char[15] <= 96'h0E060630C0006006060F03FE;
char[16] <= 96'h0E060630C00060060603C300;
char[17] <= 96'h0E060630C00060260620C300;
char[18] <= 96'h0E030C30C00060230C20C182;
char[19] <= 96'h0E030C39E00060430C31C184;
char[20] <= 96'h1F80F01E8000FFC0F03F8078;
char[21] <= 96'h000000000000000000000000;
char[22] <= 96'h000000000000000000000000;
char[23] <= 96'h000000000000000000000000;

end

 always@(posedge clk or negedge reset)
 if(!reset)
 colour <= 3'b111;
 
 else if((((x >= (x_initial - 1'b1))
 && (x < (x_initial + width -1'b1)))
 && ((y >= y_initial) && (y < (y_initial + height))))
 && (char[char_y][10'd95 - char_x] == 1'b1))
 colour <= 3'b100;
 
 else
 colour <= 3'b111;

 endmodule


module datapath(reset,clk,xout, yout);
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
