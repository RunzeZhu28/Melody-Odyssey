module frequencyDivider (
	input CLOCK_50,

	output reg Clock_16k
);

reg [23:0] cnt;

always@(posedge CLOCK_50)begin
	if (cnt == 24'd8333) begin
		Clock_16k <= 1'b1;
		cnt <= 24'b0;
	end
	else begin
		cnt <= cnt + 24'b1;
		Clock_16k <= 1'b0;
	end
end

endmodule
