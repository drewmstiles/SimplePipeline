module DataMemory (
	input MemWrite,
	input MemRead,
	input clock,
	input [7:0]ALUout,
	input [31:0] Data2,
	output reg [31:0] ReadData
	);

	reg 	[7:0]	DM	[0:255]; 	//DM - Data Memory denoting say, Hard Drive. 

	// read    
	always @ (MemRead)
		begin
			if (MemRead == 1)
			assign ReadData = {DM[ALUout[7:0] + 0], DM[ALUout[7:0] + 1], DM[ALUout[7:0] + 2], DM[ALUout[7:0] + 3]} ;
		end

	// write
	always @ (posedge clock)
	begin
		if (MemWrite ==1)
		begin
			DM[ALUout [7:0] + 0] = Data2 [31:24];
			DM[ALUout [7:0] + 1] = Data2 [23:16];
			DM[ALUout [7:0] + 2] = Data2 [15:8];
			DM[ALUout [7:0] + 3] = Data2 [7:0];
		end
	end

	initial begin
		// first operand
		DM[0] = 8'h00;	
		DM[1] = 8'h00;
		DM[2] = 8'h00;
		DM[3] = 8'h02;
		// second operand
		DM[4] = 8'h00;
		DM[5] = 8'h00;
		DM[6] = 8'h00;
		DM[7] = 8'h03;
	end

endmodule
