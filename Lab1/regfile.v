`timescale 1ns/1ps
/**
* @modedule regfile
* @brief register files for MIPS CPU, contains 32 D filp-flop registers
* @parameter DATA_WIDTH data width
* @input clk clock signal
* @input WE write enable signal
* @input raddrA register number for A out port
* @input raddrB register number for B out port
* @input waddr write register number for wdata(in port)
* @input wdata data to write into regfiles
* @output regA A port output
* @output regB B port output
*/
module regfile
#(parameter DATA_WIDTH = 32,V0 = 2, A0 = 4)
(
	input clk,
	input rst,
	input we,
	input [4:0] raddrA,
	input [4:0] raddrB,
	input [4:0] waddr,
	input [DATA_WIDTH -1:0] wdata,
	output [DATA_WIDTH -1:0] regA,
	output [DATA_WIDTH -1:0] regB,
	output [DATA_WIDTH -1:0] v0_data,
	output [DATA_WIDTH -1:0] a0_data
);

	reg [5:0] i;
	reg [DATA_WIDTH -1:0] regfile1 [0:31];

	initial begin
		for (i = 0; i < 32; i = i + 1) begin
			regfile1[i] = {DATA_WIDTH{1'b0}};
		end
	end


	always@(posedge clk) begin
		if(rst) begin
			for(i = 0; i < 32;i = i + 1)
				begin
					regfile1[i] = 0;
				end
		end else if(we && waddr != 0) begin
			regfile1[waddr] <= wdata;
		end
	end
	
	
	assign regA = regfile1[raddrA];
	assign regB = regfile1[raddrB];
	/*assign v0_data = regfile1[V0];
	assign a0_data = regfile1[A0];*/
	assign v0_data = 1;
	assign a0_data = 1;

endmodule //regfile