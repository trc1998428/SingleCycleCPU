`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/11/18 16:10:15
// Design Name: 
// Module Name: ExtendUnit
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


module ExtendUnit(
    input [15:0] immediate,
    input [1:0] ExtSel,
    output [31:0] extendResult
    );
    assign extendResult[15:0]=(ExtSel==2'b10)?16'h0000:immediate[15:0];          //后16位直接赋值成立即数immediate
    assign extendResult[31:16]=(ExtSel==2'b01)?((immediate[15]==1)?16'hffff:16'h0000):((ExtSel==2'b10)?immediate[15:0]:16'h0000); //前16位根据符号位进行符号位拓展或者是零拓展
endmodule
