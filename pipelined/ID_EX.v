// This is the ID/EX pipeline register
module ID_EX_reg
(
    clk,
    rst,
    regFileDataOne_ID,
    regFileDataOne_EX,
    regFileDataTwo_ID,
    regFileDataTwo_EX,
    signExtImmed_ID,
    signExtImmed_EX,
    instr_ID,
    instr_EX,
    regWrite_ID,
    regWrite_EX,
    memToReg_ID,
    memToReg_EX,
    memWrite_ID,
    memWrite_EX,
    aluOp_ID,
    aluOp_EX,
    aluSrc_ID,
    aluSrc_EX,
    regDst_ID,
    regDst_EX
);

    input clk, rst, regWrite_ID, memToReg_ID, memWrite_ID, aluSrc_ID, regDst_ID;
    input [31:0] regFileDataOne_ID, regFileDataTwo_ID, signExtImmed_ID, instr_ID;
    input [2:0] aluOp_ID;
    output reg [31:0] regFileDataOne_EX, regFileDataTwo_EX, signExtImmed_EX, instr_EX;
    output reg regWrite_EX, memToReg_EX, memWrite_EX, aluSrc_EX, regDst_EX;
    output reg[2:0] aluOp_EX;

    always @(posedge clk)
    begin
        if(rst)
        begin
            regFileDataOne_EX <= 32'd0;
            regFileDataTwo_EX <= 32'd0;
            signExtImmed_EX <= 32'd0;
            instr_EX <= 32'd0;
            regWrite_EX <= 1'b0;
            memToReg_EX <= 1'b0;
            memWrite_EX <= 1'b0;
            aluSrc_EX <= 1'b0;
            regDst_EX <= 1'b0;
            aluOp_EX <= 3'd0;
        end
        else
        begin
            regFileDataOne_EX <= regFileDataOne_ID;
            regFileDataTwo_EX <= regFileDataTwo_ID;
            signExtImmed_EX <= signExtImmed_ID;
            instr_EX <= instr_ID;
            regWrite_EX <= regWrite_ID;
            memToReg_EX <= memToReg_ID;
            memWrite_EX <= memWrite_ID;
            aluSrc_EX <= aluSrc_ID;
            regDst_EX <= regDst_ID;
            aluOp_EX <= aluOp_ID;
        end
    end

endmodule
