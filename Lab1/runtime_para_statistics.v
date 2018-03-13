// Record some runtime datas
//
// Input : pc_control_sign. Control sign -- "PC" in logsim
// Input : beq_control_sign. Control sign -- "beq" in logsim
// Input : bne_control_sign. Control sign -- "bne" in logsim
// Input : bgez_control_sign. Control sign -- "bgez" in logsim
// Input : b_success_sign. b command success sign -- "b指令成功跳转" in logsim
// Input : halt_sign. halt sign -- "halt" in logsim
// Input : clk. "clk" in logsim
// Input : RST. "RST" in logsim
// Output : nocondition_num.  No condition command number -- "无条件分支指令数" in logsim
// Output : condition_num. Condition command number -- "有条件分支指令数" in logsim
// Output : condition_success_num. Condition and success command number -- "有条件分支成功跳转" in logsim
module runtime_para_statistics(
pc_control_sign,
beq_control_sign,
bne_control_sign,
bgez_control_sign,
b_success_sign,
halt_sign,
clk,
RST,
nocondition_num,
condition_num,
condition_success_num
);

input   pc_control_sign;
input   beq_control_sign;
input   bne_control_sign;
input   bgez_control_sign;
input   b_success_sign;
input   halt_sign;
input   clk;
input   RST;
output  nocondition_num;
output  condition_num;
output  condition_success_num;

// Inputs
wire[1:0]   pc_control_sign;
wire        beq_control_sign;
wire        bne_control_sign;
wire        bgez_control_sign;
wire        b_success_sign;
wire        halt_sign;
wire        clk;
wire        RST;

// Outputs
reg [15:0]  nocondition_num;
reg [15:0]  condition_num;
reg [15:0]  condition_success_num;

// Tmp reg variables
wire tmp_or_1;
wire tmp_or_2;
wire tmp_and_1;
wire tmp_and_2;
wire tmp_and_3;
wire tmp_pc_1;
wire tmp_pc_2;

or U0(tmp_or_1, tmp_pc_1, tmp_pc_2);
or U1(tmp_or_2, beq_control_sign, bne_control_sign, bgez_control_sign);
and U2(tmp_and_1, tmp_or_1, halt_sign);
and U3(tmp_and_2, tmp_or_2, halt_sign);
and U4(tmp_and_3, b_success_sign, halt_sign);

initial begin
    nocondition_num = 16'd0;
    condition_num = 16'd0;
    condition_success_num = 16'd0;
end

assign tmp_pc_1 = pc_control_sign == 2'd2;
assign tmp_pc_2 = pc_control_sign == 2'd3;

always @(posedge clk) begin
    if (RST) begin
        nocondition_num = 16'd0;
        condition_num = 16'd0;
        condition_success_num = 16'd0;
    end else begin
        if (tmp_and_1) begin
            nocondition_num = nocondition_num + 1;
        end 
        if (tmp_and_2) begin
            condition_num = condition_num + 1;
        end
        if (tmp_and_3) begin
            condition_success_num = condition_success_num + 1;
        end
    end
end

endmodule // runtime_para_statistics