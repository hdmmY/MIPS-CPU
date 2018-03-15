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
    input stop_button,  //Stop button
    input halt,
    output reg Fra_Freq,  // Fractional Frequency similar to logisim
    output reg display_Freq,
    output reg [15:0] Cycles   //total cycles run
);
    reg [31:0] m;
    reg [31:0] n;
    reg [31:0] k;
    reg [15:0] op_num;
    reg flag;
    initial 
    begin
        m = 32'd0;
        n = 32'd0;
        k = 32'd0;
        Fra_Freq = 0;
        display_Freq = 0;
        Cycles = 16'b0; 
        op_num = 16'b0;
        flag = 0;
    end
 
    always @(posedge Fra_Freq) begin
         if(rst_n)begin
             op_num<=0;
             flag<=0;
         end
         else begin     
         if(halt)begin
              op_num<=op_num+1;
         end
         case(halt)
             1'b0:
             if(flag==0)begin
                 Cycles<=op_num+1;
                flag<=1;
             end
             1'b1:Cycles<=op_num;
         endcase
    end
    end




    always @(posedge Sys_Clk)
    begin
        /*reset*/
       // if(rst_n) begin
       //     Cycles = 16'b0;
       // end
        
        if(n == 32'd50_000) begin
            n = 32'd0;
            display_Freq = ~display_Freq;
        end else begin
            n = n+1;
        end
        
        /*fra freq*/
        if(Fre_Choice)
        begin
            if(!stop_button)
            begin
                if(m == 32'd1048575)
                begin 
                    m = 32'd0;
                    Fra_Freq = ~Fra_Freq;
                    //Cycles = Cycles+1;
                end
                else
                    m=m+1;
            end
        end
        else
        begin
            if(!stop_button)
            begin
                if(k == 32'd1)
                begin
                    Fra_Freq = ~Fra_Freq;
                   // Cycles = Cycles+1;
                    k = 32'd0;
                end
                else
				    k = k+1;
            end
        end
    end
endmodule