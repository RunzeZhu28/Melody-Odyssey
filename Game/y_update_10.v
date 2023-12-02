module y_update_10(input map,input clk, input resetn, output reg [7:0] y);

 always@(posedge clk)
 if(resetn == 1'b0)
 y <= 8'd200;
 else if(y == 8'd216 && map)
 y <= 8'd200;
 else if(map)
 y <= y + 3'd4;
 else if (!map) y <= 8'd200;

endmodule