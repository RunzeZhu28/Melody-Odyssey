module vga_double_buffering_3(
    input clk,
	 input resetn,	 
	 input map,	 
    output reg [7:0] y              
);

  


 wire clk_new ; 
 wire [7:0] ram1_read_data ; 
 wire [7:0] ram2_read_data ; 
 wire data_en ; 
 wire [7:0] data ; 
 wire ram1_write_en; 
 wire ram1_read_en; 
 wire [4:0] ram1_write_address ; 
 wire [4:0] ram1_read_address ; 
 wire [7:0] ram1_write_data ; 
 wire ram2_write_en ; 
 wire ram2_read_en ; 
 wire [4:0] ram2_write_address ;
 wire [4:0] ram2_read_address ;
 wire [7:0] ram2_write_data ;

always@(negedge clk)
begin
if (!resetn) y <= 0;
if (ram1_read_en == 1'b1) y <=  ram1_read_data;
else if (ram2_read_en == 1'b1) y <=  ram2_read_data;
end

 ram_control ram_control_inst
 (clk_new,  resetn, ram1_read_data, ram2_read_data, data_en, data,map, ram1_write_en, ram1_read_en , ram1_write_address , ram1_read_address , ram1_write_data,
 ram2_write_en,ram2_read_en, ram2_write_address, ram2_read_address, ram2_write_data);

 data_generation_3 data_generation_inst (map,clk_new , resetn, data_en,data );

 clock_divider_50 clock_divider_inst(clk, resetn, clk_new);
 
 ram1 ram1_inst(clk_new, ram1_write_data,ram1_read_address,ram1_read_en,ram1_write_address,ram1_write_en,ram1_read_data);

 ram1 ram2_inst(clk_new,ram2_write_data,ram2_read_address,ram2_read_en,ram2_write_address,ram2_write_en,ram2_read_data);
 
 endmodule



