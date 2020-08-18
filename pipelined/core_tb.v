`timescale 1ns/1ns

module core_tb();
reg clk, rst;
wire [31:0] pc_IF, instr_IF, instr_ID, instr_EX, signExtImmed_ID, sllSignExtImmed_ID, signExtImmed_EX;

core DUT(
        .clk(clk),
        .rst(rst),
        .pc_IF(pc_IF),
        .instr_IF(instr_IF),
        .instr_ID(instr_ID),
        .instr_EX(instr_EX),
        .signExtImmed_ID(signExtImmed_ID),
        .sllSignExtImmed_ID(sllSignExtImmed_ID),
        .signExtImmed_EX(signExtImmed_EX)
        );


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
