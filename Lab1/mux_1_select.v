`timescale 1ns / 1ps

// One bit select multiplexer
// Parameter : DATA_WIDTH. 
//      The width of the input data.
//      Default value : 32
// Input : data0, data1. The input data. 
// Input : select. If select == 0, select data0, else select data1.
// Input : enable. If enable == 0, select correct, else the out will be float value.
// Output : out. The output selected value.
//
// Example : 
//      mux_1_select #(16) U0(data0, data1, out, select, enable)
//      It means a 1 bit select, 16 bits data width Multiplexer.
module mux_1_select(
data0,
data1,
out,
select,
enable
);

parameter DATA_WIDTH = 32;

input   data0;
input   data1;
input   select;
input   enable;
output  out;

wire [DATA_WIDTH - 1: 0]    data0;
wire [DATA_WIDTH - 1: 0]    data1;
wire                        select;
wire                        enable;
reg  [DATA_WIDTH - 1: 0]    out;

always @(data0 or data1 or select or enable) begin
    if(enable == 1'b0) begin
        case (select)
            1'b0:   out = data0;
            1'b1:   out = data1;
            default:    out = {DATA_WIDTH{1'bx}};
        endcase
    end else begin
        out = {DATA_WIDTH{1'bZ}};
    end
end

endmodule // mux_1_select    