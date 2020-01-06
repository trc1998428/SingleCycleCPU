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


//project Vishera: RegFile，32位寄存器组单元
//输入：时钟信号CLK，重置信号RST，读取寄存器指示信号1ReadReg1，读取寄存器编号ReadReg2，写入寄存器编号WriteReg，寄存器写入值WriteData
//输出：寄存器1读取值ReadData1，寄存器2读取值ReadData2
module RegFile(CLK,RST,RegWre,ReadReg1,ReadReg2,WriteReg,WriteData, ReadData1,ReadData2);
input CLK;       //时钟信号输入'
input RST;
input RegWre;    //RegWre为1时控制写寄存器，RegWre为0时无写寄存器
input [4:0] ReadReg1,ReadReg2,WriteReg;      //读取的寄存器名称（最多两个寄存器，每个寄存器的名称为5位）
input [31:0] WriteData;                      //写入的寄存器值（本实验中使用的寄存器都是32位）
output [31:0] ReadData1,ReadData2;           //读取的寄存器值
reg [31:0] regFile[1:31];                    // 寄存器定义必须用reg类型 
integer i;
assign ReadData1 = (ReadReg1 == 0) ? 0 : regFile[ReadReg1];  //读寄存器数据1，0寄存器的值读取为0
assign ReadData2 = (ReadReg2 == 0) ? 0 : regFile[ReadReg2];  //读寄存器数据2，0寄存器的值读取为0
always @ (negedge CLK or negedge RST) begin    // 必须用时钟边沿触发
    if (RST==0) begin                   
    for(i=1;i<32;i=i+1)                   
    regFile[i] <= 0;           
    end 
    else if(RegWre == 1 && WriteReg != 0)   // WriteReg != 0]时才能修改寄存器，因$0寄存器不能修改
    regFile[WriteReg] <= WriteData;    // 写寄存器
end
endmodule
    