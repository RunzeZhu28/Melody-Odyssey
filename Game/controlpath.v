module control_path(clk, resetn, key_1, key_2, miss, done, interface, map, total_miss, win, lose); 

input clk, resetn, key_1, key_2, miss,done;
output reg interface, map, win, lose;
output reg [2:0] total_miss;

parameter IDLE =4'b0000,
STATE_0 = 4'b0001,
STATE_1 = 4'b0010,
STATE_2 = 4'b0011,
STATE_3 = 4'b0100,
STATE_4 = 4'b0101,
STATE_5 = 4'b0110,
STATE_6 = 4'b0111,
RESULT_1 = 4'b1000,
RESULT_2 = 4'b1001,
IDLE_WAIT = 4'b1010,
RESULT_1_WAIT = 4'b1011,
RESULT_2_WAIT = 4'b1100;

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
			else next = miss? STATE_1 : STATE_0;
			end
			
		STATE_1 : begin 
			if (key_2)
				next = IDLE;
			else if (done) next = RESULT_2; 	
			else next = miss? STATE_2 : STATE_1;
			end
			
		STATE_2 : begin 
			if (key_2)
				next = IDLE;
			else if (done) next = RESULT_2; 
			else next = miss? STATE_3 : STATE_2;
			end
			
		STATE_3 : begin 
			if (key_2)
				next = IDLE;
			else if (done) next = RESULT_2; 
			else next = miss? STATE_4 : STATE_3;
			end
			
		STATE_4 : begin 
			if (key_2)
				next = IDLE;
			else if (done) next = RESULT_2; 
			else next = miss? STATE_5 : STATE_4;
			end
			
		STATE_5 : begin 
			if (key_2)
				next = IDLE;
			else if (done) next = RESULT_2; 
			else next = miss? STATE_6 : STATE_5;
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
	
	STATE_1: begin 
	interface <= 1'b0;
	win <= 1'b0;
	lose <= 1'b0;
	map <= 1'b1;  
	total_miss <= 3'd1; 
	end
	
	STATE_2: begin 
	interface <= 1'b0;
	win <= 1'b0;
	lose <= 1'b0;
	map <= 1'b1; 
	total_miss <= 3'd2; 
	end
	
	STATE_3:begin 
	interface <= 1'b0;
	win <= 1'b0;
	lose <= 1'b0;
	map <= 1'b1;  
	total_miss <= 3'd3;
	end
	
	STATE_4: begin 
	interface <= 1'b0;
	win <= 1'b0;
	lose <= 1'b0;
	map <= 1'b1; 
	total_miss <= 3'd4; 
	end
	
	STATE_5: begin 
	interface <= 1'b0;
	win <= 1'b0;
	lose <= 1'b0;
	map <= 1'b1;  
	total_miss <= 3'd5; 
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
	total_miss <= 3'd0; 
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
	total_miss <= 3'd0; 
	end
	
	RESULT_2_WAIT: begin
	interface <= 1'b0;
	win <= 1'b1;
	lose <= 1'b0;
	map <= 1'b0; 
	total_miss <= 3'd0; 
	end
	endcase
end

endmodule