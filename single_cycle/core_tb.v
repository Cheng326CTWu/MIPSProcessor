`timescale 1ns/1ns

module core_tb();
reg clk, rst;

core DUT(.clk(clk), .rst(rst));

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
	rst = 1;
	#100;
	repeat(10)
	begin
		rst = 0;
		#100;
	end
end
endmodule

// instruction order as follow
// addi
// addi
// addi
// or
// and
// add
// beq
// slt
// beq
// addi
// slt
// add
// sub
// sw
// lw
// addi
// sw
