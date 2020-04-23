`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/03/29 17:09:31
// Design Name: 
// Module Name: top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top(
	input CLK100MHZ,
	input dir,
	output reg [2:0] hexplay_an,
	output reg [3:0] hexplay_data
);


reg [31:0] data;
reg [32:0] hexplay_cnt;

always@(posedge CLK100MHZ) begin
	if (hexplay_cnt >= (2000000 / 8))
		hexplay_cnt <= 0;
	else
		hexplay_cnt <= hexplay_cnt + 1;
end

always@(posedge CLK100MHZ) begin
	if (hexplay_cnt == 0)begin
		if (hexplay_an == 7)
			hexplay_an <= 0;
		else
			hexplay_an <= hexplay_an + 1;
	end
end

always@(*) begin
	case(hexplay_an)
		0: hexplay_data = data[3:0];
		1: hexplay_data = data[7:4];
		2: hexplay_data = data[11:8];
		3: hexplay_data = data[15:12];
		4: hexplay_data = data[19:16];
		5: hexplay_data = data[23:20];
		6: hexplay_data = data[27:24];
		7: hexplay_data = data[31:28];
	endcase
end

reg [26:0] timer_cnt;
always@(posedge CLK100MHZ) begin
	if (timer_cnt >= 100000000)
		timer_cnt <= 0;
	else
		timer_cnt <= timer_cnt + 1;
end

always@(posedge CLK100MHZ) begin
	if (timer_cnt == 0) begin
		if (dir) begin
			data <= data - 1;
		end
		else begin
			data <= data + 1;
		end
	end
end

endmodule
