// This ALU currently will support the following arithmetic operations
// add - 000, sub - 001, and - 010, or - 011, sll - 100, srl - 101, slt - 110, sltu - 111

module alu
(
	a,
	b,
	f,
	shift_amt,
	res,
	zero
);

	input [31:0] a, b;
	input [2:0] f;
	input [4:0] shift_amt;
	output reg [31:0] res;
	output zero;

	always @(*)
	begin
		case (f)
		3'b000: res = a + b;
		3'b001: res = a - b;
		3'b010: res = a & b;
		3'b011: res = a | b;
		3'b100: res = b << shift_amt;
		3'b101: res = b >> shift_amt;
		3'b110: res = ($signed(a) < $signed(b)) ? 1'b1 : 1'b0;
		3'b111: res = (a < b) ? 1'b1 : 1'b0;
		endcase
	end
	assign zero = (res == 32'd0) ? 1'b1 : 1'b0;

endmodule

