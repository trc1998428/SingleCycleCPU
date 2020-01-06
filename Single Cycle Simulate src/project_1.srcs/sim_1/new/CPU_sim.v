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
    wire zero;         //�������ģ���е�output�˿ڶ������
    wire sign;
    wire [31:0] result;
    //����ģ��
    wire RegWre,PCWre,ALUSrcB,ALUSrcA,DBDataSrc,RegDst,NRD,NWR;   //����˿ڣ��ܹ�12����
    wire RegData;
    wire [1:0]ExtSel;
    wire [1:0] PCSrc;
    wire [2:0] ALUOpCode;
    //��չģ��
    wire [31:0] extendResult;
    //ָ��洢��
    wire [5:0] op;
    wire [5:0] op2;
    wire [4:0] rs, rt, rd,sa;
    wire [15:0] immediate;
    wire [25:0] addr;
    //PC
    wire [31:0] Address;      
    //RAM
    wire [31:0] Dataout;
    //�Ĵ�����
    wire [31:0] ReadData1;
    wire [31:0] ReadData2; 
    SingleCycleCPU cpu(
    .clk(clk),
    .Reset(Reset),
    .RST(RST),
    //����ѡ����
    .selectOutA(selectOutA),
    .WriteReg(WriteReg),
    .selectOutB(selectOutB),
    .WriteData(WriteData),
    .saExtendResult(saExtendResult),
    //ALU
    .zero(zero),         //�������ģ���е�output�˿ڶ������
    .sign(sign),
    .result(result),
    //����ģ��
    .RegWre(RegWre),
    .PCWre(PCWre),
    .ALUSrcB(ALUSrcB),
    .ALUSrcA(ALUSrcA),
    .DBDataSrc(DBDataSrc),
    .RegDst(RegDst),
    .NRD(NRD),
    .NWR(NWR),
    .ExtSel(ExtSel),   //����˿ڣ��ܹ�12��
    .RegData(RegData),
    .PCSrc(PCSrc),
    .ALUOpCode(ALUOpCode),
    //��չģ��
    .extendResult(extendResult),
    //ָ��洢��
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
    //�Ĵ�����
    .ReadData1(ReadData1),
    .ReadData2(ReadData2)
    );
    initial begin  
    clk=1; 
    Reset=0;
    RST=0;
    end 
    always #5 clk=~clk; // ����Ϊ 10ns 
    initial #3 begin
    RST=1; // ��ʼ�������
    Reset=1;
    end 
endmodule
