// Two bit select multiplexer
// Parameter : DATA_WIDTH. 
//      The width of the input data.
//      Default value : 32
// Input : data0, data1, data2, data3. The input data. 
// Input : select. If select == 0, select data0, if select == 1, select data1......
// Input : enable. If enable == 0, select correct, else the out will be float value.
// Output : out. The output selected value.
//
// Example : 
//      mux_2_select #(16) U0(data0, data1, data2, data3, out, select, enable)
//      It means a 2 bit select, 16 bits data width Multiplexer.
module mux_2_select(
data0,
data1,
data2,
data3,
out,
select,
enable
);

parameter DATA_WIDTH = 32;

input   data0;
input   data1;
input   data2;
input   data3;
input   select;
input   enable;
output  out;

wire [DATA_WIDTH - 1: 0]    data0;
wire [DATA_WIDTH - 1: 0]    data1;
wire [DATA_WIDTH - 1: 0]    data2;
wire [DATA_WIDTH - 1: 0]    data3;
wire [1:0]                  select;
wire                        enable;
reg  [DATA_WIDTH - 1: 0]    out;

always @(data0 or data1 or data2 or data3 or select or enable) begin
    if(enable == 1'b0) begin
        case (select)
            2'd0:   out = data0;
            2'd1:   out = data1;
            3'd2:   out = data2;
            4'd3:   out = data3;
            default:    out = {DATA_WIDTH{1'bx}};
        endcase
    end else begin
        out = {DATA_WIDTH{1'bZ}};
    end
end

endmodule // mux_2_select    