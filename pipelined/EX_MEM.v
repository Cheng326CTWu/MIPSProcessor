// This is the EX/MEM pipeline register
module EX_MEM_reg
(
    clk,
    rst,
    aluRes_EX,
    aluRes_MEM,
    writeData_EX,
    writeData_MEM,
    writeReg_EX,
    writeReg_MEM,
    memToReg_EX,
    memToReg_MEM,
    memWrite_EX,
    memWrite_MEM,
    regWrite_EX,
    regWrite_MEM,
);

    input clk, rst, memToReg_EX, memWrite_EX, regWrite_EX;
    input [4:0] writeReg_EX;
    input [31:0] writeData_EX, aluRes_EX;
    output reg [31:0] aluRes_MEM, writeData_MEM;
    output reg [4:0] writeReg_MEM;
    output reg memToReg_MEM, memWrite_MEM, regWrite_MEM;

    always @(posedge clk)
    begin
        if(rst)
        begin
            aluRes_MEM <= 32'd0;
            writeData_MEM <= 32'd0;
            writeReg_MEM <= 5'd0;
            memToReg_MEM <= 1'b0;
            memWrite_MEM <= 1'b0;
            regWrite_MEM <= 1'b0;
        end
        else
        begin
            aluRes_MEM <= aluRes_EX;
            writeData_MEM <= writeData_EX;
            writeReg_MEM <= writeReg_EX;
            memToReg_MEM <= memToReg_EX;
            memWrite_MEM <= memWrite_EX;
            regWrite_MEM <= regWrite_EX;
        end
    end

endmodule
