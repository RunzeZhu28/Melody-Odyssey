
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
				
	datapath U2(resetn, CLOCK_50,x,y);
	vga_pic U1(CLOCK_50, resetn, x,y,colour);
					
endmodule


module vga_pic(
input wire clk , //输入工作时钟,频率25MHz
input wire sys_rst_n , //输入复位信号,低电平有效
input wire [9:0] x , //输入有效显示区域像素点X轴坐标
input wire [9:0] y , //输入有效显示区域像素点Y轴坐标

output reg [2:0] colour //输出像素点色彩信息

);

////
//\* Parameter and Internal Signal \//
////
//parameter define
parameter startX= 10'd60, //字符开始X轴坐标
startY= 10'd52 ; //字符开始Y轴坐标

parameter CHAR_W = 10'd28 , //字符宽度
CHAR_H = 10'd16 ; //字符高度



//wire define
wire [9:0] char_x ; //字符显示X轴坐标
wire [9:0] char_y ; //字符显示Y轴坐标

//reg define
reg [27:0] char [15:0] ; //字符数据

////
//\* Main Code \//
////

//字符显示坐标


//char:字符数据
always@(posedge clk)
begin
char[0] <= 28'h0;
char[1] <= 28'h0;
char[2] <= 28'h000070000C0000000C0000000000;
char[3] <= 28'hEE00100004000030040000000000;
char[4] <= 28'h6C00100004000048040000000000;
char[5] <= 28'h6C00100004000084040000000000;
char[6] <= 28'h6C3810383CEE00843CEE3C3C38EE;
char[7] <= 28'h5444104444440084444444444444;
char[8] <= 28'h547C104444280084442830307C28;
char[9] <= 28'h5440104444280084442808084028;
char[10] <= 28'h5444104444100048441044444410;
char[11] <= 28'hD6387C383E1000303E1078783810;
char[12] <= 28'h0000000000100000001000000010;
char[13] <= 28'h0000000000E0000000E0000000E0;
char[14] <= 28'h0;
char[15] <= 28'h0;
end

 //pix_data:输出像素点色彩信息,根据当前像素点坐标指定当前像素点颜色数据
always @(posedge clk) begin
    // 这里设置屏幕上显示字符的起始位置
    // 根据你的屏幕分辨率调整

    if (x >= startX && x < startX + 28 && y >= startY && y < startY + 16) begin
        colour <= char[y - startY][x - startX] ? 3'b111 : 3'b000; // 白色字符，黑色背景
    end else begin
        colour <= 3'b000; // 屏幕其他部分为黑色
    end
end

endmodule

module datapath(reset,clk,xout, yout);
input reset,clk;
output reg [7:0] xout;
output reg[6:0] yout;
//output reg[2:0] cout;

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
			//cout <= 3'b101;
			xout <= black_counter[7:0];
			yout <= black_counter[14:8];
			black_counter <= 15'b0;
		end
		else
		begin
		black_counter <= black_counter + 1;
		//cout <= 3'b101;
		xout <= black_counter[7:0];
		yout <= black_counter[14:8];
		end
	end
end

endmodule
