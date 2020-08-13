`timescale 1ns/1ns

module core_tb();
reg clk, rst;
wire [31:0] pc, instr, regDataOne, regDataTwo, writeData, aluRes, memReadData, aluDataTwo, sign_ext_immediate, sll_sign_ext_immediate;
wire [4:0] regFileWriteReg;
wire [2:0] aluOp;
wire zero, pcSrc, regDst, regWrite, aluSrc, memToReg, memWriteEn;

core DUT(
		.clk(clk),
		.rst(rst),
		.pc(pc),
		.instr(instr),
		.regDataOne(regDataOne),
		.regDataTwo(regDataTwo),
		.writeData(writeData),
		.regFileWriteReg(regFileWriteReg),
		.aluDataTwo(aluDataTwo),
		.aluRes(aluRes),
		.zero(zero),
		.memReadData(memReadData),
		.pcSrc(pcSrc),
		.regDst(regDst),
		.regWrite(regWrite),
		.aluSrc(aluSrc),
		.memToReg(memToReg),
		.memWriteEn(memWriteEn),
		.aluOp(aluOp),
		.sign_ext_immediate(sign_ext_immediate),
		.sll_sign_ext_immediate(sll_sign_ext_immediate));

initial
begin
	clk = 1'b0;
	forever
	begin
		#50;
		clk = ~clk;
	end
end

initial
begin
	rst = 1'b1;
	#100;
	repeat(100)
	begin
		rst = 1'b0;
		#100;
	end
end
endmodule
