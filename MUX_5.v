module MUX_5(
    input [4:0] In0,
    input [4:0] In1,
    input Sel,
    output reg [4:0] Out
    );
	 
	 always@(In0, In1, Sel)
		 case (Sel)
			 0: Out <= In0;
			 1: Out <= In1;
		 endcase
endmodule