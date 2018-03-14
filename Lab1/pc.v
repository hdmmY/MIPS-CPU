`timescale 1ns/1ps
/**
 * @module pc
 * @brief D flip flop
 * @param DATA_WIDTH data width
 * @input clk clock signal
 * @input rst reset signal
 * @input en enable signal
 * @input din data in
 * @output dout data out
 */
 module pc
 #(parameter DATA_WIDTH = 32)
 (
 	input clk,
 	input rst,
 	input en,
 	input [DATA_WIDTH-1:0] din,
 	output reg [DATA_WIDTH-1:0] dout
 );
	 initial begin
		dout={DATA_WIDTH{1'b0}};
	 end

 	always@ (posedge clk) begin
 		if(rst) begin
 			dout <= 0; //reset
 		end else if (en) begin
 			dout <= din; //updata
 		end else begin
 			dout <= dout; //hold
 		end
 	end
 endmodule // pc