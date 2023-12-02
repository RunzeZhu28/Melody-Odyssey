module double_buffering(clk, resetn,y,map,  ram1_write_en, ram1_read_en, ram1_write_y, ram2_write_en, ram2_read_en, ram2_write_y);

input clk, resetn,map;
input [7:0]y;
output reg ram1_write_en,  ram1_read_en, ram2_read_en, ram2_write_en;
output reg[7:0] ram1_write_y;
output reg[7:0] ram2_write_y;


parameter  WRITE_RAM2_READ_RAM1 = 2'b0,
			  WRITE_RAM1_READ_RAM2 = 2'b1;
			  
reg [1:0] current = WRITE_RAM2_READ_RAM1;
reg [1:0] next;


always@(posedge clk)
begin
if (ram1_write_en)  
ram1_write_y <= y;
else if (ram2_write_en)
ram2_write_y <= y;
end


always@(*)			  
	begin
	if(map)
	begin
	case(current)
	WRITE_RAM2_READ_RAM1 : next <= WRITE_RAM1_READ_RAM2;
	WRITE_RAM1_READ_RAM2 : next <= WRITE_RAM2_READ_RAM1;
	default: next <= WRITE_RAM2_READ_RAM1;
 
	endcase
	end
	end
	
always@(posedge clk)
if(!resetn) current <= WRITE_RAM2_READ_RAM1;
else if(map) current <= next;

always@(*)
if(map)
begin
ram1_write_en <= 1'b0;
ram2_write_en <= 1'b0;
ram1_read_en <= 1'b0;
ram2_read_en <= 1'b0;


case(current)
WRITE_RAM2_READ_RAM1:
begin
ram2_write_en <= 1'b1;
ram1_read_en <= 1'b1;
end

WRITE_RAM1_READ_RAM2:
begin
ram1_write_en <= 1'b1;
ram2_read_en <= 1'b1;
end
endcase
end

endmodule 