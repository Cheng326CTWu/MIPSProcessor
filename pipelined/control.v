module control
(
    opCode,
    func,
    equalFlag,
    controlSignals_ID,
    pcSrc_IF
);

    input [5:0] opCode, func;
    input equalFlag;
    output reg [7:0] controlSignals_ID;
    output pcSrc_IF;

    reg [2:0] aluOp;
    reg [4:0] controlBits;
    reg branch;

	always @(*)
	begin
		case (opCode)
			6'b000000:	// R-type
			begin
				controlBits <= 5'b11000;
                branch <= 1'b0;
				case (func)
				6'b100000: aluOp <= 3'b000;			// ADD
				6'b100001: aluOp <= 3'b000;			// ADDU
				6'b100010: aluOp <= 3'b001;			// SUB
				6'b100011: aluOp <= 3'b001;			// SUBU
				6'b100100: aluOp <= 3'b010;			// AND
				6'b100101: aluOp <= 3'b011;			// OR
				6'b000000: aluOp <= 3'b100;			// SLL
				6'b000010: aluOp <= 3'b101;			// SRL
				6'b101010: aluOp <= 3'b110;			// SLT
				6'b101011: aluOp <= 3'b111;			// SLTU
				endcase
			end

			6'b100011:	// LW
			begin
				controlBits <= 5'b01101;
                branch <= 1'b0;
				aluOp <= 3'b000;
			end

			6'b101011:	// SW
			begin
				controlBits <= 5'b00110;
                branch <= 1'b0;
				aluOp <= 3'b000;
			end

			6'b000100:	// BEQ
			begin
				controlBits <= 5'b00000;
                branch <= 1'b1;
				aluOp <= 3'b001;
			end

			6'b001000:	// ADDI
			begin
				controlBits <= 5'b01100;
                branch <= 1'b0;
				aluOp <= 3'b000;
			end

			6'b001001:	// ADDIU
			begin
				controlBits <= 5'b01100;
                branch <= 1'b0;
				aluOp <= 3'b000;
			end

			default:
			begin
				controlBits <= 5'bxxxxx;
			end
		endcase

        controlSignals_ID = {controlBits, aluOp};
	end

	assign pcSrc_IF = branch & equalFlag;

endmodule
