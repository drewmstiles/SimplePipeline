module RegisterFile(
		output reg [31:0] Data1,
		 output reg [31:0] Data2,
		 input [31:0] WriteData,
		 input [4:0] Read1,
		 input [4:0] Read2,
		 input [4:0] WriteReg,
		 input RegWrite,
		 input clock
	);

	reg [31:0] RF [31:0];
	
	always begin
	@(posedge clock) 
		if(RegWrite) RF[WriteReg] <= WriteData;
		assign Data1 = RF[Read1[4:0]];
		assign Data2 = RF[Read2[4:0]];
	end
endmodule

