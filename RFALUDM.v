module RFALUDM(
	input [1:0] ALUop,
	output Zero,
	input [4:0] rs,
	input [4:0] rt,
	input RegWrite,
	input clock,
	input RegDst,
	input ALUSrc,
	input MemtoReg,
	input MemWrite,
	input MemRead,
	input [15:0] SEin, // 16 least significant instruction bits: rd, shamt, func
	input [4:0] rd
	);
	 
	wire [31:0] b;
	wire [31:0] SEout;
	wire [31:0] ReadData;
	wire [31:0] Data1;
	wire [31:0] Data2;
	wire [31:0] ALUout;
	wire [3:0] ALUctl;
	wire [31:0] WriteData;
	wire [4:0] WriteReg;

	assign SEout = {{16{SEin[15]}}, SEin}; // zero extending

	// select between rt and rd for register file right address
	MUX_5 mux_5 (rt, rd, RegDst, WriteReg);  
	// access register file for write and read
	RegisterFile register_file (Data1, Data2, WriteData, rs, rt, WriteReg, RegWrite, clock);
	// select between data and sign extend (address calculation) for ALU input
	MUX_32 mux_32_1 (Data2, SEout, ALUSrc, b);
	// determine ALUctl from func and ALUop
	ALUControlLogic alu_control (SEin[5:0], ALUop, ALUctl);
	// operate on rs and mux select b
	ALU alu (ALUctl, Data1, b, ALUout, Zero);
	
	DataMemory dm (MemWrite, MemRead, clock, ALUout[7:0], Data2, ReadData);
	MUX_32 mux_32_2 (ALUout, ReadData, MemtoReg, WriteData); //32 bit MUX placed after DM to select data for RF

endmodule
