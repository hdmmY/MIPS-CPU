// Multiplexer 
// Input data : 32 bits
// Sector : 3 bits
// Enable : 1 bits
// Output data : 32 bits
module mux_32b_3s(
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

wire[32:0]  data0;
wire[32:0]  data1;
wire[32:0]  data2;
wire[32:0]  data3;
wire[32:0]  data4;
wire[32:0]  data5;
wire[32:0]  data6;
wire[32:0]  data7;
wire[2:0]   select;
wire        enable;
reg [32:0]  out;

always @(data0 or data1 or data2 or data3 or select or enable) begin
    if(enable == 1'b0) begin
        case (select)
            3'd0:  out = data0;
            3'd1:  out = data1;
            3'd2:  out = data2;
            3'd3:  out = data3;
            3'd4:  out = data4;
            3'd5:  out = data5;
            3'd6:  out = data6;
            3'd7:  out = data7;
            default:    out = 32'bx;   
        endcase
    end else begin
        out = 32'bZ;
    end
end

endmodule // mux_32b_2s