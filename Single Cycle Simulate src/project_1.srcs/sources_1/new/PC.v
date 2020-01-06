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


//���룺ʱ���ź�clk������pc��ַ�ź�Reset��0�����ã���PC�ж��ź�PCWre��0/1���ж�/��������32λ��������ַimmediate��26λjump��ַaddr
//�����32λ���º��pc��ַAddress
module PC(input clk,input Reset,input PCWre,input [1:0] PCSrc,input [31:0] immediate,output reg [31:0] Address,input [25:0] addr);       
    always @(posedge clk /*or negedge Reset*/)
    begin
        if(Reset==0)
        begin
        Address=0;
        end
        if(PCWre==1) begin   //PCWre==1��Ӧ�ж�ָ�������ָ���ʱ��Ҫ���¼���PC
            //�ٸ��ݲ�ͬ��PCSrcָ��ѡ��ͬ��Ѱַ��ʽ
            if(PCSrc==2'b00)begin
            Address=Address+4;
            end
            if(PCSrc==2'b01) begin 
            Address=Address+4+immediate*4;
            end
            if(PCSrc==2'b10) begin   //���������Ϊ���⣬��ʱ��pc <-{(pc+4)[31..28],addr[27..2],0,0}����ʱ�ԼĴ���address�ĸ���λ�ֱ���в���
            Address[31:0]=Address[31:0]+32'h00000004;   //ʮ��������(ÿλ�൱�ڶ�����������λ) 
            Address[27:2]=addr[25:0];                   
            Address[1:0]=2'b00;
            end
        end
        //���������Ϊ�ж�ָ�pc�ĵ�ַ����仯
    end 
endmodule 
