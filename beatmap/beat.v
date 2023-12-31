module beat(clk, resetn, x, y, colour);

  input clk, resetn;
  output reg [8:0] x;
  output reg [7:0] y;
  output reg [2:0] colour;

  parameter height = 240;
  parameter width = 320;
  parameter notes_height = 10;
  parameter bpm = 180;
  parameter speed = 20;

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
  end
	
  notes U1(clk, note_address, note);

  clock_divider_50 U2(clk, resetn, clk_50Hz);
  clock_divider_10 U3(clk, resetn, clk_10Hz);
  vga_double_buffering U4(clk,resetn, oy_0);
  vga_double_buffering_1 U5(clk,resetn, oy_1);
  vga_double_buffering_2 U6(clk,resetn, oy_2);
  vga_double_buffering_3 U7(clk,resetn, oy_3);
  vga_double_buffering_4 U8(clk,resetn, oy_4);
  vga_double_buffering_5 U9(clk,resetn, oy_5);
  vga_double_buffering_6 U10(clk,resetn, oy_6);
  vga_double_buffering_7 U11(clk,resetn, oy_7);
  vga_double_buffering_8 U12(clk,resetn, oy_8);
  vga_double_buffering_9 U13(clk,resetn, oy_9);
  vga_double_buffering_10 U14(clk,resetn, oy_10);
  
  always @(posedge clk)
    if (!resetn) begin
      x <= 0;
      y <= 0;
    end
    else if (x < width - 1) begin
      x <= x + 1;
    end 
    else begin
      x <= 0;
      if (y < height - 1) begin
        y <= y + 1;
      end else begin
        y <= 0;
      end
    end

  always @(posedge clk_10Hz)
    if (!resetn)
      note_address <= 0;
    else
      note_address <= note_address + 1;

		
  always@(negedge clk_50Hz)
  begin
  if(counter < 3'b100) 
  begin
  counter <= counter+1;
   //y_position[0] <= y_position[0]+ 4;
	//y_position[1] <= y_position[1]+ 4;
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
  
  else if (counter == 3'b100)begin
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

