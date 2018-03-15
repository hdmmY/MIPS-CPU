`timescale 1ns / 1ps
/////////////////////////////////////////////////////////////////
// Module Name: lab1_tb
/////////////////////////////////////////////////////////////////
module datapath_test();
reg clk;
reg RST;
reg stop_button;
reg Fre_Choice;
reg [2:0] select;
reg [3:0] address;
//wire[15:0] nocondition_num, condition_num, condition_success_num;
wire [7:0] LED;
wire [7:0] Segment;
datapath datapath1(clk, RST, stop_button, Fre_Choice, select, address, LED, Segment);

initial begin
clk=0;
RST=0; 
stop_button=0;
Fre_Choice=0;
select=3'b0;;
address=4'b0;

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
