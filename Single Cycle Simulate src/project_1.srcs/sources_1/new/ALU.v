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
assign zero=(result==0)?1:0;                 //控制zero输出在结果为0的时候输出1，作为标志使用
assign sign=(result[31]==0)?0:1;             //符号位标志寄存器sign，寄存器单个位的值rega[31]实际上就是符号位的值，当符号位小于1的时候将符号标志位设为1
always @( ALUopcode or rega or regb )        //当ALU控制指令更改的时候就重新进行运算
begin
    case (ALUopcode)  
    3'b000 : result = rega + regb;         //ALU加法
    3'b001 : result = rega - regb;         //ALU减法
    3'b010 : result = regb << rega;        //ALU逻辑左移
    3'b011 : result = rega | regb;         //ALU逻辑或
    3'b100 : result = rega & regb;         //ALU逻辑与
    3'b101 : result = (rega < regb)?1:0;   //ALU无符号比较
    3'b110 : begin	                       //ALU带符号比较
            if (rega<regb &&( rega[31] == regb[31]) )
            result = 1;
            else if ( rega[31] == 1 && regb[31]==0) result = 1;
            else result = 0;
            end
    3'b111 : result=rega^regb;               //ALU相等判断(一般不需要）
    default : begin                 //其他的ALU控制指令是无效指令
            result = 8'h00;
            $display (" no match");
            end
    endcase
end
endmodule