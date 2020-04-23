module echo (
	input [7:0] sw,
	output [7:0] led
);
assign led = sw;
endmodule
