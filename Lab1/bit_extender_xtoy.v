`timescale 1ns / 1ps

// Transfomr a x bits width input data into a value of 32 bits width value
// Parameter : INPUT_DATA_WIDTH.
//      The width of the input data
//      Default value : 1
//      Note :  the INPUT_DATA_WIDTH should be less or equal to OUTPUT_DATA_WIDTH
// Parameter : OUTPUT_DATA_WIDTH.
//      The width of the output data
//      Default value : 32
//      Note : the OUTPUT_DATA_WIDTH should be greater or equal to INPUT_DATA_WIDTH
//
// Input : in. The input data
// Input : extension_type. Extension type.
//     0: Equals "Zero" in logsim. The additional bits are 0 
//     1: Equals "One" in logsim. The additional bits are 1 
//     2: Equals "Sign" in logsim. The additional bits are taken to match the highest-order bit in the input
//     3: Equals "Input" in logsim. The additional bits are taken to match the addition_input 
// Input : addition_input. Used when extension_type == 3.
// Output: out. The output data
//
// Example : 
//      bit_extender_xtoy #(.INPUT_DATA_WIDTH(16), .OUTPUT_DATA_WIDTH(32)) 
//                  U0(in, out, extension_type, additional_input)
//      It means it wants to extend a 16 bits width data to a 32 bits width data.

module bit_extender_xtoy(
in,
out,
extension_type,
addition_input
);

parameter INPUT_DATA_WIDTH = 1;
parameter OUTPUT_DATA_WIDTH = 32;

input   in;
input   extension_type;
input   addition_input;
output  out;

wire [INPUT_DATA_WIDTH - 1: 0]   in;
wire [1:0]                  extension_type;
wire                        addition_input;
reg  [OUTPUT_DATA_WIDTH - 1: 0]  out;

always @(in or extension_type or addition_input) begin
    case (extension_type)
        2'd0:   out = {{OUTPUT_DATA_WIDTH - INPUT_DATA_WIDTH{1'b0}}, in};
        2'd1:   out = {{OUTPUT_DATA_WIDTH - INPUT_DATA_WIDTH{1'b1}}, in};
        2'd2:   out = {{OUTPUT_DATA_WIDTH - INPUT_DATA_WIDTH{in[INPUT_DATA_WIDTH - 1]}}, in};
        2'd3:   out = {{OUTPUT_DATA_WIDTH - INPUT_DATA_WIDTH{addition_input}}, in};
        default:    out = {OUTPUT_DATA_WIDTH - INPUT_DATA_WIDTH{1'bx}};
    endcase
end 

endmodule // bit_extender_xtoy 