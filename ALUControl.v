module ALUControlLogic (FuncCode, ALUOp, ALUCtl);

	input [5:0] FuncCode;
	input [1:0] ALUOp;
	output reg [3:0] ALUCtl;
	
	always @ (ALUOp, FuncCode) begin
		case ({ALUOp, FuncCode[3:0]})
			32: ALUCtl<=2; // add
			34: ALUCtl<=6; // subtract
			36: ALUCtl<=0; // and
			37: ALUCtl<=1; // or
			39: ALUCtl<=12; // nor
			42: ALUCtl<=7; // slt
			default: ALUCtl<=15; // should not happen
		endcase
	end
endmodule