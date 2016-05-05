module MUX_32(
    input [31:0] In0,
    input [31:0] In1,
    input Sel,
    output reg [31:0] Out
    );
	 
	 always@(In0, In1, Sel)
		 case (Sel)
			 0: Out <= In0;
			 1: Out <= In1;
		 endcase
endmodule