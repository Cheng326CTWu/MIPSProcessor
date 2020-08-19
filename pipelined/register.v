module register
(
	d,
	clk,
    stall,
	rst,
	q
);
    parameter n = 32;

	input [n-1:0] d;
	input rst, clk, stall;
	output reg [n-1:0] q;

	always @(posedge clk)
	begin
		if(rst)
			q <= 0;
		else if(!stall)
            q <= q;
        else
			q <= d;
	end

endmodule
