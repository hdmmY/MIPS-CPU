`timescale 1ns/1ps
/**
* @module data_mem
* @brief data cache memeory(RAM)
* @param DATA_WIDTH data width
* @param BUS_WIDTH bus width
* @input clk clock signal
* @input MEMwrite write enable signal
* @input MEMread read enable signal
* @input A memory address
* @input D data write into memory
* @input RST clear data memory to zero
* @output rdata data read out from memory
*/
module data_mem
#(parameter DATA_WIDTH = 32, BUS_WIDTH = 10)
(
	input clk,
	input MEMread,
	input MEMwrite,
	input [BUS_WIDTH-1:0] A,
	input [DATA_WIDTH-1:0] D,
	input RST,
	output [DATA_WIDTH-1:0] rdata
);
	reg [DATA_WIDTH-1:0] RAM [0:(2**BUS_WIDTH)-1];
	reg [(2**BUS_WIDTH)-1:0] i;
	always @(posedge clk) begin
		if(MEMwrite) begin
			RAM[A] <= D;
			end
		if(RST) begin
			for(i=0 ;i < 2**BUS_WIDTH;i = i + 1)
				begin
					RAM[i] <= 0;
				end
		end
	end
	assign rdata = MEMread ?RAM[A] : {(DATA_WIDTH){1'b0}};
endmodule









