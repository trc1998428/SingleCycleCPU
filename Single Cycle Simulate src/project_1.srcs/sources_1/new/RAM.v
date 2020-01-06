`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/11/18 16:30:20
// Design Name: 
// Module Name: RAM
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


//project Vishera: RAM
//输入：需要读取或者写入的地址targetAddress，需要写入的32位寄存器的值writeData，读写信号nRD，nWR，读取结果Dataout
//重要注明：nWR为0时进行写操作，nWR=!wr
module RAM(
input [31:0] targetAddress,  //要读取的RAM地址或者是要写入的RAM地址，均来自寄存器rt的值
input [31:0] writeData, //要读取或者写入的RAM地址 //不论读取还是写入都分为4个8位单元进行，即[31:24], [23:16], [15:8], [7:0]
input nRD,	// 为0，正常读；为1,输出高组态
input nWR,	// 为0，写；为1，无操作
output [31:0] Dataout     //读取RAM时所读取的数据
);
reg [7:0] ram [0:60];	// 存储器定义必须用reg类型，本例中必须使用8位的RAM
//读
//因为在本实验设计中使用的RAM是8位的，因此要输出一个32位的传送给寄存器的内容，必须分4次对RAM进行读写
assign Dataout[7:0] = (nRD==0)?ram[targetAddress + 3]:8'bz; // z 为高阻态 
assign Dataout[15:8] = (nRD==0)?ram[targetAddress + 2]:8'bz;
assign Dataout[23:16] = (nRD==0)?ram[targetAddress + 1]:8'bz; 
assign Dataout[31:24] = (nRD==0)?ram[targetAddress ]:8'bz; 
//写
always@( nWR or targetAddress or writeData ) begin 
if(nWR==0) begin

ram[targetAddress] <= writeData[31:24]; 
ram[targetAddress+1] <=writeData[23:16];
ram[targetAddress+2] <=writeData[15:8]; 
ram[targetAddress+3] <=writeData[7:0];

end
end
endmodule
