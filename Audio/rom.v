module addressCounter(
	input clock,
	input Start,
	
	output reg [16:0] address
);

always @(posedge clock) begin
	if (~Start) begin
		address <= 17'b0;
	end
	else if(address == 19'd114514) begin
		address <= 17'b0;
	end
	else begin
		address <= address + 1'b1;
	end
end


endmodule