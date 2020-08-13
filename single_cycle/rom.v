// Instruction memory
module rom
(
	pc,
	instruction
);

	parameter n = 32;
	parameter depth = 1024;

	input [n-1:0] pc;
	output reg [n-1:0] instruction;

	reg [n-1:0] instr_mem [depth-1:0];

	initial
	begin
		$readmemb("instr.txt", instr_mem);
	end

	always @(*)
	begin
		instruction <= instr_mem[pc/4];
	end

endmodule
