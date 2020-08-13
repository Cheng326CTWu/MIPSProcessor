module sign_ext
(
	a,
	out
);

	input [15:0] a;
	output [31:0] out;

	assign out = {{16{a[15]}}, a};


endmodule
