`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: conw(控制器模块)
//输入：op,func
//输出：PC/IM/R1#/R2#/W#/RF_DIN/EXT/ALUA/ALUB/ADDR/DM_DIN/WE/ALUOP/ALL/memread/memwrite/syscall/beq/bne/bgez
//(其中R1表示R1#,R2表示R2#,W表示W#),输出皆为控制信号，ALL表示控制信号总编码
//////////////////////////////////////////////////////////////////////////////////
module conw(op,func,PC,IM,R1,R2,W,RF_DIN,EXT,ALUA,ALUB,ADDR,DM_DIN,WE,ALUOP,ALL,
memread,memwrite,syscall,beq,bne,bgez);
input[5:0]op;
input[5:0]func;
output reg [1:0]PC;
output reg IM;
output reg [1:0]R1;
output reg R2;
output reg [1:0]W;
output reg [1:0]RF_DIN;
output reg [2:0]EXT;
output reg ALUA;
output reg [1:0]ALUB;
output reg ADDR;
output reg DM_DIN;
output reg WE;
output reg [3:0]ALUOP;
output reg [22:0]ALL;
output reg memread;
output reg memwrite;
output reg syscall;
output reg beq;
output reg bne;
output reg bgez;

wire a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20;
wire a21,a22,a23,a24,a25,a26,a27,a28;
wire[22:0] b1,b2,b3,b4,b5,b6,b7,b8,b9,b10,b11,b12,b13,b14,b15,b16,b17,b18,b19,b20;
wire[22:0] b21,b22,b23,b24,b25,b26,b27,b28;

assign a1=(op==6'h0)&(func==6'h20);
assign a2=(op==6'h8);
assign a3=(op==6'h9);
assign a4=(op==6'h0)&(func==6'h21);
assign a5=(op==6'h0)&(func==6'h24);
assign a6=(op==6'hc);
assign a7=(op==6'h0)&(func==6'h0);
assign a8=(op==6'h0)&(func==6'h3);
assign a9=(op==6'h0)&(func==6'h2);
assign a10=(op==6'h0)&(func==6'h22);
assign a11=(op==6'h0)&(func==6'h25); 
assign a12=(op==6'hd);
assign a13=(op==6'h0)&(func==6'h27);
assign a14=(op==6'h23);//LW
assign a15=(op==6'h2b);//SW
assign a16=(op==6'h4);//BEQ
assign a17=(op==6'h5);//BNE
assign a18=(op==6'h0)&(func==6'h2a);
assign a19=(op==6'ha);
assign a20=(op==6'h0)&(func==6'h2b);
assign a21=(op==6'h2);
assign a22=(op==6'h3);
assign a23=(op==6'h0)&(func==6'h8);
assign a24=(op==6'h0)&(func==6'hc);//syscall
assign a25=(op==6'h0)&(func==6'h23);
assign a26=(op==6'he);
assign a27=(op==6'h20);//LB
assign a28=(op==6'h1);//BGEZ

mux_1_select #(23) mux_control_1(.data0(23'h0),.data1(23'h15),.out(b1),.select(a1),.enable(0));
mux_1_select #(23) mux_control_2(.data0(23'h0),.data1(23'h8095),.out(b2),.select(a2),.enable(0));
mux_1_select #(23) mux_control_3(.data0(23'h0),.data1(23'h8095),.out(b3),.select(a3),.enable(0));
mux_1_select #(23) mux_control_4(.data0(23'h0),.data1(23'h15),.out(b4),.select(a4),.enable(0));
mux_1_select #(23) mux_control_5(.data0(23'h0),.data1(23'h17),.out(b5),.select(a5),.enable(0));
mux_1_select #(23) mux_control_6(.data0(23'h0),.data1(23'h9497),.out(b6),.select(a6),.enable(0));
mux_1_select #(23) mux_control_7(.data0(23'h0),.data1(23'h40490),.out(b7),.select(a7),.enable(0));
mux_1_select #(23) mux_control_8(.data0(23'h0),.data1(23'h40491),.out(b8),.select(a8),.enable(0));
mux_1_select #(23) mux_control_9(.data0(23'h0),.data1(23'h40492),.out(b9),.select(a9),.enable(0));
mux_1_select #(23) mux_control_10(.data0(23'h0),.data1(23'h16),.out(b10),.select(a10),.enable(0));
mux_1_select #(23) mux_control_11(.data0(23'h0),.data1(23'h18),.out(b11),.select(a11),.enable(0));
mux_1_select #(23) mux_control_12(.data0(23'h0),.data1(23'h9498),.out(b12),.select(a12),.enable(0));
mux_1_select #(23) mux_control_13(.data0(23'h0),.data1(23'h1a),.out(b13),.select(a13),.enable(0));
mux_1_select #(23) mux_control_14(.data0(23'h0),.data1(23'ha0d5),.out(b14),.select(a14),.enable(0));
mux_1_select #(23) mux_control_15(.data0(23'h0),.data1(23'he5),.out(b15),.select(a15),.enable(0));
mux_1_select #(23) mux_control_16(.data0(23'h0),.data1(23'h200806),.out(b16),.select(a16),.enable(0));
mux_1_select #(23) mux_control_17(.data0(23'h0),.data1(23'h200806),.out(b17),.select(a17),.enable(0));
mux_1_select #(23) mux_control_18(.data0(23'h0),.data1(23'h1b),.out(b18),.select(a18),.enable(0));
mux_1_select #(23) mux_control_19(.data0(23'h0),.data1(23'h809b),.out(b19),.select(a19),.enable(0));
mux_1_select #(23) mux_control_20(.data0(23'h0),.data1(23'h1c),.out(b20),.select(a20),.enable(0));
mux_1_select #(23) mux_control_21(.data0(23'h0),.data1(23'h400c00),.out(b21),.select(a21),.enable(0));
mux_1_select #(23) mux_control_22(.data0(23'h0),.data1(23'h410f15),.out(b22),.select(a22),.enable(0));
mux_1_select #(23) mux_control_23(.data0(23'h0),.data1(23'h600000),.out(b23),.select(a23),.enable(0));
mux_1_select #(23) mux_control_24(.data0(23'h0),.data1(23'h0a1086),.out(b24),.select(a24),.enable(0));
mux_1_select #(23) mux_control_25(.data0(23'h0),.data1(23'h16),.out(b25),.select(a25),.enable(0));
mux_1_select #(23) mux_control_26(.data0(23'h0),.data1(23'h949a),.out(b26),.select(a26),.enable(0));
mux_1_select #(23) mux_control_27(.data0(23'h0),.data1(23'hc0d5),.out(b27),.select(a27),.enable(0));
mux_1_select #(23) mux_control_28(.data0(23'h0),.data1(23'h200986),.out(b28),.select(a28),.enable(0));

always@(*)
begin
ALL<=b1|b2|b3|b4|b5|b6|b7|b8|b9|b10|b11|b12|b13|b14|b15|b16|b17|b18|b19|b20|b21|b22|b23|b24|b25|b26|b27|b28;

PC<=ALL[22:21];
IM<=ALL[20];
R1<=ALL[19:18];
R2<=ALL[17];
W<=ALL[16:15];
RF_DIN<=ALL[14:13];
EXT<=ALL[12:10];
ALUA<=ALL[9];
ALUB<=ALL[8:7];
ADDR<=ALL[6]; 
DM_DIN<=ALL[5];
WE<=ALL[4];
ALUOP<=ALL[3:0];
memread<=a14|a27;
memwrite<=a15;
syscall<=a24;
beq<=a16;
bne<=a17;
bgez<=a28;
end
endmodule
