`timescale 1ns / 1ps

// Three bit select multiplexer
// Parameter : DATA_WIDTH. 
//      The width of the input data.
//      Default value : 32
// Input : data0, data1, data2, ... , data7. The input data. 
// Input : select. If select == 0, select data0, if select == 1, select data1......
// Input : enable. If enable == 0, select correct, else the out will be float value.
// Output : out. The output selected value.
//
// Example : 
//      mux_3_select #(16) U0(data0, data1, data2, data3, data4, data5, data6, data7, out, select, enable)
//      It means a 3 bit select, 16 bits data width Multiplexer.
module mux_3_select(
data0,
data1,
data2,
data3,
data4,
data5,
data6, 
data7,
out,
select,
enable
);

parameter DATA_WIDTH = 32;

input   data0;
input   data1;
input   data2;
input   data3;
input   data4;
input   data5;
input   data6;
input   data7;
input   select;
input   enable;
output  out;

wire [DATA_WIDTH - 1: 0]    data0;
wire [DATA_WIDTH - 1: 0]    data1;
wire [DATA_WIDTH - 1: 0]    data2;
wire [DATA_WIDTH - 1: 0]    data3;
wire [DATA_WIDTH - 1: 0]    data4;
wire [DATA_WIDTH - 1: 0]    data5;
wire [DATA_WIDTH - 1: 0]    data6;
wire [DATA_WIDTH - 1: 0]    data7;
wire [2:0]                  select;
wire                        enable;
reg  [DATA_WIDTH - 1: 0]    out;

always @(data0 or data1 or data2 or data3 or data4 or data5 or data6 or data7 or select or enable) begin
    if(enable == 1'b0) begin
        case (select)
            3'd0:   out = data0;
            3'd1:   out = data1;
            3'd2:   out = data2;
            3'd3:   out = data3;
            3'd4:   out = data4;
            3'd5:   out = data5;
            3'd6:   out = data6;
            3'd7:   out = data7;
            default:    out = {DATA_WIDTH{1'bx}};
        endcase
    end else begin
        out = {DATA_WIDTH{1'bZ}};
    end
end

endmodule // mux_3_select    