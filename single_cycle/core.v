`include "ram.v"
`include "rom.v"
`include "adder.v"
`include "sign_ext.v"
`include "mux2.v"
`include "mux4.v"
`include "alu.v"
`include "register_file32.v"
`include "sll2.v"
`include "register32.v"
`include "control.v"

module core
(
	clk,
	rst
);

	input clk, rst;

	// PC wires
	wire [31:0] pc, pc_next, pc_add_4, pc_branch_add_res;
	wire [31:0] sign_ext_immediate, sll_sign_ext_immediate;
	wire [31:0] instr;
	wire pcSrc;

	// reg file wires
	wire [31:0] writeData, regDataOne, regDataTwo;
	wire [4:0] regFileWriteReg;
	wire regWrite, regDst;

	// alu wires
	wire [31:0] aluRes, aluDataTwo;
	wire [2:0] aluOp;
	wire zero, aluSrc;

	// data memory wires
	wire [31:0] memReadData;
	wire memToReg, memWriteEn;
	
	// control unit
	//controlUnit controller();

	// instruction memory
	rom instrMem(.pc(pc), .instruction(instr));

	// PC
	register #(32) pcRegister(.clk(clk), .rst(rst), .d(pc_next), .q(pc));
	adder #(32) pcAdd4(.a(pc), .b(32'd4), .sum(pc_add_4));
	sll2 shiftLeft2(.a(sign_ext_immediate), .res(sll_sign_ext_immediate));
	adder #(32) pcBranchAdder(.a(pc_add_4), .b(sll_sign_ext_immediate), .sum(pc_branch_adder_res));
	mux2_1 #(32) pcBranchMux(.d0(pc_add_4), .d1(pc_branch_adder_res), .sel(pcSrc), .out(pc_next));

	// Register File
	mux2_1 #(5) writeRegMux(.d0(instr[20:16]), .d1(instr[15:11]), .sel(regDst), .out(regFileWriteReg));
	register_file32 reg_file(.clk(clk), .rst(rst), .readRegister1(instr[25:21]), .readRegister2(instr[20:16]), .writeRegister(regFileWriteReg),
							.writeData(writeData), .regWrite(regWrite), .readData1(regDataOne), .readData2(regDataTwo));
	
	// ALU
	mux2_1 #(32) aluDataTwoMux(.d0(regDataTwo), .d1(sign_ext_immedate), .sel(aluSrc), .out(aluDataTwo));
	alu ALU(.a(regDataOne), .b(aluDataTwo), .f(aluOp), .shift_amt(instr[10:6]), .res(aluRes), .zero(zero));
	sign_ext immediateSignExt(.a(instr[15:0]), .out(sign_ext_immedate));

	// data memory
	ram dataMem(.clk(clk), .address(aluRes), .writeEn(memWriteEn), .dataIn(regDataTwo), .dataOut(memReadData));
	mux2_1 #(32) memWriteBackMux(.d0(aluRes), .d1(memReadData), .sel(memToReg), .out(writeData));

endmodule

