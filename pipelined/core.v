`include "mux2.v"
`include "register_file.v"
`include "mux3.v"
`include "sll2.v"
`include "rom.v"
`include "ram.v"
`include "adder.v"
`include "sign_ext.v"
`include "hazard.v"
`include "forwarding.v"
`include "register.v"
`include "MEM_WB.v"
`include "ID_EX.v"
`include "control.v"
`include "alu.v"
`include "EX_MEM.v"
`include "IF_ID.v"
`include "comparator.v"

module core
(
    clk,
    rst,
    pc_IF,
    instr_IF,
    instr_ID,
    instr_EX,
    signExtImmed_ID,
    sllSignExtImmed_ID,
    signExtImmed_EX,
);

    input clk, rst;

    // IF wires
    output [31:0] pc_IF, instr_IF;
    wire [31:0] pcNext_IF, pcAdd4_IF;
    wire pcSrc_IF;
    wire IF_stall;

    // ID wires
    output [31:0] instr_ID, signExtImmed_ID, sllSignExtImmed_ID;
    wire [2:0] aluOp_ID;
    wire [31:0] regFileDataOne_ID, regFileDataTwo_ID;
    wire [31:0] pcAdd4_ID, pcBranchAdderRes_ID;
    wire regDst_ID, regWrite_ID, memToReg_ID, memWriteEn_ID, aluSrc_ID;
    wire equalFlag;
    wire [7:0] controlSignals_ID, controlMuxOut_ID;
    wire ID_stall;

    // EX wires
    output [31:0] instr_EX, signExtImmed_EX;
    wire [31:0] regFileDataOne_EX, regFileDataTwo_EX;
    wire [2:0] aluOp_EX;
    wire [31:0] aluDataOne_EX, aluDataTwo_EX, forwardMux2Out_EX;
    wire [31:0] aluRes_EX;
    wire [1:0] forwardA_EX, forwardB_EX;
    wire [4:0] writeReg_EX;
    wire aluZero_EX, aluSrc_EX;
    wire regDst_EX, regWrite_EX, memToReg_EX, memWriteEn_EX;

    // MEM wires
    wire [31:0] readData_MEM;
    wire [31:0] aluRes_MEM;
    wire [4:0] writeReg_MEM;
    wire [31:0] writeData_MEM;
    wire regWrite_MEM, memToReg_MEM, memWriteEn_MEM;

    // WB wires
    wire [31:0] readData_WB;
    wire [31:0] aluRes_WB;
    wire [4:0] writeReg_WB;
    wire [31:0] writeData_WB;
    wire regWrite_WB, memToReg_WB;

    // Instruction Fetch Stage (IF)
    rom instrMem(.pc(pc_IF), .instruction(instr_IF));
    register #(32) pcRegister(.clk(clk), .rst(rst), .stall(!IF_stall), .d(pcNext_IF), .q(pc_IF));
    adder #(32) pcAdd4(.a(pc_IF), .b(32'd4), .sum(pcAdd4_IF));
    mux2_1 #(32) pcBranchMux(.d0(pcAdd4_IF), .d1(pcBranchAdderRes_ID), .sel(pcSrc_IF), .out(pcNext_IF));

    // IF_ID
    IF_ID_reg IF_ID_Reg(.clk(clk), .rst(rst), .stall(ID_stall), .pcPlus4_IF(pcAdd4_IF), .instr_IF(instr_IF), .pcPlus4_ID(pcAdd4_ID), .instr_ID(instr_ID));

    // Instruction Decode Stage (ID)
    control ctrlUnit(.opCode(instr_ID[31:26]), .func(instr_ID[5:0]), .equalFlag(equalFlag),
                     .controlSignals_ID(controlSignals_ID), .pcSrc_IF(pcSrc_IF));

    mux2_1 #(8) ctrlMux(.d0(controlSignals_ID), .d1(0), .sel(ID_stall), .out(controlMuxOut_ID));
    assign {regDst_ID, regWrite_ID, aluSrc_ID, memWriteEn_ID, memToReg_ID, aluOp_ID} = controlMuxOut_ID;
    sign_ext immediateSignExt(.a(instr_ID[15:0]), .out(signExtImmed_ID));
    sll2 shiftLeft2(.a(signExtImmed_ID), .res(sllSignExtImmed_ID));
    register_file reg_fil(.clk(clk), .rst(rst), .readRegister1(instr_ID[25:21]), .readRegister2(instr_ID[20:16]),
                          .writeRegister(writeReg_WB), .writeData(writeData_WB), .regWrite(regWrite_WB),
                          .readData1(regFileDataOne_ID), .readData2(regFileDataTwo_ID));

    equalComparator #(32) comparator(.data1(aluDataOne_EX), .data2(forwardMux2Out_EX), .equal(equalFlag));
    adder #(32) pcBranchAdder(.a(sllSignExtImmed_ID), .b(pcAdd4_ID), .sum(pcBranchAdderRes_ID));

    hazard hazardUnit(.instr_ID(instr_ID), .rt_EX(instr_EX[20:16]), .rs_ID(instr_ID[25:21]), .rt_ID(instr_ID[20:16]),
                      .writeReg_MEM(writeReg_MEM), .writeReg_EX(writeReg_EX), .regWrite_EX(regWrite_EX),
                      .memToReg_MEM(memToReg_MEM), .memToReg_EX(memToReg_EX),
                      .IF_ID_stall(IF_stall), .ID_EX_stall(ID_stall));

    // ID_EX
    ID_EX_reg ID_EX_Reg(.clk(clk), .rst(rst), .regFileDataOne_ID(regFileDataOne_ID), .regFileDataOne_EX(regFileDataOne_EX),
                        .regFileDataTwo_ID(regFileDataTwo_ID), .regFileDataTwo_EX(regFileDataTwo_EX),
                        .signExtImmed_ID(signExtImmed_ID), .signExtImmed_EX(signExtImmed_EX),
                        .instr_ID(instr_ID), .instr_EX(instr_EX), .regWrite_ID(regWrite_ID), .regWrite_EX(regWrite_EX),
                        .memToReg_ID(memToReg_ID), .memToReg_EX(memToReg_EX), .memWrite_ID(memWriteEn_ID),
                        .memWrite_EX(memWriteEn_EX), .aluOp_ID(aluOp_ID), .aluOp_EX(aluOp_EX),
                        .aluSrc_ID(aluSrc_ID), .aluSrc_EX(aluSrc_EX), .regDst_ID(regDst_ID), .regDst_EX(regDst_EX));

    // Instruction Execution Stage (EX)
    // Route the result of these 2 3:1 mux back to ID stage to do equal comparator
    mux3_1 #(32) forwardMux1(.d0(regFileDataOne_EX), .d1(writeData_WB), .d2(aluRes_MEM), .sel(forwardA_EX), .out(aluDataOne_EX));
    mux3_1 #(32) forwardMux2(.d0(regFileDataTwo_EX), .d1(writeData_WB), .d2(aluRes_MEM), .sel(forwardB_EX), .out(forwardMux2Out_EX));
    mux2_1 #(32) aluDataTwoMux(.d0(forwardMux2Out_EX), .d1(signExtImmed_EX), .sel(aluSrc_EX), .out(aluDataTwo_EX));
    alu ALU(.a(aluDataOne_EX), .b(aluDataTwo_EX), .f(aluOp_EX), .shift_amt(instr_EX[10:6]), .res(aluRes_EX), .zero(aluZero_EX));
    mux2_1 #(32) writeRegMux(.d0(instr_EX[20:16]), .d1(instr_EX[15:11]), .sel(regDst_EX), .out(writeReg_EX));

    forward #(5) forwardUnit(.EX_MEM_rd(writeReg_MEM), .MEM_WB_rd(writeReg_WB), .ID_EX_rs(instr_EX[25:21]), .ID_EX_rt(instr_EX[20:16]),
                             .EX_MEM_regWrite(regWrite_MEM), .MEM_WB_regWrite(regWrite_WB), .forwardA(forwardA_EX), .forwardB(forwardB_EX));

    // EX_MEM
    EX_MEM_reg EX_MEM_Reg(.clk(clk), .rst(rst), .aluRes_EX(aluRes_EX), .aluRes_MEM(aluRes_MEM), .writeData_EX(forwardMux2Out_EX),
                          .writeData_MEM(writeData_MEM), .writeReg_EX(writeReg_EX), .writeReg_MEM(writeReg_MEM), .memToReg_EX(memToReg_EX),
                          .memToReg_MEM(memToReg_MEM), .memWrite_EX(memWriteEn_EX), .memWrite_MEM(memWriteEn_MEM),
                          .regWrite_EX(regWrite_EX), .regWrite_MEM(regWrite_MEM));

    // Memory Stage (MEM)
    ram dataMem(.clk(clk), .address(aluRes_MEM), .writeEn(memWriteEn_MEM), .dataIn(writeData_MEM), .dataOut(readData_MEM));

    // MEM_WB
    MEM_WB_reg MEM_WB_Reg(.clk(clk), .rst(rst), .readData_MEM(readData_MEM), .readData_WB(readData_WB),
                          .aluRes_MEM(aluRes_MEM), .aluRes_WB(aluRes_WB), .writeReg_MEM(writeReg_MEM), .writeReg_WB(writeReg_WB),
                          .regWrite_MEM(regWrite_MEM), .regWrite_WB(regWrite_WB), .memToReg_MEM(memToReg_MEM), .memToReg_WB(memToReg_WB));

    // Writeback Stage (WB)
    mux2_1 #(32) writeBackMux(.d0(aluRes_WB), .d1(readData_WB), .sel(memToReg_WB), .out(writeData_WB));

endmodule
