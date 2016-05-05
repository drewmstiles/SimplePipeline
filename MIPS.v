
module MIPS(
	input clock
	);
	 
	wire [31:0] IMout;
	wire [8:0] IDout;
	wire zero;

	PCIMID pcimid (
		clock, 
		IMout, 
		IDout
		);
	
	RFALUDM rfualudm (
		IDout[1:0], 
		zero, 
		IMout[25:21], 
		IMout[20:16], 
		IDout[5], 
		clock, 
		IDout[8], 
		IDout[7], 
		IDout[6], 
		IDout[3], 
		IDout[4], 
		IMout[15:0], 
		IMout[15:11]
		);
	
endmodule
