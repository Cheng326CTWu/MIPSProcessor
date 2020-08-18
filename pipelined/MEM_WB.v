// This is the MEM/WB pipeline register
module MEM_WB_reg
(
    clk,
    rst,
    readData_MEM,
    readData_WB,
    aluRes_MEM,
    aluRes_WB,
    writeReg_MEM,
    writeReg_WB,
    regWrite_MEM,
    regWrite_WB,
    memToReg_MEM,
    memToReg_WB,
);

    input clk, rst, regWrite_MEM, memToReg_MEM;
    input [31:0] readData_MEM, aluRes_MEM;
    input [4:0] writeReg_MEM;
    output reg [31:0] readData_WB, aluRes_WB;
    output reg [4:0] writeReg_WB;
    output reg regWrite_WB, memToReg_WB;

    always @(posedge clk)
    begin
        if(rst)
        begin
            readData_WB <= 32'd0;
            aluRes_WB <= 32'd0;
            writeReg_WB <= 5'd0;
            regWrite_WB <= 1'b0;
            memToReg_WB <= 1'b0;
        end
        else
        begin
            readData_WB <= readData_MEM;
            aluRes_WB <= aluRes_MEM;
            writeReg_WB <= writeReg_MEM;
            regWrite_WB <= regWrite_MEM;
            memToReg_WB <= memToReg_MEM;
        end
    end

endmodule
