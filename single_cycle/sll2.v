module sll2
(
	a,
	y
);

	input [31:0] a;
	output [31:0] y;

	assign y = a << 2;

endmodule
