module notes(
  input clk,
  input [12:0] address,
  output reg [3:0] data
);

  reg [3:0] notes [0:273];

  initial begin
    notes[0] = 4'b0000;
    notes[1] = 4'b0000;
	 notes[2] = 4'b0000;
	 notes[3] = 4'b0000;
	 
	 notes[4] = 4'b1000; //start
	 notes[5] = 4'b0100;
	 notes[6] = 4'b0010;
    notes[7] = 4'b0001;
	 
	 notes[8] = 4'b0011;
	 notes[9] = 4'b0000;
	 notes[10] = 4'b0101;
	 notes[11] = 4'b0000;
	 
	 notes[12] = 4'b0101;
	 notes[13] = 4'b0000;
	 notes[14] = 4'b0000;
	 notes[15] = 4'b0000;
	 
	 notes[16] = 4'b0101;
	 notes[17] = 4'b0101;
	 notes[18] = 4'b1010;
	 notes[19] = 4'b0101;
	 
	 notes[20] = 4'b1010;
	 notes[21] = 4'b0101;
	 notes[22] = 4'b1010;
	 notes[23] = 4'b0101; 
	 
	 notes[24] = 4'b0101;
	 notes[25] = 4'b0100;
	 notes[26] = 4'b1001;
	 notes[27] = 4'b0000;
	 
	 notes[28] = 4'b0110;
	 notes[29] = 4'b0000;
	 notes[30] = 4'b0000;
	 notes[31] = 4'b0000;
	 
	 notes[32] = 4'b0101;
	 notes[33] = 4'b0110;
	 notes[34] = 4'b0110;
	 notes[35] = 4'b0101;
	 
	 notes[36] = 4'b1010;
	 notes[37] = 4'b0101;
	 notes[38] = 4'b0110;
	 notes[39] = 4'b1001;
	 
	 notes[40] = 4'b0101;
	 notes[41] = 4'b0000;
	 notes[42] = 4'b0101;
	 notes[43] = 4'b0110;
	 notes[44] = 4'b0000;
	 notes[45] = 4'b1010;
	 notes[46] = 4'b0101;
	 notes[47] = 4'b0000;
	 
	 
	 notes[48] = 4'b0000;
	 notes[49] = 4'b0000;
	 notes[50] = 4'b0101;
	 notes[51] = 4'b0000;
	 
	 notes[52] = 4'b1010;
	 notes[53] = 4'b0101;
	 notes[54] = 4'b0101;
	 notes[55] = 4'b0000;
	 
	 notes[56] = 4'b0001;
	 notes[57] = 4'b0000;
	 notes[58] = 4'b0110;
	 notes[59] = 4'b1001;
	 
	 notes[60] = 4'b0000;
	 notes[61] = 4'b1010;
	 notes[62] = 4'b0101;
	 notes[63] = 4'b0000;

	 notes[64] = 4'b0000;	 
	 notes[65] = 4'b0100;
	 notes[66] = 4'b0010;
	 notes[67] = 4'b1000;
	 
	 notes[68] = 4'b1000;	 
	 notes[69] = 4'b0100;
	 notes[70] = 4'b0010;
	 notes[71] = 4'b0001;
	
    notes[72] = 4'b0100;
	 notes[73] = 4'b1001;
	 notes[74] = 4'b0101;
	 notes[75] = 4'b0000;
	 
	 
	 notes[76] = 4'b0110;
	 notes[77] = 4'b0101;
	 notes[78] = 4'b1010;
	 notes[79] = 4'b0101;
		
	 notes[80] = 4'b1100;
	 notes[81] = 4'b0011;
	 notes[82] = 4'b0110;
	 notes[83] = 4'b1001;
	 
	 notes[84] = 4'b1000;
	 notes[85] = 4'b0110; 
	 notes[86] = 4'b0011;
	 notes[87] = 4'b0000;
	 
	 notes[88] = 4'b1100;
	 notes[89] = 4'b1001;
	 notes[90] = 4'b1010;
	 notes[91] = 4'b1100;
	 
	 notes[92] = 4'b0001;
	 notes[93] = 4'b1000;
	 notes[94] = 4'b0100;
	 notes[95] = 4'b0010;
	 
	 notes[96] = 4'b1100;
	 notes[97] = 4'b1001;
	 notes[98] = 4'b1010;
	 notes[99] = 4'b0100;
	 
	 notes[100] = 4'b1001;
	 notes[101] = 4'b0000;
	 notes[102] = 4'b0101;
	 notes[103] = 4'b1100;
	 
	 notes[104] = 4'b0000;
	 notes[105] = 4'b1010;
	 notes[106] = 4'b1010;
	 notes[107] = 4'b1001;
	 
			notes[108] = 4'b1010;
