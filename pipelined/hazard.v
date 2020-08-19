// This is the stall logic
module hazard
(
    instr_ID,
    rt_EX,
    rs_ID,
    rt_ID,
    writeReg_MEM,
    writeReg_EX,
    memToReg_EX,
    memToReg_MEM,
    regWrite_EX,
    IF_ID_stall,
    ID_EX_stall
);

    input [31:0] instr_ID;
    input [4:0] rt_EX, rs_ID, rt_ID, writeReg_MEM, writeReg_EX;
    input memToReg_EX, memToReg_MEM, regWrite_EX;
    output reg IF_ID_stall, ID_EX_stall;

    reg lwStall, bStall;

    always @(*)
    begin
        lwStall = ((rs_ID == rt_EX) || (rt_ID == rt_EX)) && memToReg_EX;

        bStall = (instr_ID[31:26] == 6'b000100) & (regWrite_EX & (writeReg_EX == rs_ID | writeReg_EX == rt_ID) | memToReg_MEM & (writeReg_MEM == rs_ID | writeReg_MEM == rt_ID));

        IF_ID_stall = lwStall || bStall;
        ID_EX_stall = lwStall || bStall;
    end

endmodule
