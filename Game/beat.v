module beat(clk, resetn, key_1, key_2,x, y, colour);

  input clk, resetn, key_1, key_2;
  output reg [8:0] x;
  output reg [7:0] y;
  output reg [2:0] colour;
  reg miss, done;
  wire interface, map, total_miss, win, lose;
  
  control_path control_path_inst(clk, resetn, key_1, key_2, miss, done, interface, map, total_miss, win, lose); 
	
  //parameter height = 240;
  //parameter width = 320;
  //parameter notes_height = 10;
  //parameter bpm = 150;
  parameter x_initial= 10'd48; //title begins at
  parameter y_initial= 10'd50 ; //title begins at

  parameter width = 10'd224 ;  // title width
  parameter height = 10'd32 ; //title height

  parameter xx_initial = 10'd120;//Start begins at
  parameter yy_initial = 10'd120;//

  parameter widths = 10'd80; //start width
  parameter heights = 10'd32;// start width

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

  wire [3:0] note;
  reg [12:0] note_address;
  wire clk_50Hz;
  wire clk_10Hz;
  reg [3:0] screen [10:0];
  reg [3:0] counter;
  reg [7:0] y_position [10:0];
  wire [7:0] oy_0;
  wire [7:0] oy_1;
  wire [7:0] oy_2;
  wire [7:0] oy_3;
  wire [7:0] oy_4;
  wire [7:0] oy_5;
  wire [7:0] oy_6;
  wire [7:0] oy_7;
  wire [7:0] oy_8;
  wire [7:0] oy_9;
  wire [7:0] oy_10;
  
  initial begin
      screen[0] <= 4'b0;
      screen[1] <= 4'b0;
      screen[2] <= 4'b0;
      screen[3] <= 4'b0;
      screen[4] <= 4'b0;
      screen[5] <= 4'b0;
      screen[6] <= 4'b0;
      screen[7] <= 4'b0;
      screen[8] <= 4'b0;
      screen[9] <= 4'b0;
      screen[10] <= 4'b0;
      y_position[0] <= 8'b0;
      y_position[1] <= 8'b0;
      y_position[2] <= 8'b0;
      y_position[3] <= 8'b0;
      y_position[4] <= 8'b0;
      y_position[5] <= 8'b0;
      y_position[6] <= 8'b0;
      y_position[7] <= 8'b0;
      y_position[8] <= 8'b0;
      y_position[9] <= 8'b0;
      y_position[10] <= 8'b0;
	 counter <= 0;
	 note_address <= 0;
	 miss <= 0;
	 done <=0;
  end
	
  notes U1(clk, note_address, note);

  clock_divider_50 U2(clk, resetn, clk_50Hz);
  clock_divider_10 U3(clk, resetn, clk_10Hz);
  vga_double_buffering U4(clk,resetn, map, oy_0);
  vga_double_buffering_1 U5(clk,resetn, map,oy_1);
  vga_double_buffering_2 U6(clk,resetn, map,oy_2);
  vga_double_buffering_3 U7(clk,resetn, map,oy_3);
  vga_double_buffering_4 U8(clk,resetn, map,oy_4);
  vga_double_buffering_5 U9(clk,resetn, map,oy_5);
  vga_double_buffering_6 U10(clk,resetn, map,oy_6);
  vga_double_buffering_7 U11(clk,resetn, map,oy_7);
  vga_double_buffering_8 U12(clk,resetn, map,oy_8);
  vga_double_buffering_9 U13(clk,resetn, map,oy_9);
  vga_double_buffering_10 U14(clk,resetn,map, oy_10);
  
 
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
  
  always @(posedge clk)
    if (!resetn) begin
      x <= 0;
      y <= 0;
    end
    else if (x < 319) begin
      x <= x + 1;
    end 
    else begin
      x <= 0;
      if (y < 239) begin
        y <= y + 1;
      end else begin
        y <= 0;
      end
    end

  always @(posedge clk_10Hz)
    if (!resetn)
      note_address <= 0;
	 else if(interface) note_address <= 0;
    else //if(map && !done)   error here
      note_address <= note_address + 1;

		
  always@(negedge clk_50Hz)
  begin
  if(counter < 3'b100 ) 
  begin
  counter <= counter+1;
  
  y_position[0] <= oy_0;
	y_position[1] <= oy_1;
	y_position[2] <= oy_2;
	y_position[3] <= oy_3;
	y_position[4] <= oy_4;
	y_position[5] <= oy_5;
	y_position[6] <= oy_6;
	y_position[7] <= oy_7;
	y_position[8] <= oy_8;
	y_position[9] <= oy_9;
	y_position[10] <= oy_10;

	//y_position[0] <= y_position[0]+ 4;
	//y_position[1] <= y_position[1]+ 4;
	//y_position[2] <= y_position[2]+ 4;
	//y_position[3] <= y_position[3]+ 4;
	//y_position[4] <= y_position[4]+ 4;
	//y_position[5] <= y_position[5]+ 4;
	//y_position[6] <= y_position[6]+ 4;
	//y_position[7] <= y_position[7]+ 4;
	//y_position[8] <= y_position[8]+ 4;
	//y_position[9] <= y_position[9]+ 4;
	//y_position[10] <=y_position[10]+4;

  end
  
  else if (counter == 3'b100 )begin
  counter <= 0;
  screen[1][0] <= screen[0][0];
  screen[2][0] <= screen[1][0];
  screen[3][0] <= screen[2][0];
  screen[4][0] <= screen[3][0];
  screen[5][0] <= screen[4][0];
  screen[6][0] <= screen[5][0];
  screen[7][0] <= screen[6][0];
  screen[8][0] <= screen[7][0];
  screen[9][0] <= screen[8][0];
  screen[10][0] <= screen[9][0];

  screen[1][1] <= screen[0][1];
  screen[2][1] <= screen[1][1];
  screen[3][1] <= screen[2][1];
  screen[4][1] <= screen[3][1];
  screen[5][1] <= screen[4][1];
  screen[6][1] <= screen[5][1];
  screen[7][1] <= screen[6][1];
  screen[8][1] <= screen[7][1];
  screen[9][1] <= screen[8][1];
  screen[10][1] <= screen[9][1];

  screen[1][2] <= screen[0][2];
  screen[2][2] <= screen[1][2];
  screen[3][2] <= screen[2][2];
  screen[4][2] <= screen[3][2];
  screen[5][2] <= screen[4][2];
  screen[6][2] <= screen[5][2];
  screen[7][2] <= screen[6][2];
  screen[8][2] <= screen[7][2];
  screen[9][2] <= screen[8][2];
  screen[10][2] <= screen[9][2];

  screen[1][3] <= screen[0][3];
  screen[2][3] <= screen[1][3];
  screen[3][3] <= screen[2][3];
  screen[4][3] <= screen[3][3];
  screen[5][3] <= screen[4][3];
  screen[6][3] <= screen[5][3];
  screen[7][3] <= screen[6][3];
  screen[8][3] <= screen[7][3];
  screen[9][3] <= screen[8][3];
  screen[10][3] <= screen[9][3];

  screen[0][0] <= note[0];
  screen[0][1] <= note[1];
  screen[0][2] <= note[2];
  screen[0][3] <= note[3];

  y_position[0] <= 8'd0;
  y_position[1] <= 8'd20;
  y_position[2] <= 8'd40;
  y_position[3] <= 8'd60;
  y_position[4] <= 8'd80;
  y_position[5] <= 8'd100;
  y_position[6] <= 8'd120;
  y_position[7] <= 8'd140;
  y_position[8] <= 8'd160;
  y_position[9] <= 8'd180;
  y_position[10] <= 8'd200;
  end

  end
		

  always @(posedge clk)
  begin
    if (!resetn)
      colour <= 0;
		
	else if (interface)  
	begin
		if((((x >= (x_initial - 1'b1))
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
	end
	
	else if ( x>=125 && x<= 140)
		begin
			if (y== 9'd220 || y == 9'd221) colour <= 3'b000;
			else if((screen[y/20][3] && y>= y_position[y/20] && y<= (y_position[y/20]+10) && y <= 219) || (screen[y/20-1][3] && y>= y_position[y/20-1] && y<= (y_position[y/20-1]+10) && y <= 219)) colour <= 3'b101;
			else colour <= 3'b111;
		end
	else if ( x>=143 && x<= 158)
		begin
			if (y== 9'd220 || y == 9'd221) colour <= 3'b000;
			else if((screen[y/20][2] && y>= y_position[y/20] && y<= (y_position[y/20]+10) && y <= 219) || (screen[y/20-1][2] && y>= y_position[y/20-1] && y<= (y_position[y/20-1]+10) && y <= 219)) colour <= 3'b110;
			else colour <= 3'b111;
		end
	else if (x>=161 && x<= 176)
		begin
			if (y== 9'd220 || y == 9'd221) colour <= 3'b000;
			else if((screen[y/20][1] && y>= y_position[y/20] && y<= (y_position[y/20]+10) && y <= 219) || (screen[y/20-1][1] && y>= y_position[y/20-1] && y<= (y_position[y/20-1]+10) && y <= 219)) colour <= 3'b011;
			else colour <= 3'b111;
		end
	else if ( x>=179 && x<= 194)
		begin
		if (y== 9'd220 || y == 9'd221) colour <= 3'b000;
			else if((screen[y/20][0] && y>= y_position[y/20] && y<= (y_position[y/20]+10) && y <= 219) || (screen[y/20-1][0] && y>= y_position[y/20-1] && y<= (y_position[y/20-1]+10) && y <= 219))colour <= 3'b100;
			else colour <= 3'b111;
		end
     else if (x == 9'd123 || x == 9'd124 || x == 9'd141 || x == 9'd142|| x == 159 || x == 160 || x == 177 || x == 178 || x == 195 || x == 196)  // background, can be filled later.
      colour <= 3'b000;
	  else colour <= 3'b111;
	end
endmodule


module clock_divider_10(
    input clk, 
	 input resetn, 
    output reg out_clk = 0  //change to wire
);

reg [25:0] counter = 26'd0;

always @(posedge clk) 
begin
	if (!resetn)  begin out_clk <= 0; counter <= 0; end
		else
	 begin
    counter <= counter + 26'd1;
	 /*if (counter >= 26'd4166667 ) begin
        out_clk <= ~out_clk;
        counter <= 26'd0; */
	 if (counter >= 26'd5000000) begin
        out_clk <= ~out_clk;
        counter <= 26'd0; 
		  
    end
	 end
end







endmodule

