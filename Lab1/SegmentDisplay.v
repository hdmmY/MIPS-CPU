/**
 * Author : Wenjie, Huang
 * Team: Dian Group of HUST
 * Date: 7/9/2017
 */

`timescale 1ns / 1ps
module SegmentDisplay (
    input [31:0] register,   //32 bit register of output
    input [31:0] memval,    //32 bit value read from memory
    input [31:0] PC,    //32 bit PC
    input [15:0] Cycles,    //all cycles run
    input [15:0] nocondition_num,
    input [15:0] condition_num,
    input [15:0] condition_success_num,
    input clk,    //displaying frequency
    input rst_n,  // Asynchronous reset active low
    input [2:0] select, //select which data to display
    output reg [7:0] LED,
    output reg [7:0] Segment
);
    parameter dig0 =8'b11000000, dig1 =8'b11111001, dig2 =8'b10100100;
    parameter dig3 =8'b10110000, dig4 =8'b10011001, dig5 =8'b10010010;
    parameter dig6 =8'b10000010, dig7 =8'b11111000, dig8 =8'b10000000;
    parameter dig9 =8'b10010000, dig10=8'b10001000, dig11=8'b10000011;
    parameter dig12=8'b11000110, dig13=8'b10100001, dig14=8'b10000110;
    parameter dig15=8'b10001110, dim  =8'b11111111, DP_En=8'b01111111;/* & DP_En to set the DP segment enabled*/
    parameter num0=4'b0000, num1=4'b0001, num2=4'b0010, num3=4'b0011, num4=4'b0100;
    parameter num5=4'b0101, num6=4'b0110, num7=4'b0111, num8=4'b1000, num9=4'b1001;
    parameter num10=4'b1010, num11=4'b1011, num12=4'b1100, num13=4'b1101, num14=4'b1110, num15=4'b1111;
    
    `define _display32bit (((select<=3'b010) || (select==3'b111)))
    `define _display16bit (((select>=3'b011) && (select<=3'b110)))

    reg [2:0] Scan_num;
    reg [3:0] temp;
    // reg [3:0] temp = num0;
    reg [31:0] reg32temp;
    reg [15:0] reg16temp;

    initial begin
        temp = num0;
        // reg [3:0] temp = num0;
        Scan_num = 3'b000;
    end

    /*Scanning for the LEDs to illuminate*/
    always @(posedge clk)
    begin
        Scan_num = Scan_num + 1; //Circulally scanning
    end
    
    /*select display pattern, display:normal output when @select == 0; memval when 1;
    PC when 3; Cycles when 4;nocondition_num when 5, condition_num when 6, condition_success_num when 7*/
    always @(select or register or memval or PC or Cycles or nocondition_num or condition_num or condition_success_num)
    begin
        case(select)
            3'b000: reg32temp = register;
            3'b001: reg32temp = memval;
            3'b010: reg32temp = PC;
            3'b011: reg16temp = Cycles;
            3'b100: reg16temp = nocondition_num;
            3'b101: reg16temp = condition_num;
            3'b110: reg16temp = condition_success_num;
            3'b111: reg32temp = register;
        endcase // select
    end

    always @(Scan_num)
    begin
        case(Scan_num)
            3'b000: LED=8'b11111110;
            3'b001: LED=8'b11111101;
            3'b010: LED=8'b11111011;
            3'b011: LED=8'b11110111;
            3'b100: LED=8'b11101111;
            3'b101: LED=8'b11011111;
            3'b110: LED=8'b10111111;
            3'b111: LED=8'b01111111;  
        endcase // Scan_num
    end

    always @(Scan_num)
    begin
        if(!LED[0])
        begin
            if(`_display32bit)
                temp = reg32temp[3:0];
            else if(`_display16bit)
                temp = reg16temp[3:0];
        end
        else if(!LED[1])
        begin
            if(`_display32bit)
                temp = reg32temp[7:4];
            else if(`_display16bit)
                temp = reg16temp[7:4];
        end
        else if(!LED[2])
        begin
            if(`_display32bit)
                temp = reg32temp[11:8];
            else if(`_display16bit)
                temp = reg16temp[11:8];
        end
        else if(!LED[3])
        begin
            if(`_display32bit)
                temp = reg32temp[15:12];
            else if(`_display16bit)
                temp = reg16temp[15:12];
        end
        else if(!LED[4])
        begin
            if(`_display32bit)
                temp = reg32temp[19:16];
        end
        else if(!LED[5])
        begin
            if(`_display32bit)
                temp = reg32temp[23:20];
        end
        else if(!LED[6])
        begin
            if(`_display32bit)
                temp = reg32temp[27:24];
        end
        else if(!LED[7])
        begin
            if(`_display32bit)
                temp = reg32temp[31:28];
        end

        case(temp)
                num0: Segment=dig0;
                num1: Segment=dig1;
                num2: Segment=dig2;
                num3: Segment=dig3;
                num4: Segment=dig4;
                num5: Segment=dig5;
                num6: Segment=dig6;
                num7: Segment=dig7;
                num8: Segment=dig8;
                num9: Segment=dig9;
                num10: Segment=dig10;
                num11: Segment=dig11;
                num12: Segment=dig12;
                num13: Segment=dig13;
                num14: Segment=dig14;
                num15: Segment=dig15;
        endcase

        if(!LED[4] || !LED[5] || !LED [6] || !LED[7])
            if(`_display16bit)
                Segment = dim;
    end
endmodule