/*module clock_divider_12(
    input clk, 
	 input resetn, 
    output reg out_clk = 0  //change to wire
);

reg [21:0] counter = 22'd0;

always @(posedge clk) 
begin
	if (!resetn)  begin out_clk <= 0; counter <= 0; end
		else
	 begin
    counter <= counter + 22'd1;
	 if (counter >= 22'd2083333) begin
        out_clk <= ~out_clk;
        counter <= 22'd0; 
	    
		  
    end
	 end
end

endmodule
