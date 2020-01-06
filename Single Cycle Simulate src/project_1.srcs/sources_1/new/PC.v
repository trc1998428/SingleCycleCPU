`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/11/18 16:26:03
// Design Name: 
// Module Name: PC
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


//输入：时钟信号clk，重置pc地址信号Reset（0：重置），PC中断信号PCWre（0/1：中断/继续），32位立即数地址immediate，26位jump地址addr
//输出：32位更新后的pc地址Address
module PC(input clk,input Reset,input PCWre,input [1:0] PCSrc,input [31:0] immediate,output reg [31:0] Address,input [25:0] addr);       
    always @(posedge clk /*or negedge Reset*/)
    begin
        if(Reset==0)
        begin
        Address=0;
        end
        if(PCWre==1) begin   //PCWre==1对应中断指令以外的指令，这时需要重新计算PC
            //再根据不同的PCSrc指令选择不同的寻址方式
            if(PCSrc==2'b00)begin
            Address=Address+4;
            end
            if(PCSrc==2'b01) begin 
            Address=Address+4+immediate*4;
            end
            if(PCSrc==2'b10) begin   //该种情况较为特殊，这时有pc <-{(pc+4)[31..28],addr[27..2],0,0}，这时对寄存器address的各个位分别进行操作
            Address[31:0]=Address[31:0]+32'h00000004;   //十六进制数(每位相当于二进制数的四位) 
            Address[27:2]=addr[25:0];                   
            Address[1:0]=2'b00;
            end
        end
        //其他情况下为中断指令，pc的地址无需变化
    end 
endmodule 
