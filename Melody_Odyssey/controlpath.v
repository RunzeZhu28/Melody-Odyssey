module control_path(clk, resetn, key_1, key_2, miss, done, interface, map, total_miss, win, lose); 

input clk, resetn, key_1, key_2, miss,done;
output reg interface, map, win, lose;
output reg [2:0] total_miss;

parameter IDLE =5'b00000,
IDLE_WAIT = 5'b00001,
STATE_0 = 5'b00010,
STATE_0_WAIT = 5'b00011,
STATE_1 = 5'b00100,
STATE_1_WAIT = 5'b00101,
STATE_2 = 5'b00110,
STATE_2_WAIT = 5'b00111,
STATE_3 = 5'b01000,
STATE_3_WAIT = 5'b01001,
STATE_4 = 5'b01010,
STATE_4_WAIT = 5'b01011,
STATE_5 = 5'b01100,
STATE_5_WAIT = 5'b01101,
STATE_6 = 5'b01110,
RESULT_1 = 5'b01111,
RESULT_2 = 5'b10000,

RESULT_1_WAIT = 5'b10001,
RESULT_2_WAIT = 5'b10010;

reg [3:0] current, next;

always@(*)
begin
if (!resetn)
	current <= IDLE;
else
	current <= next;
end

always@(posedge clk)
begin
	case(current)
		IDLE: next = key_1?IDLE_WAIT:IDLE;
		
		IDLE_WAIT: next = key_1?STATE_0:IDLE_WAIT;
		
		STATE_0 : begin 
			if (key_2)
				next = IDLE;
			else if (done) next = RESULT_2; 
			else next = miss? STATE_0_WAIT : STATE_0;
			end
			
		STATE_0_WAIT:
		begin 
			if (key_2)
				next = IDLE;
			else if (done) next = RESULT_2; 
			else next = miss? STATE_0_WAIT:STATE_1;
			end
			
		STATE_1 : begin 
			if (key_2)
				next = IDLE;
			else if (done) next = RESULT_2; 	
			else next = miss? STATE_1_WAIT : STATE_1;
			end
			
		STATE_1_WAIT:
		begin 
			if (key_2)
				next = IDLE;
			else if (done) next = RESULT_2; 
			else next = miss? STATE_1_WAIT:STATE_2;
			end
			
		STATE_2 : begin 
			if (key_2)
				next = IDLE;
			else if (done) next = RESULT_2; 
			else next = miss? STATE_2_WAIT : STATE_2;
			end
			
		STATE_2_WAIT:
		begin 
			if (key_2)
				next = IDLE;
			else if (done) next = RESULT_2; 
			else next = miss? STATE_2_WAIT:STATE_3;
			end
			
		STATE_3 : begin 
			if (key_2)
				next = IDLE;
			else if (done) next = RESULT_2; 
			else next = miss? STATE_3_WAIT : STATE_3;
			end
		
		STATE_3_WAIT:
		begin 
			if (key_2)
				next = IDLE;
			else if (done) next = RESULT_2; 
			else next = miss? STATE_3_WAIT:STATE_4;
			end
			
		STATE_4 : begin 
			if (key_2)
				next = IDLE;
			else if (done) next = RESULT_2; 
			else next = miss? STATE_4_WAIT : STATE_4;
			end
			
		STATE_4_WAIT:
		begin 
			if (key_2)
				next = IDLE;
			else if (done) next = RESULT_2; 
			else next = miss? STATE_4_WAIT:STATE_5;
			end
			
		STATE_5 : begin 
			if (key_2)
				next = IDLE;
			else if (done) next = RESULT_2; 
			else next = miss? STATE_5_WAIT : STATE_5;
			end
			
		STATE_5_WAIT:
		begin 
			if (key_2)
				next = IDLE;
			else if (done) next = RESULT_2; 
			else next = miss? STATE_5_WAIT:STATE_6;
			end
			
		STATE_6 : begin 
			if (key_2)
				next = IDLE;
			else if (done) next = RESULT_2; 
			else next = miss? RESULT_1 : STATE_6;
			end
			
		RESULT_1: next = key_2? RESULT_1_WAIT: RESULT_1;
		
		RESULT_1_WAIT: next = key_2?RESULT_1_WAIT:IDLE;
		
		RESULT_2: next = key_2? RESULT_2_WAIT: RESULT_2;	
		
		RESULT_2_WAIT: next = key_2?RESULT_2_WAIT:IDLE;
			
	endcase
