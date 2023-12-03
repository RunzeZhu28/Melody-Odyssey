module beat(clk, resetn, key_0, key_1,key_2,key_3, key_4, key_5, x, y, colour,HEX2);

  input clk, resetn, key_1, key_2,key_3, key_4, key_5, key_0;
  output reg [8:0] x;
  output reg [7:0] y;
  output reg [2:0] colour;
  output [6:0]HEX2;
  reg miss = 0;
  reg done = 0;
  reg press_1, press_2, press_3, press_0;
  wire ui, map, win, lose;
  wire [2:0] total_miss;
  
  control_path control_path_inst(clk, resetn, key_4, key_5, miss, done, ui, map, total_miss,win, lose); 

  wire [7:0] title_x ; //title coordinate 0-223
  wire [5:0] title_y ; //title y coordinate 0-31
  wire [6:0] start_x;//start coordinate 0-79
  wire [5:0] start_y;//start coordinate 0-31
  wire [6:0] win_result_x ; 
  wire [4:0] win_result_y ; 
  wire [6:0] lose_result_x ; 
  wire [4:0] lose_result_y ; 


assign title_x = ((x >= 10'd48) && (x < 10'd272)&&(y >= 10'd50)&&(y < 10'd82))? (x - 10'd48) : 0;

assign title_y = ((x >= 10'd48) && (x <  10'd272)&&(y >= 10'd50)&&(y < 10'd82))? (y - 10'd50) : 0;

assign start_x = ((x >= 10'd120) && (x < 10'd200)&&(y >= 10'd120)&&(y < 10'd152))? (x - 10'd120) : 0;

assign start_y = ((x >= 10'd120) && (x < 10'd200)&&(y >= 10'd120)&&(y < 10'd152))? (y - 10'd120) : 0;

assign win_result_x = ((x >= 10'd112) && (x < 10'd208)&&(y >= 10'd108)&&(y < 10'd132))? (x - 10'd112) : 0;

assign win_result_y = ((x >= 10'd112) && (x < 10'd208)&&(y >= 10'd108)&&(y < 10'd132))? (y - 10'd108) : 0;

assign lose_result_x = ((x >= 10'd112) && (x < 10'd208)&&(y >= 10'd108)&&(y < 10'd132))? (x - 10'd112) : 0;

assign lose_result_y = ((x >= 10'd112) && (x < 10'd208)&&(y >= 10'd108)&&(y < 10'd132))? (y - 10'd108) : 0;

  wire [3:0] note;
  reg [12:0] note_address;
  wire clk_50Hz;
  wire clk_10Hz;
  reg [3:0] screen [10:0];
  reg [3:0] temp [10:0];
  reg [3:0] counter;
  reg [7:0] y_position [10:0];
  reg [3:0] possible_miss = 4'b0;
  wire [2:0]health;
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
  
  assign health = 3'd7 - total_miss; 
  
 /*initial begin
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
  end*/
	
  notes U1(clk, note_address, note);

  clock_divider_50 U2(clk, resetn, clk_50Hz);
  clock_divider_10 U3(clk, resetn, clk_10Hz);
  vga_double_buffering U4(clk,   clk_50Hz, resetn, map, oy_0);
  vga_double_buffering_1 U5(clk, clk_50Hz, resetn, map,oy_1);
  vga_double_buffering_2 U6(clk, clk_50Hz, resetn, map,oy_2);
  vga_double_buffering_3 U7(clk, clk_50Hz, resetn, map,oy_3);
  vga_double_buffering_4 U8(clk, clk_50Hz, resetn, map,oy_4);
  vga_double_buffering_5 U9(clk, clk_50Hz, resetn, map,oy_5);
  vga_double_buffering_6 U10(clk, clk_50Hz, resetn, map,oy_6);
  vga_double_buffering_7 U11(clk, clk_50Hz, resetn, map,oy_7);
  vga_double_buffering_8 U12(clk, clk_50Hz, resetn, map,oy_8);
  vga_double_buffering_9 U13(clk, clk_50Hz, resetn, map,oy_9);
  vga_double_buffering_10 U14(clk, clk_50Hz, resetn,map, oy_10);
  hex_decoder U15({1'b0,health[2:0]}, HEX2);
 

reg [223:0] title [31:0] ; 
always@(posedge clk)
begin


title[0] <=224'h00000000000000000000000000000000000000000000000000000000;
title[1] <=224'h00000000000000000000000000000000000000000000000000000000;
title[2] <=224'h00000000000000000000000000000000000000000000000000000000;
title[3] <=224'h00000000000000000000000000000000000000000000000000000000;
title[4] <=224'h00000000000000000000000000000000000000000000000000000000;
title[5] <=224'h00000000008000000008000000000000000800000000000000000000;
title[6] <=224'hF00F00001F80000000780000000003C0007800000000000000000000;
title[7] <=224'h381C0000018000000018000000000C30001800000000000000000000;
title[8] <=224'h381C0000018000000018000000001818001800000000000000000000;
title[9] <=224'h381C0000018000000018000000001008001800000000000000000000;
title[10] <=224'h381C000001800000001800000000300C001800000000000000000000;
title[11] <=224'h382C000001800000001800000000300C001800000000000000000000;
title[12] <=224'h2C2C0000018000000018000000006004001800000000000000000000;
title[13] <=224'h2C2C03C0018003C007D87C3E0000600607D87C3E03E403E403C07C3E;
title[14] <=224'h2C2C0C3001800C300C381818000060060C381818061C061C0C301818;
title[15] <=224'h2C4C0818018008181818181000006006181818100C0C0C0C08181810;
title[16] <=224'h2C4C1808018018181818081000006006181808100C040C0418080810;
title[17] <=224'h264C300C0180100C30180C100000600630180C100C040C04300C0C10;
title[18] <=224'h264C300C0180300C3018042000006006301804200E000E00300C0420;
title[19] <=224'h264C300C0180300C30180620000060063018062007C007C0300C0620;
title[20] <=224'h268C3FFC0180300C30180620000060063018062001F001F03FFC0620;
title[21] <=224'h228C30000180300C3018024000002006301802400078007830000240;
title[22] <=224'h238C30000180300C301803400000300C30180340001C001C30000340;
title[23] <=224'h238C30000180300C301801400000300C30180140100C100C30000140;
title[24] <=224'h230C180401801818101801800000100810180180100C100C18040180;
title[25] <=224'h230C180801801818183801800000181818380180180C180C18080180;
title[26] <=224'h210C0E1801800C300C5E010000000C300C5E01001C181C180E180100;
title[27] <=224'hF13F03E01FF803C007900100000003C00790010013F013F003E00100;
title[28] <=224'h00000000000000000000010000000000000001000000000000000100;
title[29] <=224'h00000000000000000000020000000000000002000000000000000200;
title[30] <=224'h000000000000000000003E000000000000003E000000000000003E00;
title[31] <=224'h000000000000000000003C000000000000003C000000000000003C00;
end

reg [79:0] start [31:0] ;
always@(posedge clk)
begin
start[0] <=80'h00000000000000000000;
start[1] <=80'h00000000000000000000;
start[2] <=80'h00000000000000000000;
start[3] <=80'h00000000000000000000;
start[4] <=80'h00000000000000000000;
start[5] <=80'h00000000000000000000;
start[6] <=80'h0FFC3FFC03807FE03FFC;
start[7] <=80'h1CFC3184038018383184;
start[8] <=80'h383C2186038018182186;
start[9] <=80'h701C41820380180C4182;
start[10] <=80'h700C418204C0180C4182;
start[11] <=80'h700C018004C0180C0180;
start[12] <=80'h7000018004C0180C0180;
start[13] <=80'h7800018004C0180C0180;
start[14] <=80'h3E0001800C4018180180;
start[15] <=80'h1F800180086018300180;
start[16] <=80'h0FE0018008601FE00180;
start[17] <=80'h03F80180086018C00180;
start[18] <=80'h007C0180182018C00180;
start[19] <=80'h003C01801FF018600180;
start[20] <=80'h001E0180103018600180;
start[21] <=80'h600E0180103018600180;
start[22] <=80'h600E0180103018300180;
start[23] <=80'h700E0180201818300180;
start[24] <=80'h701C0180201818300180;
start[25] <=80'h781C0180201818180180;
start[26] <=80'h7E780180601C18180180;
start[27] <=80'h3FF007E0F83E7E1E07E0;
start[28] <=80'h00000000000000000000;
start[29] <=80'h00000000000000000000;
start[30] <=80'h00000000000000000000;
start[31] <=80'h00000000000000000000;
end

reg [95:0] win_result [23:0] ; 
always@(posedge clk)
begin

win_result[0] <=96'h000000000000000000000000;
win_result[1] <=96'h000000000000000000000000;
win_result[2] <=96'h000000000000000000000000;
win_result[3] <=96'h000000000000000000000000;
win_result[4] <=96'h000000000000000000000060;
win_result[5] <=96'hF9F000000000EF7060000060;
win_result[6] <=96'h70E000000000462060000060;
win_result[7] <=96'h70C000000000422000000060;
win_result[8] <=96'h38C000000000622000000060;
win_result[9] <=96'h398000104000622020000060;
win_result[10] <=96'h1D80F071C0002643E0778060;
win_result[11] <=96'h1F819830C00026406038C020;
win_result[12] <=96'h1F030C30C00027406030C040;
win_result[13] <=96'h0F060630C00027406030C040;
win_result[14] <=96'h0E060630C00039406030C040;
win_result[15] <=96'h0E060630C00039806030C000;
win_result[16] <=96'h0E060630C00019806030C000;
win_result[17] <=96'h0E060630C00019806030C000;
win_result[18] <=96'h0E030C30C00011806030C060;
win_result[19] <=96'h0E030C39E00011006030C060;
win_result[20] <=96'h1F80F01E80001103FC79E060;
win_result[21] <=96'h000000000000000000000000;
win_result[22] <=96'h000000000000000000000000;
win_result[23] <=96'h000000000000000000000000;
end

reg [95:0] lose_result [23:0] ; 
always@(posedge clk)
begin

lose_result[0] <= 96'h000000000000000000000000;
lose_result[1] <= 96'h000000000000000000000000;
lose_result[2] <= 96'h000000000000000000000000;
lose_result[3] <= 96'h000000000000000000000000;
lose_result[4] <= 96'h000000000000000000000000;
lose_result[5] <= 96'hF9F000000000F80000000000;
lose_result[6] <= 96'h70E000000000600000000000;
lose_result[7] <= 96'h70C000000000600000000000;
lose_result[8] <= 96'h38C000000000600000000000;
lose_result[9] <= 96'h398000104000600000000000;
lose_result[10] <= 96'h1D80F071C0006000F00FC078;
lose_result[11] <= 96'h1F819830C00060019838C18C;
lose_result[12] <= 96'h1F030C30C00060030C304104;
lose_result[13] <= 96'h0F060630C000600606304306;
lose_result[14] <= 96'h0E060630C0006006061C0306;
lose_result[15] <= 96'h0E060630C0006006060F03FE;
lose_result[16] <= 96'h0E060630C00060060603C300;
lose_result[17] <= 96'h0E060630C00060260620C300;
lose_result[18] <= 96'h0E030C30C00060230C20C182;
lose_result[19] <= 96'h0E030C39E00060430C31C184;
lose_result[20] <= 96'h1F80F01E8000FFC0F03F8078;
lose_result[21] <= 96'h000000000000000000000000;
lose_result[22] <= 96'h000000000000000000000000;
lose_result[23] <= 96'h000000000000000000000000;

end
  
  always @(posedge clk)
    if (!resetn && !clk_50Hz) begin
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
	 else if(ui) note_address <= 0;
    else //if(map && !done)   error here
      note_address <= note_address + 1;

		
  always@(posedge clk_50Hz)
  begin
  if (!map)
  begin
		counter <= 0;
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
  if(counter < 3'b11 && map) 
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
  
  else if (counter == 3'b011 && map) begin
  counter <= counter+1;
  temp[1][0] <= screen[0][0];
  temp[2][0] <= screen[1][0];
  temp[3][0] <= screen[2][0];
  temp[4][0] <= screen[3][0];
  temp[5][0] <= screen[4][0];
  temp[6][0] <= screen[5][0];
  temp[7][0] <= screen[6][0];
  temp[8][0] <= screen[7][0];
  temp[9][0] <= screen[8][0];
  temp[10][0] <= screen[9][0];

  temp[1][1] <= screen[0][1];
  temp[2][1] <= screen[1][1];
  temp[3][1] <= screen[2][1];
  temp[4][1] <= screen[3][1];
  temp[5][1] <= screen[4][1];
  temp[6][1] <= screen[5][1];
  temp[7][1] <= screen[6][1];
  temp[8][1] <= screen[7][1];
  temp[9][1] <= screen[8][1];
  temp[10][1] <= screen[9][1];

  temp[1][2] <= screen[0][2];
  temp[2][2] <= screen[1][2];
  temp[3][2] <= screen[2][2];
  temp[4][2] <= screen[3][2];
  temp[5][2] <= screen[4][2];
  temp[6][2] <= screen[5][2];
  temp[7][2] <= screen[6][2];
  temp[8][2] <= screen[7][2];
  temp[9][2] <= screen[8][2];
  temp[10][2] <= screen[9][2];

  temp[1][3] <= screen[0][3];
  temp[2][3] <= screen[1][3];
  temp[3][3] <= screen[2][3];
  temp[4][3] <= screen[3][3];
  temp[5][3] <= screen[4][3];
  temp[6][3] <= screen[5][3];
  temp[7][3] <= screen[6][3];
  temp[8][3] <= screen[7][3];
  temp[9][3] <= screen[8][3];
  temp[10][3] <= screen[9][3];
  
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
  end
  else if (counter == 3'b100 && map)begin
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
		
		
  always@(*)
  begin
	if(note_address == 285) done <= 1'b1;
	else done <= 1'b0;
  end
  

	always @(posedge clk)
	begin
	if(y_position[10] == 8'd200) 
	begin 
	press_0 <= 1'b0; 
	press_1 <= 1'b0; 
	press_2 <= 1'b0; 
	press_3 <= 1'b0; 
	end
	else 
	begin
	if(key_0) press_0 <= 1'b1;
	if(key_1) press_1 <= 1'b1;
	if(key_2) press_2 <= 1'b1;
	if(key_3) press_3 <= 1'b1;
	end
	end
	
	always@(posedge clk_50Hz)
	begin
 	if(y_position[10] >= 8'd210 && ((screen[10][1] && !press_1) || (screen[10][2] && !press_2) || (screen[10][3] && !press_3) ||(screen[10][0] && !press_0))) miss<= 1;
	else miss <= 0;
	end
		
//  always @(posedge clk)
//  begin
//	if(!resetn || ui) possible_miss <= 4'b0;
//	else if (map)
//	begin
//	if (y_position[10] == 8'd200 )
//		possible_miss[3] <= 1'b0;
//	else if(y_position[10] == 8'd204 && screen[10][3]  && !key_3)
//		possible_miss[3] <= 1'b1;
//	else if(y_position[10] > 8'd204 && key_3)
//		possible_miss[3] <= 1'b0;
//	else	possible_miss[3] = possible_miss[3];
//  end
//	end
//
// always@(posedge clk)
// begin
//	if (!resetn || ui) miss <= 0;
//	else if (y >=1)//_position[10] == 8'd216 && possible_miss[3] == 1'b1)
//		miss <= 1;
//	else miss <= 0;
// end
 
 reg [20:0] timer = 21'd0;

always @(posedge clk) 
begin
	if (!resetn)  begin  timer <= 0; end
		else 
	 begin
    timer <= timer + 21'd1;
	 if (timer == 21'd1666666) begin
        timer <= 21'd0; 
    end
	 end
end
 
  always @(posedge clk)
  begin
    if (!resetn)
      colour <= 0;
		
	else if (ui)  
	begin
		if((x >= 10'd47)&& (x < 10'd271)&& (y >= 10'd50) && (y < 10'd82)&& (title[title_y][10'd224 - title_x] == 1'b1))
			colour <= 3'b101;
 
		else if((x >= 10'd119)&& (x < 10'd199)&& (y >= 10'd120) && (y < 10'd152)&& (start[start_y][10'd80 - start_x] == 1'b1))
			colour <= 3'b100;
 
		else if((x >= 10'd119)&& (x < 10'd199)&& (y >= 10'd120) && (y < 10'd152)&& (start[start_y][10'd80 - start_x] == 1'b0))
			colour <= 3'b110;
		else
			colour <= 3'b111;
	end
	//if (y == 20 || y == 40 || y == 60 || y == 80 || y == 120 ||y ==140||y==160||y==180||y==200||y==220) colour <=3'b100;
	else if (map)
	begin
	if ( x>=125 && x<= 140)
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
			else if((screen[y/20][0] && y>= y_position[y/20] && y<= (y_position[y/20]+10) && y <= 219) || (screen[y/20-1][0] && y>= y_position[y/20-1] && y<= (y_position[y/20-1]+10) && y <= 219))colour <= 3'b010;
			else colour <= 3'b111;
		end
     else if (x == 9'd123 || x == 9'd124 || x == 9'd141 || x == 9'd142|| x == 159 || x == 160 || x == 177 || x == 178 || x == 195 || x == 196)  // background, can be filled later.
      colour <= 3'b000;
	else if ( x >= 9'd198 && x<= 9'd212)
	 begin
		if (x == 9'd198 || x ==9'd199 || x == 9'd211 || x== 9'd212)
		begin
			if (y>=19 && y <= 232) colour <= 3'b000;
			else colour <= 3'b111;
		end
		else if (y == 9'd19 || y == 9'd20 || y ==9'd231 || y == 9'd232)
			colour <= 3'b000;
		else if(y<=230 && (y>=231 - health * 30)) colour <= 3'b100;
		else colour <= 3'b111;
	 end 
	 else colour <= 3'b111;
	 
	end
	
	else if (win)
		begin
			if((x >= 10'd111)&& (x < 10'd207) && (y >= 10'd108) && (y < 10'd132)&& (win_result[win_result_y][10'd96 - win_result_x] == 1'b1))
				colour <= 3'b100;
			else
				colour <= 3'b111;
		end
	else if (lose)
		begin
			if((x >= 10'd111)&& (x < 10'd207) && (y >= 10'd108) && (y < 10'd132)&& (lose_result[lose_result_y][10'd96 - lose_result_x] == 1'b1))
				colour <= 3'b100;
			else
				colour <= 3'b111;
		end
	end
endmodule


module clock_divider_10(
    input clk, 
	 input resetn, 
    output reg out_clk = 0  
);

reg [25:0] counter = 26'd0;

always @(posedge clk) 
begin
	if (!resetn)  begin out_clk <= 0; counter <= 0; end
		else
	 begin
    counter <= counter + 26'd1;
	 if (counter >= 26'd5000000) begin
        out_clk <= ~out_clk;
        counter <= 26'd0; 
		  
    end
	 end
end



endmodule
