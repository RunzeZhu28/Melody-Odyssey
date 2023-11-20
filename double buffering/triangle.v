module triangle(
  input clk,
  input resetn,
  input [8:0] x,
  input [7:0] y,
  output reg [8:0] ox,
  output reg [7:0] oy
);

  reg [8:0] counter = 9'b0;
  reg wait_for_change = 1'b0;
  reg [7:0] prev_y = 8'b0;

  always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
      counter <= 9'b0;
      wait_for_change <= 1'b0;
      prev_y <= 8'b0;
    end
    else begin
      if (y != prev_y) begin
        if (wait_for_change) begin
          wait_for_change <= 1'b0;
        end
      end
      else if (!wait_for_change && counter < 9'b101001011) begin
        counter <= counter + 1;
      end
      else if (counter == 9'b101001011) begin
        wait_for_change <= 1'b1;
		  counter <= 9'b0;
      end

      prev_y <= y;
    end
  end

  always @(posedge clk or negedge resetn) 
  begin
    if (!resetn) begin
      ox <= 9'b0;
      oy <= 8'b0;
    end
    else begin
      ox <= x + counter[3:0];
      oy <= y + counter[8:4];
    end
  end

endmodule
