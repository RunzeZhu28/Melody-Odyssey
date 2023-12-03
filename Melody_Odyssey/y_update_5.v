module y_update_5(input map,input clk, input resetn, output reg [7:0] y);


 always@(posedge clk)
 if(resetn == 1'b0)
 y <= 8'd100;
 else if(y == 8'd116 && map)
 y <= 8'd100;
 else if(map)
 y <= y + 3'd4;
 else if (!map) y <= 8'd100;

 
endmodule