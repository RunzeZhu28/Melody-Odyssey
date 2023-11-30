module data_generation_3(input map, input clk, input resetn, output reg data_en, output reg [7:0] data);

 always@(posedge clk or negedge resetn)
 if(resetn == 1'b0)
 data_en <= 1'b0;
 else if (map)
 data_en <= 1'b1;


 always@(posedge clk or negedge resetn)
 if(resetn == 1'b0)
 data <= 8'd60;
 else if(data == 8'd76)
 data <= 8'd60;
 else if(data_en == 1'b1)
 data <= data + 3'd4;
 else
 data <= data;
 
endmodule