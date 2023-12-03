module double_buffering(input clk, 
input resetn,
input [7:0] ram1_read, 
input [7:0] ram2_read, 
input data_en, 
input [7:0]data,
input map, 
output reg ram1_write_en, 
output reg ram1_read_en, 
output  [7:0] ram1_write_data, 
output reg ram2_write_en, 
output reg ram2_read_en,  
output wire [7:0] ram2_write_data);

parameter  WRITE_RAM2_READ_RAM1 = 2'b0,
			  WRITE_RAM1_READ_RAM2 = 2'b1;
			  
reg [1:0] current, next;
reg [7:0] data_in_reg;


assign ram1_write_data = (ram1_write_en == 1'b1) ? data_in_reg: 8'd0;
assign ram2_write_data = (ram2_write_en == 1'b1) ? data_in_reg: 8'd0;
		  
always@(posedge clk)
if(!resetn)
data_in_reg <= 8'd0;
else if (map)
data_in_reg <= data;
else
data_in_reg <= 8'd0;

initial begin
	current <= WRITE_RAM2_READ_RAM1;
	data_in_reg <= 8'b0;
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