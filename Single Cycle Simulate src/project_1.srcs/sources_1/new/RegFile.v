`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/11/18 16:33:03
// Design Name: 
// Module Name: RegFile
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


//project Vishera: RegFile��32λ�Ĵ����鵥Ԫ
//���룺ʱ���ź�CLK�������ź�RST����ȡ�Ĵ���ָʾ�ź�1ReadReg1����ȡ�Ĵ������ReadReg2��д��Ĵ������WriteReg���Ĵ���д��ֵWriteData
//������Ĵ���1��ȡֵReadData1���Ĵ���2��ȡֵReadData2
module RegFile(CLK,RST,RegWre,ReadReg1,ReadReg2,WriteReg,WriteData, ReadData1,ReadData2);
input CLK;       //ʱ���ź�����'
input RST;
input RegWre;    //RegWreΪ1ʱ����д�Ĵ�����RegWreΪ0ʱ��д�Ĵ���
input [4:0] ReadReg1,ReadReg2,WriteReg;      //��ȡ�ļĴ������ƣ���������Ĵ�����ÿ���Ĵ���������Ϊ5λ��
input [31:0] WriteData;                      //д��ļĴ���ֵ����ʵ����ʹ�õļĴ�������32λ��
output [31:0] ReadData1,ReadData2;           //��ȡ�ļĴ���ֵ
reg [31:0] regFile[1:31];                    // �Ĵ������������reg���� 
integer i;
assign ReadData1 = (ReadReg1 == 0) ? 0 : regFile[ReadReg1];  //���Ĵ�������1��0�Ĵ�����ֵ��ȡΪ0
assign ReadData2 = (ReadReg2 == 0) ? 0 : regFile[ReadReg2];  //���Ĵ�������2��0�Ĵ�����ֵ��ȡΪ0
always @ (negedge CLK or negedge RST) begin    // ������ʱ�ӱ��ش���
    if (RST==0) begin                   
    for(i=1;i<32;i=i+1)                   
    regFile[i] <= 0;           
    end 
    else if(RegWre == 1 && WriteReg != 0)   // WriteReg != 0]ʱ�����޸ļĴ�������$0�Ĵ��������޸�
    regFile[WriteReg] <= WriteData;    // д�Ĵ���
end
endmodule
    