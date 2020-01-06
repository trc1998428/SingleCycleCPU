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

//双32位数据选择器DataSelect
module DataSelector(
    input [31:0] ReadData,
    input [31:0] sa,
    input ALuSrc,
    output [31:0] selectOut
    );
    assign selectOut = (ALuSrc == 0)? ReadData: sa;
    endmodule
