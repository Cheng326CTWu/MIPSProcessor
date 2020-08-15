// Forwarding Unit
module forward
(
    EX_MEM_rd,
    MEM_WB_rd,
    ID_EX_rs,
    ID_EX_rt,
    EX_MEM_regWrite,
    MEM_WB_regWrite,
    forwardA,
    forwardB
);

    // Each register is 5 bits wide
    parameter n = 5;

    input [n-1:0] EX_MEM_rd, MEM_WB_rd, ID_EX_rs, ID_EX_rt;
    input EX_MEM_regWrite, MEM_WB_regWrite;

    // This outputs to a 3:1 mux so need 2 bits
    output reg [1:0] forwardA, forwardB;

    always @(*)
    begin
        if((EX_MEM_regWrite == 1'b1) && (EX_MEM_rd == ID_EX_rs) && (EX_MEM_rd != 5'd0))
        begin
            forwardA = 2'b10;
        end
        else if((MEM_WB_regWrite == 1'b1) && (MEM_WB_rd == ID_EX_rs) && (EX_MEM_rd != ID_EX_rs) && (MEM_WB_rd != 5'd0))
        begin
            forwardA = 2'b01;
        end

        if((EX_MEM_regWrite == 1'b1) && (EX_MEM_rd == ID_EX_rt) && (EX_MEM_rd != 5'd0))
        begin
            forwardB = 2'b10;
        end
        else if((MEM_WB_regWrite == 1'b1) && (MEM_WB_rd == ID_EX_rt) && (EX_MEM_rd != ID_EX_rt) && (MEM_WB_rd != 5'd0))
        begin
            forwardB = 2'b01;
        end
    end

endmodule
