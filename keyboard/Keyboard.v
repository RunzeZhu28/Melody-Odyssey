module Keyboard(CLOCK_50, LEDR, KEY, PS2_DAT, PS2_CLK);
	input CLOCK_50;
	input [3:0] KEY;
	
	inout PS2_CLK;
	inout PS2_DAT;
	
	output[9:0]LEDR;
															
	KeyboardDecoder u0(.clk(CLOCK_50), .reset(~KEY[0]), 
							.PS2_CLK(PS2_CLK), .PS2_DAT(PS2_DAT), 
							.D(LEDR[0]), 
							.F(LEDR[1]), 
							.J(LEDR[2]),
							.K(LEDR[3]),
							.Restart(LEDR[4]), 
							.ResetGame(LEDR[5]), 
							.Player1(LEDR[6]),
							.Player2(LEDR[7]));
			
	
endmodule


module KeyboardDecoder(clk, reset, PS2_CLK, PS2_DAT, D, F, J, K, Restart, ResetGame, Player1, Player2);
	
	input clk, reset;
	
	inout PS2_CLK;
	inout PS2_DAT;
	
	wire[7:0]	key_data;
	wire key_pressed;	
	reg	[7:0]	RawData;
	output D, F, J, K, Restart, ResetGame, Player1, Player2;
	
	
	always @(posedge clk)
	begin
		if (reset == 1'b1)
			RawData <= 8'h00;
		else if (key_pressed==1'b1)
			RawData <= key_data;
	end
	
	
	control c1(.clk(clk), .reset(reset), 
			.Data(RawData), 
			.D(D), 
			.F(F), 
			.J(J),
			.K(K), 
			.restart(Restart),
			.RG(ResetGame), 	
			.Player1(Player1), 
			.Player2(Player2),
			.keypressed(key_pressed)
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

module control(clk, reset, Data, D, F, J, K, restart, RG, Player1, Player2, keypressed);
	input clk, reset, keypressed;
	output reg D, F, J, K, restart, RG, Player1, Player2;
	input [7:0] Data;
	
	reg [3:0] cur, nxt;
	
	localparam idle = 4'd0,
				D_pressed = 4'd1,
				F_pressed = 4'd2,
				J_pressed = 4'd3,
				K_pressed = 4'd4,
				restartgame = 4'd5,
				resetgame = 4'd6,
				p1 = 4'd7,
				p2 = 4'd8,
				load = 4'd9,
				wait1 = 4'd10;
	
	
	
	always@(*)
	begin
		case(cur)
			load: begin
				if(Data[7:0] == 8'h23)
					nxt = D_pressed;
				else if(Data[7:0] == 8'h2B)
					nxt = F_pressed;
				else if(Data[7:0] == 8'h3B)
					nxt = J_pressed;
				else if(Data[7:0] == 8'h42)
					nxt = K_pressed;
				else if(Data[7:0] == 8'h5A)
					nxt = restartgame;	//enter
				else if(Data[7:0] == 8'h76)
					nxt = resetgame;		//esc
				else if(Data[7:0] == 8'h16)
					nxt = p1;
				else if(Data[7:0] == 8'h1E)
					nxt = p2;
				else
					nxt = idle;
				end
				
			D_pressed: nxt = (Data == 8'hF0)? idle:D_pressed;
			F_pressed: nxt = (Data == 8'hF0)? idle:F_pressed;
			J_pressed: nxt = (Data == 8'hF0)? idle:J_pressed;
			K_pressed: nxt = (Data == 8'hF0)? idle:K_pressed;
			restartgame: nxt = (Data == 8'hF0)? idle:restartgame;
			resetgame: nxt = (Data == 8'hF0)? idle:resetgame;
			p1: nxt = (Data == 8'hF0)? idle:p1;
			p2: nxt = (Data == 8'hF0)? idle:p2;
			idle: nxt = keypressed?wait1: idle;
			wait1: nxt = keypressed?load: wait1;
			default: nxt = idle;
		endcase
	end
	
	always@(*)
	begin
		D = 1'b0;
		F = 1'b0;
		J = 1'b0;
		K = 1'b0;
		restart = 1'b0;
		RG = 1'b0;
		Player1 = 1'b0;
		Player2 = 1'b0;
		
		case(cur)
			D_pressed: begin
				D = 1'b1;
			end
			F_pressed: begin
				F = 1'b1;
			end
			J_pressed: begin
				J = 1'b1;
			end
			K_pressed: begin
				K = 1'b1;
			end
			restartgame: begin
				restart = 1'b1;
			end
			resetgame: begin	
				RG = 1'b1;
			end
			p1: begin
				Player1 = 1'b1;
			end
			p2: begin
				Player2 = 1'b1;
			end
		endcase
	end
	
	always@(posedge clk)
    begin
        if(reset)
            cur <= idle;
        else
            cur <= nxt;
    end
endmodule
