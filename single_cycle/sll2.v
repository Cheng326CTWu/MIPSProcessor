module sll2
(
	a,
	res
);

	input [31:0] a;
	output [31:0] res;

	assign res = a << 2;

endmodule
