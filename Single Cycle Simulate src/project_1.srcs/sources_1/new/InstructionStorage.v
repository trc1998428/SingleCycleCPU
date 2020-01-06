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
    input [31:0] pc,        //PC��ַ
    input InsMemRW,         //��ȡ/д��ָ����ƶ�
    output [5:0] op,        //ָ�������
    output [5:0] op2, 
    output [4:0] rs,        //�����Ĵ���rs�ı��
    output [4:0] rt,        //�����Ĵ���rt�ı��
    output [4:0] rd,        //�����Ĵ���rd�ı��
    output [15:0] immediate,//�������е�������
    output [25:0] addr,     //ָ��jump�е�addr�����ַ
    output [4:0] sa        //��λָ��sll�е���λλ���Ĵ���sa�ı��
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
        assign op = mem[pc[6:2]][31:26];    //ָ����op���      //��ʱ��Ϊָ���ַ��0x00000000��0x00000044�����Ӧ�ý�ȡpc[6:2]��ע����λ��λ
        assign op2 = mem[pc[6:2]][5:0];
        assign rs = mem[pc[6:2]][25:21];    //�Ĵ���rs���
        assign rt = mem[pc[6:2]][20:16];    //�Ĵ���rt���
        assign rd = mem[pc[6:2]][15:11];    //�Ĵ���rd���
        assign immediate = mem[pc[6:2]][15:0];   //������
        assign addr = mem[pc[6:2]][25:0];        //jָ��ʹ�õ�26λ��������ַ��ע�������Ķ�jָ���ָ��˵��
        assign sa = mem[pc[6:2]][10:6];         //�Ĵ���sa���
endmodule
