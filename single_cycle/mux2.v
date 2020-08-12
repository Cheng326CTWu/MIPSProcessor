module mux2_1
(
	d0,
	d1,
	sel,
	out
);

	parameter n = 32;
	
	input [n-1:0] d0, d1;
	input sel;
	output [n-1:0] out;

	assign out = (sel) ? d1 : d0;

endmodule
