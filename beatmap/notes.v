module notes(
  input clk,
  input [12:0] address,
  output reg [3:0] data
);

  reg [3:0] notes [0:79];

  initial begin
    notes[0] = 4'b1000;
    notes[1] = 4'b0100;
	 notes[2] = 4'b0010;
	 notes[3] = 4'b0001;
	 notes[4] = 4'b1100;
	 notes[5] = 4'b0101;
	 notes[6] = 4'b1010;
    notes[7] = 4'b0101;
	 notes[8] = 4'b0011;
	 notes[9] = 4'b1010;
	 notes[10] = 4'b0101;
	 notes[11] = 4'b1010;
	 notes[12] = 4'b0101;
	 notes[13] = 4'b1010;
	 notes[14] = 4'b0101;
	 notes[15] = 4'b1010;
	 notes[16] = 4'b0101;
	 notes[17] = 4'b0101;
	 notes[18] = 4'b1010;
	 notes[19] = 4'b0101;
	 notes[20] = 4'b1010;
	 notes[21] = 4'b0101;
	 notes[22] = 4'b1010;
	 notes[23] = 4'b0101;
	 notes[24] = 4'b0101;
	 notes[25] = 4'b1010;
	 notes[26] = 4'b0101;
	 notes[27] = 4'b1010;
	 notes[28] = 4'b0101;
	 notes[29] = 4'b1010;
	 notes[30] = 4'b0101;
	 notes[31] = 4'b1010;
	 notes[32] = 4'b0101;
	 notes[33] = 4'b1010;
	 notes[34] = 4'b0101;
	 notes[35] = 4'b1010;
	 notes[36] = 4'b0101;
	 notes[37] = 4'b0101;
	 notes[38] = 4'b1010;
	 notes[39] = 4'b0101;
	 notes[40] = 4'b0101;
	 notes[41] = 4'b1010;
	 notes[42] = 4'b0101;
	 notes[43] = 4'b1010;
	 notes[44] = 4'b0101;
	 notes[45] = 4'b1010;
	 notes[46] = 4'b0101;
	 notes[47] = 4'b0101;
	 notes[48] = 4'b1010;
	 notes[49] = 4'b0101;
	 notes[50] = 4'b1010;
	 notes[51] = 4'b0101;
	 notes[52] = 4'b1010;
	 notes[53] = 4'b0101;
	 notes[54] = 4'b0101;
	 notes[55] = 4'b1010;
	 notes[56] = 4'b0101;
	 notes[57] = 4'b1010;
	 notes[58] = 4'b0101;
	 notes[59] = 4'b1010;
	 notes[60] = 4'b0101;
	 notes[61] = 4'b1010;
	 notes[62] = 4'b0101;
	 notes[63] = 4'b1010;
	 notes[64] = 4'b0101;
	 notes[65] = 4'b1010;
	 notes[66] = 4'b0101;
	 notes[67] = 4'b0101;
	 notes[68] = 4'b1010;
	 notes[69] = 4'b0101;
	 notes[70] = 4'b0101;
	 notes[71] = 4'b1010;
	 notes[72] = 4'b0101;
	 notes[73] = 4'b1010;
	 notes[74] = 4'b0101;
	 notes[75] = 4'b1010;
	 notes[76] = 4'b0101;
	 notes[77] = 4'b0101;
	 notes[78] = 4'b1010;
	 notes[79] = 4'b0101;
  end
 

  always @(posedge clk) begin
    data = notes[address];
  end

endmodule
