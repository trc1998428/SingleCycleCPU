`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/11/18 16:34:18
// Design Name: 
// Module Name: Top
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


//project Vishera: topUnit�������ļ���Ԫ
//`include "ALU.v"
//`include "PC.v"
//`include "ControlUnit.v"
//`include "ExtendUnit.v"
//`include "InstructionStorage.v"
//`include "RAM.v"
//`include "RegFile.v"
//`include "DataSelector.v"
//`include "DataSelector5.v"

module SingleCycleCPU(
input clk,
input Reset,
input RST,
//����ѡ����
output [31:0] selectOutA,
output [4:0] WriteReg,
output [31:0] selectOutB,WriteData1,WriteData,saExtendResult,
//ALU
output zero,         //�������ģ���е�output�˿ڶ������
output sign,
output [31:0] result,
//����ģ��
output  RegWre,PCWre,ALUSrcB,ALUSrcA,DBDataSrc,RegDst,NRD,NWR,RegData,   //����˿ڣ��ܹ�12��
output [1:0] PCSrc,
output [2:0] ALUOpCode,
output [1:0] ExtSel,
//��չģ��
output [31:0] extendResult,
//ָ��洢��
output [5:0] op,
output [5:0] op2,
output [4:0] rs, rt, rd,sa,
output [15:0] immediate,
output [25:0] addr,
//PC
output [31:0] Address,      
//RAM
output [31:0] Dataout,
//�Ĵ�����
output [31:0] ReadData1,
output [31:0] ReadData2
);

//����ģ��ʵ�ֽ�����ģ�鰴��CPU���ͼ�����Ĺ��ܣ����������������д�����ʵ�λ�á�
//module DataSelector(input [31:0] ReadData,input [31:0] sa,input ALuSrc,output [31:0] selectOut);
saExtendUnit saextendunit(sa,saExtendResult);
DataSelector dataselectora(ReadData1,saExtendResult,ALUSrcA,selectOutA);
DataSelector dataselectorb(ReadData2,extendResult,ALUSrcB,selectOutB);
//module ALU(input [2:0] ALUopcode,input [31:0] rega,input [31:0] regb,output zero,output sign,output reg [31:0] result);
ALU alu(ALUOpCode,selectOutA,selectOutB,zero,sign,result);
//module ControlUnit(opcode,zero,sign,RegWre,PCWre,ALUSrcA,ALUSrcB,ALUOpCode,InsMemRW,DBDataSrc,RegDst,NRD,NWR,PCSrc,ExtSel); 
ControlUnit controlunit(op,op2,zero,sign,RegWre,PCWre,ALUSrcA,ALUSrcB,ALUOpCode,InsMemRW,DBDataSrc,RegDst,NRD,NWR,PCSrc,ExtSel,RegData);
ExtendUnit extend(immediate,ExtSel,extendResult);
//module instructionMemory(input [31:0] pc,input InsMemRW,output [5:0] op,output [4:0] rs, rt, rd,output [15:0] immediate,output [26:0] addr��output [4:0] sa); 
InstructionStorage instructionstorage(Address,InsMemRW,op,op2,rs,rt,rd,immediate,addr,sa);
//module PC(input clk,input Reset,input PCWre,input [1:0] PCSrc,input [31:0] immediate,output reg [31:0] Address,input [25:0] addr);  
PC pc(clk,Reset,PCWre,PCSrc,extendResult,Address,addr);
//module RAM(input [31:0] targetAddress,input [31:0] writeData,input nRD,input nWR,output [31:0] Dataout);
RAM ram(result,ReadData2,NRD,NWR,Dataout);
//module RegFile(CLK,RST,RegWre,ReadReg1,ReadReg2,WriteReg,WriteData, ReadData1,ReadData2)
DataSelector5 dataselector5(rt,rd,RegDst,WriteReg);                //�Ĵ������д��Ĵ������֣�5λ������RegDst�źŽ���ѡ��rt����rd,ע��ʹ�õ���5λ������ѡ����
DataSelector dataselectorc(result,Dataout,DBDataSrc,WriteData1);    //�Ĵ������д��ֵ��ALU�Ľ��������RAM�Ķ�ȡ���(lwָ��)�������Ҫʹ��32λ������ѡ����
DataSelector dataselectregdata(WriteData1,extendResult,RegData,WriteData);    //�Ĵ������д��ֵ��ALU�Ľ��������RAM�Ķ�ȡ���(lwָ��)�������Ҫʹ��32λ������ѡ����
RegFile regfile(clk,RST,RegWre,rs,rt,WriteReg,WriteData,ReadData1,ReadData2);  
endmodule  