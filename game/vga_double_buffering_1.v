module vga_double_buffering_1(
    input clk,
	 input clk_new,
	 input resetn,	
	 input map,
    output reg [7:0] oy           
);

 wire ram1_write_en; 
 wire ram1_read_en; 
 wire ram2_write_en ; 
 wire ram2_read_en ; 
 wire [7:0] ram1_read_y ; 
 wire [7:0] ram2_read_y ;   
 wire [7:0] ram1_write_y ; 
 wire [7:0] ram2_write_y ;
 wire [7:0] y ;

always@(negedge clk)
begin
if (!resetn) oy <= 0;
if (ram1_read_en == 1'b1) oy <=  ram1_read_y;
else if (ram2_read_en == 1'b1) oy <=  ram2_read_y;
end
	
 ram1 U1(clk_new, ram1_write_y,0,ram1_read_en,0,ram1_write_en,ram1_read_y);
 
 ram1 U2(clk_new,ram2_write_y,0,ram2_read_en,0,ram2_write_en,ram2_read_y);
 
 double_buffering U3
 (clk_new, resetn,  y, map, ram1_write_en, ram1_read_en, ram1_write_y,
 ram2_write_en,ram2_read_en,  ram2_write_y);

 y_update_1 U4 (map,clk_new , resetn, y );

 

 
 endmodule



