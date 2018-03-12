// Multiplexer 
// Input data : 32 bits
// Sector : 2 bits
// Enable : 1 bits
// Output data : 32 bits
module mux_32b_2s(
data0,
data1,
data2,
data3,
out,
select,
enable
);

input   data0;
input   data1;
input   data2;
input   data3;
input   select;
input   enable;
output  out;

wire[32:0]  data0;
wire[32:0]  data1;
wire[32:0]  data2;
wire[32:0]  data3;
wire[1:0]   select;
wire        enable;
reg [32:0]  out;

always @(data0 or data1 or data2 or data3 or select or enable) begin
    if(enable == 1'b0) begin
        case (select)
            2'd0:  out = data0;
            2'd1:  out = data1;
            2'd2:  out = data2;
            2'd3:  out = data3;   
            default:    out = 32'bx;   
        endcase
    end else begin
        out = 32'bZ;
    end
end

endmodule // mux_32b_2s