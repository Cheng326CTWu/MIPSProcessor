module register_file32
(
	clk,
	rst,
	readRegister1,
	readRegister2,
	writeRegister,
	writeData,
	regWrite,
	readData1,
	readData2,
);

	input clk, rst, regWrite;
	input [4:0] readRegister1, readRegister2, writeRegister;
	input [31:0] writeData;
	output [31:0] readData1, readData2;

	// This creates 32 items that are each 32 bits wide 
	reg [31:0] register [31:0];

	integer i;

	always @(posedge clk)
	begin
		register[0] = 32'd0;
		if(rst)
			for(i = 0; i < 32; i = i + 1)
			begin
				register[i] <= 32'd0;
			end
		else if (regWrite)
		begin
			register[writeRegister] <= writeData;
		end
	end

	assign readData1 = register[readRegister1];
	assign readData2 = register[readRegister2];

endmodule
