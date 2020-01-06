`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/11/18 15:37:36
// Design Name: 
// Module Name: DataSelector
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ALU(input [2:0] ALUopcode,input [31:0] rega,input [31:0] regb,output zero,output sign,output reg [31:0] result);
assign zero=(result==0)?1:0;                 //����zero����ڽ��Ϊ0��ʱ�����1����Ϊ��־ʹ��
assign sign=(result[31]==0)?0:1;             //����λ��־�Ĵ���sign���Ĵ�������λ��ֵrega[31]ʵ���Ͼ��Ƿ���λ��ֵ��������λС��1��ʱ�򽫷��ű�־λ��Ϊ1
always @( ALUopcode or rega or regb )        //��ALU����ָ����ĵ�ʱ������½�������
begin
    case (ALUopcode)  
    3'b000 : result = rega + regb;         //ALU�ӷ�
    3'b001 : result = rega - regb;         //ALU����
    3'b010 : result = regb << rega;        //ALU�߼�����
    3'b011 : result = rega | regb;         //ALU�߼���
    3'b100 : result = rega & regb;         //ALU�߼���
    3'b101 : result = (rega < regb)?1:0;   //ALU�޷��űȽ�
    3'b110 : begin	                       //ALU�����űȽ�
            if (rega<regb &&( rega[31] == regb[31]) )
            result = 1;
            else if ( rega[31] == 1 && regb[31]==0) result = 1;
            else result = 0;
            end
    3'b111 : result=rega^regb;               //ALU����ж�(һ�㲻��Ҫ��
    default : begin                 //������ALU����ָ������Чָ��
            result = 8'h00;
            $display (" no match");
            end
    endcase
end
endmodule