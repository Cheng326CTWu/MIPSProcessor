module adder
(
	a,
	b,
	sum
);

	parameter n = 32;

	input [n-1:0] a, b;
	output [n-1:0] sum;

	assign sum = a + b;

endmodule
