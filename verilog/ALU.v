// 32-bit ALU
// data input width: 2 32-bit values
// data output width: 1 32-bit and one "zero" output
// control: 2-bits
// zero: output 1 if all bits of data output is 0
module alu  (input [31:0] A,B,
             input [2:0] CTRL,
             input clk, reset,
             output reg [31:0] R,
			 output zero,
			 output reg ovf, branch);
		
		assign zero = (R==0); //Zero is true if output r is 0
		
        /* Decode the instruction */

        always @(posedge clk) begin
			if(reset == 1) begin
				R <= 16'b0;
			end

			else begin
				ovf <= 0;
				branch <= 0;
				
				// CTRL is equivalent to 3 bit ALU Op code
				// and can accomodate max 8 types of operations
				case (CTRL)

					3'b000 /* ADD */: {ovf, R} <= A + B;
					3'b001 /* SUB */: {ovf, R} <= A - B;
					3'b100 /* OR  */: R <= A | B;
					3'b010 /* XOR */: R <= A ^ B;
					
					3'b011 /* Branch Conditional */: begin
						if (A == B) branch <= 1;
						else R <= 0;
						end


					//3'h2 /* XOR */:   R <= A ^ B;
					//3'h3 /* AND */:   R <= A & B;
					//3'h4 /* OR */:    R <= A | B;
					//3'h5 /* NOTA */:  R <= ~A;
					//3'h6 /* NAND */:  R <= ~(A & B);
					//3'h7 /* NOR */:   R <= ~(A | B);

					default: R <= 0;
				endcase
			end
		end
endmodule 