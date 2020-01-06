`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/11/18 15:59:00
// Design Name: 
// Module Name: ControlUnit
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


//code review passed on 11.18
//project Vishera: controlUnit，信号控制单元
module ControlUnit(
    input [5:0] opcode,
    input [5:0] opcode2,
    input zero,
    input sign,
    output RegWre,
    output PCWre,
    output ALUSrcA,
    output ALUSrcB,
    output [2:0] ALUOp,
    output InsMemRW,
    output DBDataSrc,
    output RegDst,
    output NRD,
    output NWR,
    output [1:0] PCSrc,
    output [1:0] ExtSel,
    output RegData
    );  
    assign RegWre=(opcode==6'b000100||opcode==6'b101011||opcode==6'b000010)?0:1;
    assign PCWre=1;
    assign ALUSrcA=0;
    assign ALUSrcB=(opcode==6'b001000||opcode==6'b001001||opcode==6'b001101||opcode==6'b101011||opcode==6'b100011)?1:0;
    assign ALUOp[0]=(opcode==6'b001000||opcode==6'b001001||(opcode==6'b000000&&opcode2==6'b100000)||(opcode==6'b000000&&opcode2==6'b100100)||opcode==6'b101011||opcode==6'b100011||opcode==6'b000010)?0:1;
    assign ALUOp[1]=(opcode==6'b001101)?1:0;
    assign ALUOp[2]=((opcode==6'b000000&&opcode2==6'b100100))?1:0;
    assign InsMemRW=1;
    assign DBDataSrc=(opcode==6'b100011)?1:0;
    assign RegDst=((opcode==6'b000000&&opcode2==6'b100000)||opcode==6'b000010||(opcode==6'b000000&&opcode2==6'b100100))?1:0;
    assign NRD=(opcode==6'b100011)?0:1;
    assign NWR=(opcode==6'b101011)?0:1;
    assign PCSrc[0]=((opcode==6'b000100&&zero==1))?1:0;
    assign PCSrc[1]=(opcode==6'b000010)?1:0;
    assign ExtSel=(opcode==6'b001000||opcode==6'b001001||opcode==6'b101011||opcode==6'b100011|||opcode==6'b000100)?2'b01:((opcode==6'b001111)?2'b10:0);
    assign RegData=(opcode==6'b001111)?1:0;
endmodule