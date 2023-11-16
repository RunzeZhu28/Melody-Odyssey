
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

parameter x_initial= 10'd48,  //title begins at
y_initial= 10'd50 ; //title begins at

parameter width = 10'd224 ,  // title width
height = 10'd32 ; //title height

parameter xx_initial = 10'd120,//Start begins at
yy_initial = 10'd120;//

parameter widths = 10'd80, //start width
heights = 10'd32;// start width

wire [7:0] char_x ; //title coordinate 0-223
wire [5:0] char_y ; //title y coordinate 0-31
wire [6:0] char_xx;//start coordinate 0-79
wire [5:0] char_yy;//start coordinate 0-31

//Check if it reaches the area of title
assign char_x = (((x >= x_initial) && (x < (x_initial + width)))
&&((y >= y_initial)&&(y < (y_initial + height))))
? (x - x_initial) : 0;

assign char_y = (((x >= x_initial) && (x < (x_initial + width)))
&&((y >= y_initial)&&(y < (y_initial + height))))
? (y - y_initial) : 0;

assign char_xx = (((x >= xx_initial) && (x < (xx_initial + widths)))
&&((y >= yy_initial)&&(y < (yy_initial + heights))))
? (x - xx_initial) : 0;

assign char_yy = (((x >= xx_initial) && (x < (xx_initial + widths)))
&&((y >= yy_initial)&&(y < (yy_initial + heights))))
? (y - yy_initial) : 0;
//char:Title 
reg [223:0] char [31:0] ; //Title LCD character font
always@(posedge clk)
begin


char[0] <=224'h00000000000000000000000000000000000000000000000000000000;
char[1] <=224'h00000000000000000000000000000000000000000000000000000000;
char[2] <=224'h00000000000000000000000000000000000000000000000000000000;
char[3] <=224'h00000000000000000000000000000000000000000000000000000000;
char[4] <=224'h00000000000000000000000000000000000000000000000000000000;
char[5] <=224'h00000000008000000008000000000000000800000000000000000000;
char[6] <=224'hF00F00001F80000000780000000003C0007800000000000000000000;
char[7] <=224'h381C0000018000000018000000000C30001800000000000000000000;
char[8] <=224'h381C0000018000000018000000001818001800000000000000000000;
char[9] <=224'h381C0000018000000018000000001008001800000000000000000000;
char[10] <=224'h381C000001800000001800000000300C001800000000000000000000;
char[11] <=224'h382C000001800000001800000000300C001800000000000000000000;
char[12] <=224'h2C2C0000018000000018000000006004001800000000000000000000;
char[13] <=224'h2C2C03C0018003C007D87C3E0000600607D87C3E03E403E403C07C3E;
char[14] <=224'h2C2C0C3001800C300C381818000060060C381818061C061C0C301818;
char[15] <=224'h2C4C0818018008181818181000006006181818100C0C0C0C08181810;
char[16] <=224'h2C4C1808018018181818081000006006181808100C040C0418080810;
char[17] <=224'h264C300C0180100C30180C100000600630180C100C040C04300C0C10;
char[18] <=224'h264C300C0180300C3018042000006006301804200E000E00300C0420;
char[19] <=224'h264C300C0180300C30180620000060063018062007C007C0300C0620;
char[20] <=224'h268C3FFC0180300C30180620000060063018062001F001F03FFC0620;
char[21] <=224'h228C30000180300C3018024000002006301802400078007830000240;
char[22] <=224'h238C30000180300C301803400000300C30180340001C001C30000340;
char[23] <=224'h238C30000180300C301801400000300C30180140100C100C30000140;
char[24] <=224'h230C180401801818101801800000100810180180100C100C18040180;
char[25] <=224'h230C180801801818183801800000181818380180180C180C18080180;
char[26] <=224'h210C0E1801800C300C5E010000000C300C5E01001C181C180E180100;
char[27] <=224'hF13F03E01FF803C007900100000003C00790010013F013F003E00100;
char[28] <=224'h00000000000000000000010000000000000001000000000000000100;
char[29] <=224'h00000000000000000000020000000000000002000000000000000200;
char[30] <=224'h000000000000000000003E000000000000003E000000000000003E00;
char[31] <=224'h000000000000000000003C000000000000003C000000000000003C00;
end

reg [79:0] char_s [31:0] ; //Title LCD character font
always@(posedge clk)
begin
char_s[0] <=80'h00000000000000000000;
char_s[1] <=80'h00000000000000000000;
char_s[2] <=80'h00000000000000000000;
char_s[3] <=80'h00000000000000000000;
char_s[4] <=80'h00000000000000000000;
char_s[5] <=80'h00000000000000000000;
char_s[6] <=80'h0FFC3FFC03807FE03FFC;
char_s[7] <=80'h1CFC3184038018383184;
char_s[8] <=80'h383C2186038018182186;
char_s[9] <=80'h701C41820380180C4182;
char_s[10] <=80'h700C418204C0180C4182;
char_s[11] <=80'h700C018004C0180C0180;
char_s[12] <=80'h7000018004C0180C0180;
char_s[13] <=80'h7800018004C0180C0180;
char_s[14] <=80'h3E0001800C4018180180;
char_s[15] <=80'h1F800180086018300180;
char_s[16] <=80'h0FE0018008601FE00180;
char_s[17] <=80'h03F80180086018C00180;
char_s[18] <=80'h007C0180182018C00180;
char_s[19] <=80'h003C01801FF018600180;
char_s[20] <=80'h001E0180103018600180;
char_s[21] <=80'h600E0180103018600180;
char_s[22] <=80'h600E0180103018300180;
char_s[23] <=80'h700E0180201818300180;
char_s[24] <=80'h701C0180201818300180;
char_s[25] <=80'h781C0180201818180180;
char_s[26] <=80'h7E780180601C18180180;
char_s[27] <=80'h3FF007E0F83E7E1E07E0;
char_s[28] <=80'h00000000000000000000;
char_s[29] <=80'h00000000000000000000;
char_s[30] <=80'h00000000000000000000;
char_s[31] <=80'h00000000000000000000;
end

 always@(posedge clk or negedge reset)
 if(!reset)
 colour <= 3'b111;
 
 else if((((x >= (x_initial - 1'b1))
 && (x < (x_initial + width -1'b1)))
 && ((y >= y_initial) && (y < (y_initial + height))))
 && (char[char_y][10'd224 - char_x] == 1'b1))
 colour <= 3'b101;
 
 else if((((x >= (xx_initial - 1'b1))
 && (x < (xx_initial + widths -1'b1)))
 && ((y >= yy_initial) && (y < (yy_initial + heights))))
 && (char_s[char_yy][10'd80 - char_xx] == 1'b1))
 colour <= 3'b100;
 
 else if((((x >= (xx_initial - 1'b1))
 && (x < (xx_initial + widths -1'b1)))
 && ((y >= yy_initial) && (y < (yy_initial + heights))))
 && (char_s[char_yy][10'd80 - char_xx] == 1'b0))
 colour <= 3'b110;
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
