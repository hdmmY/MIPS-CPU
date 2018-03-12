// Transfomr a 16 bit input data into a value of 32 bit width
// in: input of 16 bit data
// out: output of 32 bit data
// extension_type: 
//      0: Zero. The additional bits are 0
//      1: One. The additional bits are 1
//      2: Sign. The additional bits are taken to match the highest-order bit in the input
//      3: Input. The additional bits are taken to match the addition_input  
// addition_input: use for extension_type
module bit_extender_16to32(
in,
out,
extension_type,
addition_input
);

input   in;
input   extension_type;
input   addition_input;
output  out;

wire [15:0] in;
wire [1:0]  extension_type;
wire        addition_input;
reg [31:0]  out;

always @(in or extension_type or addition_input) begin
    case (extension_type)
        2'd0:   out = {18'b0, in};
        2'd1:   out = {{18{1'b1}}, in};
        2'd2:   out = {{18{in >= 16'h8000}}, in};
        2'd3:   out = {{18{addition_input}}, in};
      default:      out = 32'bx;
    endcase
end 


endmodule // bit_extender_16to32 