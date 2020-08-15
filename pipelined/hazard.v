// This is the stall logic
module hazard
(
    IF_ID_rs,
    IF_ID_rt,
    ID_EX_memRead,
    ID_EX_rt,
    stall
);

    input [4:0] IF_ID_rs, IF_ID_rt, ID_EX_rt;
    input ID_EX_memRead;
    output reg [2:0] stall;

    always @(*)
    begin
        if((ID_EX_memRead == 1'b1) && ((ID_EX_rt == IF_ID_rs) || (ID_EX_rt == IF_ID_rt)))
            stall = 3'b000;
        else
            stall = 3'b111;
    end

endmodule
