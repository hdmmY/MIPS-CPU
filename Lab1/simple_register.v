`timescale 1ns / 1ps

// A simple register. 
// Details: The register stores a DATA_WIDTH value and emmitted to out data. 
//      When the clk is posedge, the register store's value is change to the value of in data. 
//      As long as reset is 1, the register value pinned to 0, regardless of the clock input.
//
// Parameter : DATA_WIDTH
//      The input and output data bits.
//      Default value is 32.
// 
// Input : in. The input data. It's data width is DATA_WIDTH.
// Input : clk. The clock.
// Input : reset. Reset the register value when the reset is 1.
// Input : enable. When enable is 0, ignore clk.
// Output : out. Equals to the register's value.
//
// Example : 
//      simple_register #(16) U0(in, out, clk, enable, reset);
//      It means a 16 bit width simple register.
module simple_register(
in,
out,
clk,
enable,
reset
);

parameter DATA_WIDTH = 32;

input   in;
input   reset;
input   clk;
input   enable;
output  out;

wire [DATA_WIDTH - 1: 0]    in;
wire                        reset;
wire                        clk;
wire                        enable;
reg  [DATA_WIDTH - 1: 0]    out;

reg  [DATA_WIDTH - 1: 0]    reg_store;

initial begin
    reg_store = {DATA_WIDTH{1'b0}};
end

always @(posedge clk) begin
    if (enable == 1'b1) begin
        reg_store = in;
    end
end

always @(in or reset or clk)begin
    if (reset == 1'b1) begin
        reg_store = {DATA_WIDTH{1'b0}};
        out = {DATA_WIDTH{1'b0}};
    end else begin
        out = reg_store;
    end
end

endmodule // simple_register    