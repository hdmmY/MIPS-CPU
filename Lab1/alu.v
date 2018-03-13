`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: alu(ALU运算器)
//输入参数：x and y（运算参数）     
//          aluop(表示运算符号)
//输出参数：result（表示运算结果的低32位） 
//          equal（判断x与y是否相等） 
//////////////////////////////////////////////////////////////////////////////////
module alu(x,y,aluop,result,equal);
input[31:0]x;
input[31:0]y;
input[3:0]aluop;
output reg [31:0]result;
output reg equal;


always@(x or y or aluop)
begin
    case(aluop)
    0:result=x<<(y[4:0]);//左移
    1:result=($signed(x))>>>(y[4:0]);//算术右移
    2:result=x>>(y[4:0]);//逻辑右移
    3:result=x*y;    //乘，cpu里不需要用到乘
    4:result=x/y;    //除，cpu里不需要用到除
    5:result=x+y;    //加法
    6:result=x-y;    //减法
    7:result=x&y;    //按位与
    8:result=x|y;    //按位或
    9:result=x^y;    //按位异或
    10:result=~(x|y);//按位或非
    11:result= ($signed(x)<$signed(y))?1:0;       //符号比较
    12:result= ($unsigned(x)<$unsigned(y))?1:0;  //无符号比较
    default:result=result;
    endcase
end

always@(x or y or aluop)
begin
    equal=(x==y)?1:0;
end
    
endmodule
