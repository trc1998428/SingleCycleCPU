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


//project Vishera: topUnit，顶层文件单元
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
//数据选择器
output [31:0] selectOutA,
output [4:0] WriteReg,
output [31:0] selectOutB,WriteData1,WriteData,saExtendResult,
//ALU
output zero,         //各个组件模块中的output端口都是输出
output sign,
output [31:0] result,
//控制模块
output  RegWre,PCWre,ALUSrcB,ALUSrcA,DBDataSrc,RegDst,NRD,NWR,RegData,   //输出端口，总共12个
output [1:0] PCSrc,
output [2:0] ALUOpCode,
output [1:0] ExtSel,
//拓展模块
output [31:0] extendResult,
//指令存储器
output [5:0] op,
output [5:0] op2,
output [4:0] rs, rt, rd,sa,
output [15:0] immediate,
output [25:0] addr,
//PC
output [31:0] Address,      
//RAM
output [31:0] Dataout,
//寄存器组
output [31:0] ReadData1,
output [31:0] ReadData2
);

//顶层模块实现将各个模块按照CPU设计图相连的功能，将输入输出变量填写至合适的位置。
//module DataSelector(input [31:0] ReadData,input [31:0] sa,input ALuSrc,output [31:0] selectOut);
saExtendUnit saextendunit(sa,saExtendResult);
DataSelector dataselectora(ReadData1,saExtendResult,ALUSrcA,selectOutA);
DataSelector dataselectorb(ReadData2,extendResult,ALUSrcB,selectOutB);
//module ALU(input [2:0] ALUopcode,input [31:0] rega,input [31:0] regb,output zero,output sign,output reg [31:0] result);
ALU alu(ALUOpCode,selectOutA,selectOutB,zero,sign,result);
//module ControlUnit(opcode,zero,sign,RegWre,PCWre,ALUSrcA,ALUSrcB,ALUOpCode,InsMemRW,DBDataSrc,RegDst,NRD,NWR,PCSrc,ExtSel); 
ControlUnit controlunit(op,op2,zero,sign,RegWre,PCWre,ALUSrcA,ALUSrcB,ALUOpCode,InsMemRW,DBDataSrc,RegDst,NRD,NWR,PCSrc,ExtSel,RegData);
ExtendUnit extend(immediate,ExtSel,extendResult);
//module instructionMemory(input [31:0] pc,input InsMemRW,output [5:0] op,output [4:0] rs, rt, rd,output [15:0] immediate,output [26:0] addr，output [4:0] sa); 
InstructionStorage instructionstorage(Address,InsMemRW,op,op2,rs,rt,rd,immediate,addr,sa);
//module PC(input clk,input Reset,input PCWre,input [1:0] PCSrc,input [31:0] immediate,output reg [31:0] Address,input [25:0] addr);  
PC pc(clk,Reset,PCWre,PCSrc,extendResult,Address,addr);
//module RAM(input [31:0] targetAddress,input [31:0] writeData,input nRD,input nWR,output [31:0] Dataout);
RAM ram(result,ReadData2,NRD,NWR,Dataout);
//module RegFile(CLK,RST,RegWre,ReadReg1,ReadReg2,WriteReg,WriteData, ReadData1,ReadData2)
DataSelector5 dataselector5(rt,rd,RegDst,WriteReg);                //寄存器组的写入寄存器名字（5位）根据RegDst信号进行选择rt或者rd,注意使用的是5位的数据选择器
DataSelector dataselectorc(result,Dataout,DBDataSrc,WriteData1);    //寄存器组的写入值是ALU的结果或者是RAM的读取输出(lw指令)，因此需要使用32位的数据选择器
DataSelector dataselectregdata(WriteData1,extendResult,RegData,WriteData);    //寄存器组的写入值是ALU的结果或者是RAM的读取输出(lw指令)，因此需要使用32位的数据选择器
RegFile regfile(clk,RST,RegWre,rs,rt,WriteReg,WriteData,ReadData1,ReadData2);  
endmodule  