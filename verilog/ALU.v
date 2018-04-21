// 32-bit ALU
// data input width: 2 32-bit values
// data output width: 1 32-bit and one "zero" output
// ALUControl: 3-bits
// zero: output 1 if all bits of data output is 0
module alu  (input [31:0] A,B,
             input [2:0] ALUControl,
             input clk, reset,
             output reg [31:0] R,
			 output zero,
			 output overflow
			 );
		
		assign zero = (R==0); //Zero is true (i.e., 1) if output R is 0
		
        /* Decode the instruction */
        always @(posedge clk) begin
			if(reset == 1) begin
				R <= 32'b0;
			end

			else begin
				overflow <= 0;
				// ALUControl is equivalent to 3 bit ALU Op code
				// and can accomodate max 8 types of operations
				case (ALUControl)
					3'b000 /* ADD */: {overflow, R} <= A + B;
					3'b001 /* SUB */: {overflow, R} <= A - B;
					3'b010 /* XOR */: R <= A ^ B;
					default: R <= 0;
				endcase
			end
		end
endmodule 