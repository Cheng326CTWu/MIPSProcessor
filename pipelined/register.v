module register
(
	d,
	clk,
    en,
	rst,
	q
);
    parameter n = 32;

	input [n-1:0] d;
	input rst, clk, en;
	output reg [n-1:0] q;

	always @(posedge clk)
	begin
		if(rst)
			q <= 0;
		else if(!en)
            q <= q;
        else
			q <= d;
	end

endmodule
