module PCIMID(
	input  clock,
	output [31:0] IMout,
	output [8:0] IDout
	);
	
	wire [31:0] PCout;
	
	PC pc (clock, PCout);  
	IM im (PCout, IMout);
	ID id (IMout[31:26], IDout);

endmodule

