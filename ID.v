
module ID(
    input [5:0] IMout,
    output reg [8:0] IDout
    );

	reg rform;
	reg lw;
	reg sw;
	
	reg RegDst;
	reg AluSrc;
	reg MemToReg;
	reg RegWrite;
	reg MemRead;
	reg MemWrite;
	reg Branch;
	reg AluOp1;
	reg AluOp0;
	
	always @(IMout) begin
		// decode instruction
		assign rform = ~IMout[5] & ~IMout[4] & ~IMout[3] & ~IMout[2] & ~IMout[1] & ~IMout[0];
		assign lw = IMout[5] & ~IMout[4] & ~IMout[3] & ~IMout[2] & IMout[1] & IMout[0];
		assign sw = IMout[5] & ~IMout[4] & IMout[3] & ~IMout[2] & IMout[1] & IMout[0];
		
		// assign outputs
		assign RegDst = rform;
		assign AluSrc = lw | sw;
		assign MemToReg = lw;
		assign RegWrite = rform | lw;
		assign MemRead = lw;
		assign MemWrite = sw;
		assign Branch = 0; // branch driven
		assign AluOp1 = rform;
		assign AluOp0 = 0; // branch driven 

		assign IDout = {RegDst, AluSrc, MemToReg, RegWrite, 
			MemRead, MemWrite, Branch, AluOp1, AluOp0 };
	end

endmodule
