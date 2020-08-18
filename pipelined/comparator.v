module equalComparator
(
    data1,
    data2,
    equal
);

    parameter n = 32;

    input [n-1:0] data1, data2;
    output equal;

    assign equal = (data1 == data2) ? 1'b1 : 1'b0;

endmodule
