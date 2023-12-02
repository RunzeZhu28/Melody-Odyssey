module y_update(input map,input clk, input resetn, output reg [7:0] y);



 always@(posedge clk)
 if(resetn == 1'b0)
 y <= 8'd0;
 else if(y == 8'd16 && map)
 y <= 8'd0;
 else if(map)
 y <= y + 3'd4;
 else if(!map) y<=8'd0;
 
endmodule