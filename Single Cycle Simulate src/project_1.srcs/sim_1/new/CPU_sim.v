`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/11/19 08:50:12
// Design Name: 
// Module Name: CPU_sim
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


module CPU_sim(
    );
    //input
    reg clk;
    reg RST;
    reg Reset;
    //output
    wire [31:0] selectOutA;
    wire [4:0] WriteReg;
    wire [31:0] selectOutB,WriteData,saExtendResult;
    //ALU
    wire zero;         //各个组件模块中的output端口都是输出
    wire sign;
    wire [31:0] result;
    //控制模块
    wire RegWre,PCWre,ALUSrcB,ALUSrcA,DBDataSrc,RegDst,NRD,NWR;   //输出端口，总共12个‘
    wire RegData;
    wire [1:0]ExtSel;
    wire [1:0] PCSrc;
    wire [2:0] ALUOpCode;
    //拓展模块
    wire [31:0] extendResult;
    //指令存储器
    wire [5:0] op;
    wire [5:0] op2;
    wire [4:0] rs, rt, rd,sa;
    wire [15:0] immediate;
    wire [25:0] addr;
    //PC
    wire [31:0] Address;      
    //RAM
    wire [31:0] Dataout;
    //寄存器组
    wire [31:0] ReadData1;
    wire [31:0] ReadData2; 
    SingleCycleCPU cpu(
    .clk(clk),
    .Reset(Reset),
    .RST(RST),
    //数据选择器
    .selectOutA(selectOutA),
    .WriteReg(WriteReg),
    .selectOutB(selectOutB),
    .WriteData(WriteData),
    .saExtendResult(saExtendResult),
    //ALU
    .zero(zero),         //各个组件模块中的output端口都是输出
    .sign(sign),
    .result(result),
    //控制模块
    .RegWre(RegWre),
    .PCWre(PCWre),
    .ALUSrcB(ALUSrcB),
    .ALUSrcA(ALUSrcA),
    .DBDataSrc(DBDataSrc),
    .RegDst(RegDst),
    .NRD(NRD),
    .NWR(NWR),
    .ExtSel(ExtSel),   //输出端口，总共12个
    .RegData(RegData),
    .PCSrc(PCSrc),
    .ALUOpCode(ALUOpCode),
    //拓展模块
    .extendResult(extendResult),
    //指令存储器
    .op(op),
    .op2(op2),
    .rs(rs), 
    .rt(rt),
    .rd(rd),
    .sa(sa),
    .immediate(immediate),
    .addr(addr),
    //PC
    .Address(Address),      
    //RAM
    .Dataout(Dataout),
    //寄存器组
    .ReadData1(ReadData1),
    .ReadData2(ReadData2)
    );
    initial begin  
    clk=1; 
    Reset=0;
    RST=0;
    end 
    always #5 clk=~clk; // 周期为 10ns 
    initial #3 begin
    RST=1; // 开始仿真输出
    Reset=1;
    end 
endmodule
