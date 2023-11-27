module notes(
  input clk,
  input [12:0] address,
  output reg [3:0] data
);

  reg [3:0] notes [0:16];

  initial begin
    notes[0] = 4'b1111;
    notes[1] = 4'b1010;
	 notes[2] = 4'b0110;
	 notes[3] = 4'b0101;
	 notes[4] = 4'b1010;
	 notes[5] = 4'b0101;
	 notes[6] = 4'b1111;
    notes[7] = 4'b1010;
	 notes[8] = 4'b0011;
	 notes[9] = 4'b1010;
	 notes[10] = 4'b0101;
	 notes[11] = 4'b1010;
	 notes[12] = 4'b0101;
	 notes[13] = 4'b1010;
	 notes[14] = 4'b0101;
	 notes[15] = 4'b1010;
	 notes[16] = 4'b0101;
  end

  always @(posedge clk) begin
    data = notes[address];
  end

endmodule
