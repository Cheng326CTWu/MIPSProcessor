// This is the control unit

module controlUnit
(
	opCode,
	func,
	zero,
	regDst,
	regWrite,
	pcSrc,
	aluSrc,
	aluOp,
	memWriteEn,
	memToReg
);

	input [5:0] opCode, func;
	input zero;
	output reg regDst, regWrite, aluSrc, memWriteEn, memToReg;
	output reg [2:0] aluOp;
	output pcSrc;

	reg [5:0] muxControlBits;
	reg branch;

	always @(*)
	begin
		case (opCode)
			6'b000000:	// R-type
			begin
				muxControlBits <= 6'b110000;
				case (func)
				6'b100000: aluOp <= 3'b000;			// ADD
				6'b100001: aluOp <= 3'b000;			// ADDU
				6'b100010: aluOp <= 3'b001;			// SUB
				6'b100011: aluOp <= 3'b001;			// SUBU
				6'b100100: aluOp <= 3'b010;			// AND
				6'b100101: aluOp <= 3'b011;			// OR
				6'b100110: aluOp <= 3'b100;			// SLL 
				6'b100111: aluOp <= 3'b101;			// SRL
				6'b101000: aluOp <= 3'b110;			// SLT
				6'b101001: aluOp <= 3'b111;			// SLTU
				endcase
			end

			6'b100011:	// LW
			begin
				muxControlBits <= 6'b011010;
				aluOp <= 3'b000;
			end

			6'b101011:	// SW
			begin
				muxControlBits <= 6'b001100;
				aluOp <= 3'b000;
			end

			6'b000100:	// BEQ
			begin
				muxControlBits <= 6'b000001;
				aluOp <= 3'b001;
			end

			6'b001000:	// ADDI
			begin
				muxControlBits <= 6'b011000;
				aluOp <= 3'b000;
			end

			6'b001001:	// ADDIU
			begin
				muxControlBits <= 6'b011000;
				aluOp <= 3'b000;
			end

			default:
			begin
				muxControlBits <= 6'bxxxxxx;		// NOP
			end
		endcase

		{regDst, regWrite, aluSrc, memWriteEn, memToReg, branch} = muxControlBits;
	end

	assign pcSrc = branch & zero;

endmodule

