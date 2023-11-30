module ram_control(input clk, 
input resetn,
input [7:0] ram1_read, 
input [7:0] ram2_read, 
input data_en, 
input [7:0]data,
input map, 
output reg ram1_write_en, 
output reg ram1_read_en, 
output [4:0] ram1_write_address,
output [4:0] ram1_read_address, 
output  [7:0] ram1_write_data, 
output reg ram2_write_en, 
output reg ram2_read_en, 
output [4:0] ram2_write_address, 
output [4:0] ram2_read_address, 
output wire [7:0] ram2_write_data);

localparam IDLE =3'b0,
			  WRITE_RAM1 = 3'b10,
			  WRITE_RAM2_READ_RAM1 = 3'b11,
			  WRITE_RAM1_READ_RAM2 = 3'b100;
			  
reg [2:0] current, next;
reg [7:0] data_in_reg;

assign ram1_write_address = 5'b0;
assign ram1_read_address = 5'b0;  //change these data type to wire now
assign ram2_write_address = 5'b0;
assign ram2_read_address = 5'b0;

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
	//IDLE: if(data_en == 1'b1) next <= WRITE_RAM1;
	//WRITE_RAM1: next <= WRITE_RAM2_READ_RAM1 ;
	WRITE_RAM2_READ_RAM1 : next <= WRITE_RAM1_READ_RAM2;
	WRITE_RAM1_READ_RAM2 : next <= WRITE_RAM2_READ_RAM1;
	default: next <= WRITE_RAM2_READ_RAM1;
	//default: next <= IDLE;
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
IDLE:
begin
end

WRITE_RAM1:
begin
ram1_write_en <= 1'b1;
end

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

/*always@(posedge clk)
if(!resetn) ram1_read_en <= 1'b0;
else if (current == WRITE_RAM2_READ_RAM1)
ram1_read_en <= 1'b1;
else ram1_read_en <= 1'b0;

always@(posedge clk)
if(!resetn) ram2_read_en <= 1'b0;
else if (current == WRITE_RAM1_READ_RAM2)
ram2_read_en <= 1'b1;
else ram2_read_en <= 1'b0;*/

endmodule 