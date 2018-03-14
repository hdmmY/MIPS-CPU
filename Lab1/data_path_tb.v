`timescale 1ns / 1ps
/////////////////////////////////////////////////////////////////
// Module Name: lab1_tb
/////////////////////////////////////////////////////////////////
module datapath_test();
reg clk;
reg RST;
reg stop_button;
wire [31:0] SyscallOut;

datapath datapath1(clk, RST, stop_button, SyscallOut);

initial begin
clk=0;
RST=0; 
stop_button=0;
#1000 RST=1;
#1000 RST=0;
#1000 stop_button=1;
#1000 stop_button=0;
end

always
begin
#1 clk=~clk;
end

endmodule
