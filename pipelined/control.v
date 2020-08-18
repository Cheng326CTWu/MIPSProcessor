module control
(
    opCode,
    func,
    equalFlag,
    regDst_ID,
    regWrite_ID,
    aluSrc_ID,
    memWriteEn_ID,
    memToReg_ID,
    aluOp_ID,
    pcSrc_IF
);

    input [5:0] opCode, func;
    input equalFlag;
    output reg regDst_ID, regWrite_ID, aluSrc_ID, memWriteEn_ID, memToReg_ID;
    output reg [2:0] aluOp_ID;
    output pcSrc_IF;

    reg [5:0] controlBits;
    reg branch;

	always @(*)
	begin
		case (opCode)
			6'b000000:	// R-type
			begin
				controlBits <= 6'b110000;
				case (func)
				6'b100000: aluOp_ID <= 3'b000;			// ADD
				6'b100001: aluOp_ID <= 3'b000;			// ADDU
				6'b100010: aluOp_ID <= 3'b001;			// SUB
				6'b100011: aluOp_ID <= 3'b001;			// SUBU
				6'b100100: aluOp_ID <= 3'b010;			// AND
				6'b100101: aluOp_ID <= 3'b011;			// OR
				6'b000000: aluOp_ID <= 3'b100;			// SLL
				6'b000010: aluOp_ID <= 3'b101;			// SRL
				6'b101010: aluOp_ID <= 3'b110;			// SLT
				6'b101011: aluOp_ID <= 3'b111;			// SLTU
				endcase
			end

			6'b100011:	// LW
			begin
				controlBits <= 6'b011010;
				aluOp_ID <= 3'b000;
			end

			6'b101011:	// SW
			begin
				controlBits <= 6'b001100;
				aluOp_ID <= 3'b000;
			end

			6'b000100:	// BEQ
			begin
				controlBits <= 6'b000001;
				aluOp_ID <= 3'b001;
			end

			6'b001000:	// ADDI
			begin
				controlBits <= 6'b011000;
				aluOp_ID <= 3'b000;
			end

			6'b001001:	// ADDIU
			begin
				controlBits <= 6'b011000;
				aluOp_ID <= 3'b000;
			end

			default:
			begin
				controlBits <= 6'bxxxxxx;
			end
		endcase

		{regDst_ID, regWrite_ID, aluSrc_ID, memWriteEn_ID, memToReg_ID, branch} = controlBits;
	end

	assign pcSrc_IF = branch & equalFlag;

endmodule
