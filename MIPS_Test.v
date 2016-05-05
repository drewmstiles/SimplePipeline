
module MIPS_Test;

	// Inputs
	reg clock;
	
	// Instantiate the Unit Under Test (UUT)
	MIPS uut (
		.clock(clock)
	);

	initial begin
		// Initialize Inputs
		clock = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		repeat(10) begin
			#100;
			clock = 1;
			#100;
			clock = 0;
		end
	end
      
endmodule

