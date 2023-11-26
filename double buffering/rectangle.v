module rectangle(
  input clk,
  input resetn,
  input [8:0] x,
  input [7:0] y,
  output reg [8:0] ox,
  output reg [7:0] oy,
  output reg [2:0] colour);

  reg [20:0] counter = 21'b0;
  reg [3:0] white_counter = 4'b0;

  always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
      counter <= 21'b0;
    end
    else begin
		if (counter == 21'd833333)
		begin
			counter <= 0;
		end
		else
      counter <= counter + 1;		
    end
  end

  always @(posedge clk or negedge resetn) 
  begin
    if (!resetn) begin
      ox <= 9'b0;
      oy <= 8'b0;
		white_counter <= 0;
    end
	 else if (counter == 21'd833333) white_counter <= 0;
    
	else if(counter <= 21'b10101111) begin
      ox <= x + counter[3:0];
      oy <= y + counter[7:4];
		colour <= 3'b101;
		end
	 else if(counter >= 21'd833312) begin
	   ox <= x + white_counter;
		white_counter <= white_counter +1;
		oy <= y;
		colour <= 3'b000;
		end
	 /*else begin 
	 colour <= 3'b000;
	 ox <= x;
	 oy <= y;
	 end*/
  end


endmodule