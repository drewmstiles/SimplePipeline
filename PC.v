module PC(
	input clock,
	output reg [31:0] PCout
    );
	
	always @(posedge clock)
		begin
			PCout = PCout + 4;
		end
		
	initial PCout = 0;
endmodule
