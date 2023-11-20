module clock_divider(
    input clk, 
	 input resetn, 
    output reg out_clk = 0  
);

reg [20:0] counter = 21'd0;

always @(posedge clk) 
begin
	if (!resetn)  begin out_clk <= 0; counter <= 0; end
		else
	 begin
    counter <= counter + 21'd1;
	 /*if (counter >= 21'd3) begin
        out_clk <= ~out_clk;
        counter <= 21'd0;*/
	 
    if (counter >= 21'd833333) begin
        out_clk <= ~out_clk;
        counter <= 21'd0;
		  
    end
	 end
end

endmodule
