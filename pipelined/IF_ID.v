// This is the IF/ID pipeline register
module IF_ID_reg
(
    clk,
    rst,
    stall,
    pcPlus4_IF,
    instr_IF,
    pcPlus4_ID,
    instr_ID
);

    input clk, rst, stall;
    input [31:0] instr_IF, pcPlus4_IF;
    output reg [31:0] instr_ID, pcPlus4_ID;

    always @(posedge clk)
    begin
        if(rst)
        begin
            pcPlus4_ID <= 32'd0;
            instr_ID <= 32'd0;
        end
        else
        begin
            if(!stall)
            begin
                pcPlus4_ID <= pcPlus4_ID;
                instr_ID <= instr_ID;
            end
            else
            begin
                pcPlus4_ID <= pcPlus4_IF;
                instr_ID <= instr_IF;
            end
        end
    end

endmodule
