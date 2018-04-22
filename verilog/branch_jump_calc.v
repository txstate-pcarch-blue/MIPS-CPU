//Sign extend 16 bit offset 
//Shift by 2 / multiply by 4. PC is already word aligned, immediate value must be aligned 
//Add resulting 32 bit address to PC + 4 to obtain BTA
//Inputs: immediate (or offset) value already sign extended to 32bits
//Outputs: BTA (32bits)
module branch_calculator(In1_extended_imm, In2_pc_plus_4, BTA);
	
	input [31:0] In1_extended_imm;
	input [31:0] In2_pc_plus_4;
	
	output reg [31:0] BTA;
	
	always @(In1_extended_imm) begin
		BTA <= (In1_extended_imm << 2) + In2_pc_plus_4;
	end
endmodule
