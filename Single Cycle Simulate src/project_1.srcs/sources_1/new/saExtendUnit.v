`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/11/19 08:39:49
// Design Name: 
// Module Name: saExtendUnit
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


module saExtendUnit(
input [4:0] sa,
output [31:0] saExtendResult
    );
assign saExtendResult[4:0]=sa;
assign saExtendResult[31:5]=27'b000000000000000000000000000;
endmodule
