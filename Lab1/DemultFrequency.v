/**
 * Author : Wenjie, Huang
 * Team: Blabla
 * Date: 3/12/2018
 */
//@Sys_Clk is 100MHZ, @display_Freq is 1KHZ, @Fra_Freq is @Sys_Clk(100MH) or 64Hz choosed by
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
    reg [31:0] m;
    reg [31:0] n;
    reg [31:0] k;
    
    initial 
    begin
        m = 32'd0;
        n = 32'd0;
        k = 32'd0;
        Fra_Freq = 0;
        display_Freq = 0;
        Cycles = 16'b0; 
    end


    always @(posedge Sys_Clk)
    begin
        /*reset*/
        if(rst_n) begin
            Cycles = 16'b0;
            m = 32'd0;
            n = 32'd0;
			k = 32'd0;
        end
        
        if(n == 32'd200000) begin
            n = 32'd0;
            display_Freq = ~display_Freq;
        end else begin
            n = n+1;
        end
        
        /*fra freq*/
        if(Fre_Choice)
        begin
            if(m == 32'd1562500)
            begin 
                m = 32'd0;
                Fra_Freq = ~Fra_Freq;
                Cycles = Cycles+1;
            end
            else
                m=m+1;
        end
        else
        begin
			if(k == 32'd4)
			begin
            Fra_Freq = ~Fra_Freq;
            Cycles = Cycles+1;
            k = 32'd0;
			end
			else
				k = k+1;
        end
    end
endmodule