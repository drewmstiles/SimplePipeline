module ALU (ALUctl, A, B, ALUOut, Zero);
	input [3:0] ALUctl;
	input [31:0] A, B;
	output reg [31:0] ALUOut;
	output Zero;
	
	assign Zero = (ALUOut==0);
	always @(ALUctl, A, B) begin // reevaluate if these change
		case (ALUctl)
			0: ALUOut <= A & B;
			1: ALUOut <= A | B;
			2: ALUOut <= A + B;
			6: ALUOut <= A - B;
			7: ALUOut <= A < B ? 1 : 0;
			default: ALUOut <= B; // send address for load/store
		endcase
	end
endmodule
