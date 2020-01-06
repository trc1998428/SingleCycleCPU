`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/11/18 16:30:20
// Design Name: 
// Module Name: RAM
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


//project Vishera: RAM
//���룺��Ҫ��ȡ����д��ĵ�ַtargetAddress����Ҫд���32λ�Ĵ�����ֵwriteData����д�ź�nRD��nWR����ȡ���Dataout
//��Ҫע����nWRΪ0ʱ����д������nWR=!wr
module RAM(
input [31:0] targetAddress,  //Ҫ��ȡ��RAM��ַ������Ҫд���RAM��ַ�������ԼĴ���rt��ֵ
input [31:0] writeData, //Ҫ��ȡ����д���RAM��ַ //���۶�ȡ����д�붼��Ϊ4��8λ��Ԫ���У���[31:24], [23:16], [15:8], [7:0]
input nRD,	// Ϊ0����������Ϊ1,�������̬
input nWR,	// Ϊ0��д��Ϊ1���޲���
output [31:0] Dataout     //��ȡRAMʱ����ȡ������
);
reg [7:0] ram [0:60];	// �洢�����������reg���ͣ������б���ʹ��8λ��RAM
//��
//��Ϊ�ڱ�ʵ�������ʹ�õ�RAM��8λ�ģ����Ҫ���һ��32λ�Ĵ��͸��Ĵ��������ݣ������4�ζ�RAM���ж�д
assign Dataout[7:0] = (nRD==0)?ram[targetAddress + 3]:8'bz; // z Ϊ����̬ 
assign Dataout[15:8] = (nRD==0)?ram[targetAddress + 2]:8'bz;
assign Dataout[23:16] = (nRD==0)?ram[targetAddress + 1]:8'bz; 
assign Dataout[31:24] = (nRD==0)?ram[targetAddress ]:8'bz; 
//д
always@( nWR or targetAddress or writeData ) begin 
if(nWR==0) begin

ram[targetAddress] <= writeData[31:24]; 
ram[targetAddress+1] <=writeData[23:16];
ram[targetAddress+2] <=writeData[15:8]; 
ram[targetAddress+3] <=writeData[7:0];

end
end
endmodule
