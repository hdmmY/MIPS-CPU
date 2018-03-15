`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: datapath(数据通路)
//输入：RST,clk,stop_button(停止按钮)
//输出：SyscallOut
//////////////////////////////////////////////////////////////////////////////////
module datapath(clk, RST, stop_button, Fre_Choice, select, address, LED, Segment);
input clk;
input RST;
input stop_button;
input Fre_Choice;
input [2:0] select;
input [3:0] address;
output wire [7:0] LED;
output wire [7:0] Segment;


wire halt,equal,b_jump_success;
wire[31:0] pc_din,pc_dout,ins_dout,IMM0,IMM1,IMM2,IMM2_1,IMM3,IMM5;
wire[31:0] regfile_wdata, regfile_outA, regfile_outB, v0_data, a0_data;
wire[31:0] ALU, data_mem_out, data_mem_out_extender, ALUX, ALUY;
wire[31:0] S_EXT, PCS, PC_add4, PC_select1;
wire[4:0] rs,rd,rt,rA,rB,rW;
wire[5:0] func,op;
wire[3:0] PC_28_31;
wire[15:0] nocondition_num, condition_num, condition_success_num;
wire Fre_Choice, Fra_Freq, display_Freq;
wire[15:0] Cycles;
wire [31:0] display_data;
wire [31:0] SyscallOut;


wire [1:0]PC;
wire IM;
wire [1:0]R1;
wire R2;
wire [1:0]W;
wire [1:0]RF_W;
wire [2:0]EXT;
wire ALUA;
wire [1:0]ALUB;
wire ADDR;
wire DM_DIN;
wire WE;
wire [3:0]ALUOP;
wire [22:0]ALL;
wire MEMread;
wire MEMwrite;
wire syscall;
wire beq;
wire bne;
wire bgez; 
 
pc pc1(.clk(Fra_Freq),.rst(RST),.en(~halt),.din(pc_din),.dout(pc_dout));
ins_mem ins_mem1(.addr(pc_dout[11:2]),.rdata(ins_dout)); 
assign rs=ins_dout[25:21];
assign rd=ins_dout[15:11];
assign rt=ins_dout[20:16];
assign func=ins_dout[5:0];
assign op=ins_dout[31:26];

bit_extender_xtoy #(.INPUT_DATA_WIDTH(5), .OUTPUT_DATA_WIDTH(32))
extender1(ins_dout[10:6], IMM1, 2'd0, 1'bx);
bit_extender_xtoy #(.INPUT_DATA_WIDTH(26), .OUTPUT_DATA_WIDTH(32))
extender2(ins_dout[25:0], IMM3, 2'd0, 1'bx);
bit_extender_xtoy #(.INPUT_DATA_WIDTH(18), .OUTPUT_DATA_WIDTH(32))
extender3({ins_dout[15:0], 2'b0}, IMM2_1, 2'd2, 1'bx);
assign IMM2=IMM2_1+32'h4;
bit_extender_xtoy #(.INPUT_DATA_WIDTH(16), .OUTPUT_DATA_WIDTH(32))
extender4(ins_dout[15:0], IMM0, 2'd2, 1'bx);
bit_extender_xtoy #(.INPUT_DATA_WIDTH(16), .OUTPUT_DATA_WIDTH(32))
extender5(ins_dout[15:0], IMM5, 2'd0, 1'bx);

conw control1(op,func,PC,IM,R1,R2,W,RF_W,EXT,ALUA,ALUB,ADDR,DM_DIN,WE,ALUOP,ALL,
MEMread,MEMwrite,syscall,beq,bne,bgez);

regfile regfile1(Fra_Freq, RST, WE, rA, rB, rW, regfile_wdata, regfile_outA, regfile_outB, v0_data, a0_data);
mux_2_select mux_2_select_regfile_wdata(ALU, data_mem_out, data_mem_out_extender, 32'h0, regfile_wdata, RF_W, 1'b0);
mux_2_select #(5) mux_2_select_regfile_rA(rs, rt, 5'h2, 5'h0, rA, R1, 1'b0);
mux_1_select #(5) mux_1_select_regfile_rB(rt, 5'h4, rB, R2, 1'b0);
mux_2_select #(5) mux_2_select_regfile_rW(rd, rt, 5'h1f, 5'h0, rW, W, 1'b0);

data_mem data_mem1(Fra_Freq, MEMread, MEMwrite, address, ALU[9:0], regfile_outB, RST, data_mem_out, display_data);
bit_extender_xtoy #(.INPUT_DATA_WIDTH(8), .OUTPUT_DATA_WIDTH(32))
extender6(data_mem_out[7:0], data_mem_out_extender, 2'd2, 1'bx);

assign halt= (syscall & equal) | stop_button;
simple_register simple_register_SyscallOut(regfile_outB, SyscallOut, Fra_Freq,(syscall &(~equal)), RST);

alu alu1(ALUX, ALUY, ALUOP, ALU, equal);
mux_1_select mux_1_select_ALUX(regfile_outA, pc_dout, ALUX, ALUA, 1'b0);
mux_2_select mux_2_select_ALUY(regfile_outB, S_EXT, 32'h4, 32'h0, ALUY, ALUB, 1'b0);
mux_3_select mux_3_select_S_EXT(IMM0, IMM1, IMM2, IMM3, 32'ha, IMM5, 32'h0, 32'h0, S_EXT, EXT, 1'b0);

assign b_jump_success=(beq & equal) | (bne & (~equal)) | (bgez & (ALU>=32'h0));

assign PC_28_31=pc_dout[31:28];
assign PCS=S_EXT+pc_dout;
assign PC_add4=32'h4+pc_dout;

mux_1_select mux_1_select_PC_select1(PC_add4, PCS, PC_select1, b_jump_success, 1'b0);
mux_2_select mux_2_select_PC(PC_add4, PC_select1, {PC_28_31, S_EXT[25:0], 2'h0}, regfile_outA, pc_din, PC, 1'b0);

runtime_para_statistics runtime_para_statistics1(PC, beq, bne, bgez, b_jump_success, halt, Fra_Freq, RST, nocondition_num, condition_num, condition_success_num);

DemultFrequency DemultFrequency1(clk, Fre_Choice, RST, Fra_Freq, display_Freq,  Cycles);
SegmentDisplay SegmentDisplay1(SyscallOut, display_data, pc_dout, Cycles, nocondition_num, condition_num, condition_success_num, display_Freq, RST, select, LED, Segment);
endmodule