end

always@(*)
begin
	
	case(current)
	IDLE: begin 
	interface <= 1'b1;   
	map <= 1'b0;
	win <= 1'b0;
	lose <= 1'b0;
	total_miss <= 3'b0;	
	end
	
	IDLE_WAIT: begin 
	interface <= 1'b1;   
	map <= 1'b0;
	win <= 1'b0;
	lose <= 1'b0;
	total_miss <= 3'b0;	
	end
	
	STATE_0: begin 
	interface <= 1'b0;
	win <= 1'b0;
	lose <= 1'b0;
	map <= 1'b1; 
	total_miss <= 3'd0; 
	end
	
	STATE_0_WAIT:begin
	interface <= 1'b0;
	win <= 1'b0;
	lose <= 1'b0;
	map <= 1'b1; 
	total_miss <= 3'd0; 
	end
	
	STATE_1: begin 
	interface <= 1'b0;
	win <= 1'b0;
	lose <= 1'b0;
	map <= 1'b1;  
	total_miss <= 3'd1; 
	end
	
	STATE_1_WAIT:begin
	interface <= 1'b0;
	win <= 1'b0;
	lose <= 1'b0;
	map <= 1'b1; 
	total_miss <= 3'd2; 
	end
	
	STATE_2: begin 
	interface <= 1'b0;
	win <= 1'b0;
	lose <= 1'b0;
	map <= 1'b1; 
	total_miss <= 3'd2; 
	end
	
	STATE_2_WAIT:begin
	interface <= 1'b0;
	win <= 1'b0;
	lose <= 1'b0;
	map <= 1'b1; 
	total_miss <= 3'd3; 
	end
	
	STATE_3:begin 
	interface <= 1'b0;
	win <= 1'b0;
	lose <= 1'b0;
	map <= 1'b1;  
	total_miss <= 3'd3;
	end
	
	STATE_3_WAIT:begin
	interface <= 1'b0;
	win <= 1'b0;
	lose <= 1'b0;
	map <= 1'b1; 
	total_miss <= 3'd4; 
	end
	
	STATE_4: begin 
	interface <= 1'b0;
	win <= 1'b0;
	lose <= 1'b0;
	map <= 1'b1; 
	total_miss <= 3'd4; 
	end
	
	STATE_4_WAIT:begin
	interface <= 1'b0;
	win <= 1'b0;
	lose <= 1'b0;
	map <= 1'b1; 
	total_miss <= 3'd5; 
	end
	
	STATE_5: begin 
	interface <= 1'b0;
	win <= 1'b0;
	lose <= 1'b0;
	map <= 1'b1;  
	total_miss <= 3'd5; 
	end
	
	STATE_5_WAIT:begin
	interface <= 1'b0;
	win <= 1'b0;
	lose <= 1'b0;
	map <= 1'b1; 
	total_miss <= 3'd6; 
	end
	
	STATE_6: begin 
	interface <= 1'b0;
	win <= 1'b0;
	lose <= 1'b0;
	map <= 1'b1;  
	total_miss <= 3'd6;
	end
	
	RESULT_1: begin
	interface <= 1'b0;
	win <= 1'b0;
	lose <= 1'b1;
	map <= 1'b0; 
	total_miss <= 3'd7; 
	end
	
	RESULT_1_WAIT: begin
	interface <= 1'b0;
	win <= 1'b0;
	lose <= 1'b1;
	map <= 1'b0; 
	total_miss <= 3'd0; 
	end
	
	RESULT_2: begin
	interface <= 1'b0;
	win <= 1'b1;
	lose <= 1'b0;
	map <= 1'b0; 
	total_miss <= total_miss;
	end
	
	RESULT_2_WAIT: begin
	interface <= 1'b0;
	win <= 1'b1;
	lose <= 1'b0;
	map <= 1'b0; 
	total_miss <= total_miss;
	end
	endcase
end

endmodule