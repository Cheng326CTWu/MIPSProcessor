// This is the IF/ID pipeline register
module IF_ID_reg
(
    clk,
    rst,
    instrIn,
    IF_flush,
    instrOut
);

    input clk, rst;
    input [31:0] instrIn;
    output reg [31:0] instrOut;

    always @(posedge clk)
    begin
        if(rst)
        begin

        end
        else if ()
        begin

        end
    end

endmodule
