`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: alu(ALU������)
//���������x and y�����������     
//          aluop(��ʾ�������)
//���������result����ʾ�������ĵ�32λ�� 
//          equal���ж�x��y�Ƿ���ȣ� 
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
    0:result=x<<(y[4:0]);//����
    1:result=($signed(x))>>>(y[4:0]);//��������
    2:result=x>>(y[4:0]);//�߼�����
    3:result=x*y;    //�ˣ�cpu�ﲻ��Ҫ�õ���
    4:result=x/y;    //����cpu�ﲻ��Ҫ�õ���
    5:result=x+y;    //�ӷ�
    6:result=x-y;    //����
    7:result=x&y;    //��λ��
    8:result=x|y;    //��λ��
    9:result=x^y;    //��λ���
    10:result=~(x|y);//��λ���
    11:result= ($signed(x)<$signed(y))?1:0;       //���űȽ�
    12:result= ($unsigned(x)<$unsigned(y))?1:0;  //�޷��űȽ�
    default:result=result;
    endcase
end

always@(x or y or aluop)
begin
    equal=(x==y)?1:0;
end
    
endmodule
