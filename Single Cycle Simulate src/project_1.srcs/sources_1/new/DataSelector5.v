`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/11/18 15:46:40
// Design Name: 
// Module Name: DataSelector5
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

//DataSelector5
module DataSelector5(input [4:0] ReadData,input [4:0] sa,input ALuSrc,output [4:0] selectOut);
assign selectOut = (ALuSrc == 0)? ReadData: sa;
endmodule 
