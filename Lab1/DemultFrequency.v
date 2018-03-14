/**
 * Author : Wenjie, Huang
 * Team: Blabla
 * Date: 3/12/2018
 */
//@Sys_Clk is 100MHZ, @display_Freq is 1KHZ, @Fra_Freq is @Sys_clk(100MH) or 64Hz choosed by
//the @Fre_Choice(0 for the former, 1 for the latter).
//@Cycles sums up all the cycles run durring the program, cleaned up by the @rst_n.
//@display_Freq for displaying the LEDS   
`timescale 1ns / 1ps
module DemultFrequency (
    input Sys_Clk,    // System Clock
    input Fre_Choice,   //choose which fre to use
    input rst_n,     // Asynchronous reset active low
    output reg Fra_Freq,  // Fractional Frequency similar to logisim
    output reg display_Freq,
    output reg [15:0] Cycles   //total cycles run
);
    integer m=0, n=0;
    initial 
    begin
        Fra_Freq = 0;
        display_Freq = 0;
        Cycles = 16'b0; 
    end
    always @(posedge rst_n)
    begin
        Cycles <= 16'b0;
        m <= 0;
        n <= 0;
    end

    always @(posedge Sys_Clk)
    begin
        if(n == 100000)
        begin
            n <= 0;
            display_Freq = ~display_Freq;
        end
        else
            n <= n+1;
    end

    always @(posedge Sys_Clk or Fre_Choice)
    begin 
        if(Fre_Choice)
        begin
            if(m==1562500)
            begin
                m<=0;
                Fra_Freq = ~Fra_Freq;
                Cycles <= Cycles+1;
            end
            else
                m<=m+1;
        end
        else
        begin
            Fra_Freq <= ~Fra_Freq;
            Cycles <= Cycles+1;
        end
    end
endmodule