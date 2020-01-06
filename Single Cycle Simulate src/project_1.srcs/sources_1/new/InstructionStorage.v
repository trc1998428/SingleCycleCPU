`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/11/18 16:20:52
// Design Name: 
// Module Name: InstructionStorage
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


module InstructionStorage(
    input [31:0] pc,        //PC地址
    input InsMemRW,         //读取/写入指令控制端
    output [5:0] op,        //指令操作码
    output [5:0] op2, 
    output [4:0] rs,        //操作寄存器rs的编号
    output [4:0] rt,        //操作寄存器rt的编号
    output [4:0] rd,        //操作寄存器rd的编号
    output [15:0] immediate,//操作码中的立即数
    output [25:0] addr,     //指令jump中的addr特殊地址
    output [4:0] sa        //移位指令sll中的移位位数寄存器sa的编号
    );
    wire [31:0] mem[0:8];  
    //ADDIU $1,$1,12
    assign mem[0] = 32'b00100100001000010000000000001100; 
    //ORI $2,$2,12
    assign mem[1] = 32'b00110100010000100000000000001100;  
    //ADD $3,$3,$2
    assign mem[2] = 32'b00000000011000100001100000100000;  
    //BEQ $1,$3,-2
    assign mem[3] = 32'b00010000001000111111111111111110;  
    //SW $1,0($2)
    assign mem[4] = 32'b10101100010000010000000000000000;  
    //LW $4,0($2)
    assign mem[5] = 32'b10001100010001000000000000000000;  
    //LUI $5,2
    assign mem[6] = 32'b00111100000001010000000000000010;  
    //ADD $3,$5,$4 
    assign mem[7] = 32'b00000000101001000001100000100000;  
    //J 00000000
    assign mem[8] = 32'b00001000000000000000000000000000;    
        //end
        // output  
        assign op = mem[pc[6:2]][31:26];    //指令码op编号      //这时因为指令地址从0x00000000到0x00000044，因此应该截取pc[6:2]，注意移位两位
        assign op2 = mem[pc[6:2]][5:0];
        assign rs = mem[pc[6:2]][25:21];    //寄存器rs编号
        assign rt = mem[pc[6:2]][20:16];    //寄存器rt编号
        assign rd = mem[pc[6:2]][15:11];    //寄存器rd编号
        assign immediate = mem[pc[6:2]][15:0];   //立即数
        assign addr = mem[pc[6:2]][25:0];        //j指令使用的26位立即数地址，注意认真阅读j指令的指令说明
        assign sa = mem[pc[6:2]][10:6];         //寄存器sa编号
endmodule
