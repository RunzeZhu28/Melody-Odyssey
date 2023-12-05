module Keyboard(CLOCK_50, LEDR, KEY, PS2_DAT, PS2_CLK);
	input CLOCK_50;
	input KEY;
	
	inout PS2_CLK;
	inout PS2_DAT;
	
	output[9:0]LEDR;
															
	KeyboardDecoder u0(.clk(CLOCK_50), .reset(~KEY), 
							.PS2_CLK(PS2_CLK), .PS2_DAT(PS2_DAT), 
							.D(LEDR[0]), 
							.F(LEDR[1]), 
							.J(LEDR[2]),
							.K(LEDR[3]),
							.Restart(LEDR[4]), 
							.ResetGame(LEDR[5]), 
							.Player1(LEDR[6]),
							.Player2(LEDR[7]),
							.Player3(LEDR[8]));
			
	
endmodule


module KeyboardDecoder(clk, reset, PS2_CLK, PS2_DAT, D, F, J, K, Restart, ResetGame, Player1, Player2, Player3);
	
	input clk, reset;
	
	inout PS2_CLK;
	inout PS2_DAT;
	
	wire[7:0]	key_data;
	wire key_pressed;	
	reg	[7:0]	RawData;
	
	wire [8:0] PS2_Key_Pressed;
	output reg D, F, J, K, Restart, ResetGame, Player1, Player2, Player3;
	
	always@(posedge clk) begin
		if (reset) begin
			D <= 1'b0;
			F <= 1'b0;
			J <= 1'b0;
			K <= 1'b0;
			Restart <= 1'b0;
			ResetGame <= 1'b0;
			Player1 <= 1'b0;
			Player2 <= 1'b0;
			Player3 <= 1'b0;
		end
		else begin
			D <= PS2_Key_Pressed[0];
			F <= PS2_Key_Pressed[1];
			J <= PS2_Key_Pressed[2];
			K <= PS2_Key_Pressed[3];
			Restart <= PS2_Key_Pressed[4];
			ResetGame <= PS2_Key_Pressed[5];
			Player1 <= PS2_Key_Pressed[6];
			Player2 <= PS2_Key_Pressed[7];
			Player3 <= PS2_Key_Pressed[8];
		end
	end
	
	
	always @(posedge clk)
	begin
		if (reset == 1'b1)
			RawData <= 8'h00;
		else if (key_pressed==1'b1)
			RawData <= key_data;
	end
	
	
	PS2_Keyboard c1(.PS2_Clock(clk), 
			.PS2_Data(RawData), 
			.reset(reset), 
			
			.PS2_Key_Pressed(PS2_Key_Pressed)
	);
	
	PS2_Controller PS2 (
	.CLOCK_50(clk),
	.reset(reset),
	.PS2_CLK(PS2_CLK),
 	.PS2_DAT(PS2_DAT),
	.received_data(key_data),
	.received_data_en(key_pressed)
	);

endmodule


	
module PS2_Keyboard(
    input PS2_Clock,
    input [7: 0] PS2_Data,
	 input reset,


    output reg [8:0] PS2_Key_Pressed
);
    parameter ENTER = 8'h5A;        //PS2_Key_Pressed[0] = 1
    parameter D     = 8'h23;        //PS2_Key_Pressed[1] = 1
    parameter F     = 8'h2B;        //PS2_Key_Pressed[2] = 1
    parameter J     = 8'h3B;        //PS2_Key_Pressed[3] = 1
    parameter K     = 8'h42;        //PS2_Key_Pressed[4] = 1
    parameter ESC   = 8'h76;        //PS2_Key_Pressed[5] = 1
	 parameter Break = 8'hF0;        //PS2_Key_Pressed[i] = 0 when Break is detected
	 parameter Key1  = 8'h16;
	 parameter Key2  = 8'h1E;
	 parameter Key3  = 8'h26;

    reg [15:0] PS2_Data_Reg;
	 
//	 reg [5:0] PS2_Key_Pressed;
//	 assign w[0] = PS2_Key_Pressed[0];
//	 assign w[1] = PS2_Key_Pressed[1];
//	 assign w[2] = PS2_Key_Pressed[2];
//	 assign w[3] = PS2_Key_Pressed[3];
//	 assign w[4] = PS2_Key_Pressed[4];
//	 assign w[5] = PS2_Key_Pressed[5];

always@(posedge PS2_Clock) begin
	if (reset) begin
		PS2_Data_Reg <= 16'b0;
	end
	else begin
      PS2_Data_Reg <= {PS2_Data_Reg[7:0], PS2_Data};
	end
end

always@(posedge PS2_Clock) begin
	if  (PS2_Data_Reg[15:8] == Break) begin
            case (PS2_Data_Reg[7:0])
                ENTER: begin
                    PS2_Key_Pressed[0] <= 1'b0;
                end
                D: begin
                    PS2_Key_Pressed[1] <= 1'b0;
                end
                F: begin
                    PS2_Key_Pressed[2] <= 1'b0;
                end
                J: begin
                    PS2_Key_Pressed[3] <= 1'b0;
                end
                K: begin
                    PS2_Key_Pressed[4] <= 1'b0;
                end
                ESC: begin
                    PS2_Key_Pressed[5] <= 1'b0;
                end
					 Key1: begin
						  PS2_Key_Pressed[6] <= 1'b0;
					 end
					 Key2: begin
						  PS2_Key_Pressed[7] <= 1'b0;
					 end
					 Key3: begin
						  PS2_Key_Pressed[8] <= 1'b0;
					 end
					 Break: begin
						  
					 end
                //default: begin    
                //dnt know whether it is necessary to have a default case here
            endcase
	end
	else begin
            case (PS2_Data_Reg[7:0])
                ENTER: begin
                    PS2_Key_Pressed[0] <= 1'b1;
                end
                D: begin
                    PS2_Key_Pressed[1] <= 1'b1;
                end
                F: begin
                    PS2_Key_Pressed[2] <= 1'b1;
                end
                J: begin
                    PS2_Key_Pressed[3] <= 1'b1;
                end
                K: begin
                    PS2_Key_Pressed[4] <= 1'b1;
                end
                ESC: begin
                    PS2_Key_Pressed[5] <= 1'b1;
                end
					 Key1: begin
						  PS2_Key_Pressed[6] <= 1'b1;
					 end
					 Key2: begin
						  PS2_Key_Pressed[7] <= 1'b1;
					 end
					 Key3: begin
						  PS2_Key_Pressed[8] <= 1'b1;
					 end
					 Break: begin
						  PS2_Key_Pressed <= 9'b000000;
					 end
            default: begin
                    PS2_Key_Pressed <= 9'b000000;
                end
            endcase
	end

end

endmodule