notes[109] = 4'b0101;
notes[110] = 4'b0110;
notes[111] = 4'b1001;
notes[112] = 4'b0110;
notes[113] = 4'b0101;
notes[114] = 4'b1010;
notes[115] = 4'b0101;
notes[116] = 4'b1100;
notes[117] = 4'b0011;
notes[118] = 4'b0110;
notes[119] = 4'b1001;
notes[120] = 4'b1000;
notes[121] = 4'b0110;
notes[122] = 4'b0011;
notes[123] = 4'b0000;
notes[124] = 4'b1100;
notes[125] = 4'b1001;
notes[126] = 4'b1010;
notes[127] = 4'b1100;
notes[128] = 4'b0001;
notes[129] = 4'b1000;
notes[130] = 4'b0100;
notes[131] = 4'b0010;
notes[132] = 4'b1100;
notes[133] = 4'b1001;
notes[134] = 4'b1010;
notes[135] = 4'b0100;
notes[136] = 4'b1001;
notes[137] = 4'b0000;
notes[138] = 4'b0101;
notes[139] = 4'b1100;
notes[140] = 4'b0000;
notes[141] = 4'b1010;
notes[142] = 4'b1010;
notes[143] = 4'b1001;
notes[144] = 4'b0110;
notes[145] = 4'b0101;
notes[146] = 4'b1010;
notes[147] = 4'b0101;
notes[148] = 4'b1100;
notes[149] = 4'b0011;
notes[150] = 4'b0110;
notes[151] = 4'b1001;
notes[152] = 4'b1000;
notes[153] = 4'b0110;
notes[154] = 4'b0011;
notes[155] = 4'b0000;
notes[156] = 4'b1100;
notes[157] = 4'b1001;
notes[158] = 4'b1010;
notes[159] = 4'b1100;
notes[160] = 4'b0001;
notes[161] = 4'b1000;
notes[162] = 4'b0100;
notes[163] = 4'b0010;
notes[164] = 4'b1100;
notes[165] = 4'b1001;
notes[166] = 4'b1010;
notes[167] = 4'b0100;
notes[168] = 4'b1001;
notes[169] = 4'b0000;
notes[170] = 4'b0101;
notes[171] = 4'b1100;
notes[172] = 4'b0000;
notes[173] = 4'b1010;
notes[174] = 4'b1010;
notes[175] = 4'b1001;
notes[176] = 4'b1100;
notes[177] = 4'b1001;
notes[178] = 4'b1010;
notes[179] = 4'b0100;
notes[180] = 4'b1001;
notes[181] = 4'b0000;
notes[182] = 4'b0101;
notes[183] = 4'b1100;
notes[184] = 4'b0000;
notes[185] = 4'b1010;
notes[186] = 4'b1010;
notes[187] = 4'b1001;
notes[188] = 4'b0110;
notes[189] = 4'b0101;
notes[190] = 4'b1010;
notes[191] = 4'b0101;
notes[192] = 4'b1100;
notes[193] = 4'b0011;
notes[194] = 4'b0110;
notes[195] = 4'b1001;
notes[196] = 4'b1000;
notes[197] = 4'b0110;
notes[198] = 4'b0011;
notes[199] = 4'b0000;
notes[200] = 4'b1100;
notes[201] = 4'b1001;
notes[202] = 4'b1010;
notes[203] = 4'b1100;
notes[204] = 4'b0001;
notes[205] = 4'b1000;
notes[206] = 4'b0100;
notes[207] = 4'b0010;
notes[208] = 4'b1100;
notes[209] = 4'b1001;
notes[210] = 4'b1010;
notes[211] = 4'b0100;
notes[212] = 4'b1001;
notes[213] = 4'b0000;
notes[214] = 4'b0101;
notes[215] = 4'b1100;
notes[216] = 4'b0000;
notes[217] = 4'b1010;
notes[218] = 4'b1010;
notes[219] = 4'b1001;
notes[220] = 4'b1100;
notes[221] = 4'b1001;
notes[222] = 4'b1010;
notes[223] = 4'b0100;
notes[224] = 4'b1001;
notes[225] = 4'b0000;
notes[226] = 4'b0101;
notes[227] = 4'b1100;
notes[228] = 4'b0000;
notes[229] = 4'b1010;
notes[230] = 4'b1010;
notes[231] = 4'b1001;
notes[232] = 4'b0110;
notes[233] = 4'b0101;
notes[234] = 4'b1010;
notes[235] = 4'b0101;
notes[236] = 4'b1100;
notes[237] = 4'b0011;
notes[238] = 4'b0110;
notes[239] = 4'b1001;
notes[240] = 4'b1000;
notes[241] = 4'b0110;
notes[242] = 4'b0011;
notes[243] = 4'b0000;
notes[244] = 4'b1100;
notes[245] = 4'b1001;
notes[246] = 4'b1010;
notes[247] = 4'b1100;
notes[248] = 4'b0001;
notes[249] = 4'b1000;
notes[250] = 4'b0100;
notes[251] = 4'b0010;
notes[252] = 4'b1100;
notes[253] = 4'b1001;
notes[254] = 4'b1010;
notes[255] = 4'b0100;
notes[256] = 4'b1001;
notes[257] = 4'b0110;
notes[258] = 4'b1100;
notes[259] = 4'b0011;
notes[260] = 4'b1100;
notes[261] = 4'b1010;
notes[262] = 4'b1010;
notes[263] = 4'b1001;
notes[264] = 4'b1001; 
notes[265] = 4'b1001;
notes[266] = 4'b0110;
notes[267] = 4'b1000;
notes[268] = 4'b0110;
notes[269] = 4'b1001;
notes[270] = 4'b1100;
notes[271] = 4'b1010;
notes[272] = 4'b1001;
notes[273] = 4'b1001; 
  end	
 

  always @(posedge clk) begin
    data = notes[address];
  end

endmodule
