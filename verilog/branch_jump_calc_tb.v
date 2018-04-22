module branch_jump_calc_tb();
	
	reg [31:0] In1_extended_imm;
	reg [31:0] In2_pc_plus_4;
	
	wire [31:0] BTA;
	
	integer seed = 1;
	integer num_iter = 0 ;
	
	branch_calculator dut (In1_extended_imm, In2_pc_plus_4, BTA);
	
	
	initial begin
		In1_extended_imm <= 31'h00000000;
		In2_pc_plus_4 <= 32'h00000000;

		#1;
		$display("Inputs: %h, %h output: %h", In1_extended_imm, In2_pc_plus_4, BTA);
		
		#1;
		//result after calculation should be 0x10000008
		//as the branch address
		In1_extended_imm <= 32'h00000001;
		In2_pc_plus_4 <= 32'h10000004;
		#1;
		$display("Inputs: %h, %h output: %h", In1_extended_imm, In2_pc_plus_4, BTA);
	end	
endmodule