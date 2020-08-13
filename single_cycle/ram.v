// Data Memory
module ram
(
	clk,
	address,
	writeEn,
	dataIn,
	dataOut
);

	parameter n = 32;
	parameter depth = 1024;

	input clk, writeEn;
	input [n-1:0] address, dataIn;
	output [n-1:0] dataOut;

	reg [n-1:0] data_mem [depth-1:0];

	always @(posedge clk)
	begin
		if(writeEn)
		begin
			data_mem[address] <= dataIn;
		end
	end

	assign dataOut = data_mem[address];

endmodule
