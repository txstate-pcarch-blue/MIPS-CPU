`timescale 1ns / 1ns

module ID_EX_tb();

	parameter tck = 10; ///< clock tick
	

	reg ID_Hazard_lwstall, ID_Hazard_Branch;
	reg Branch_in, MemRead_in, MemWrite_in, Jump_in;
	reg RegWrite_in, MemtoReg_in;
	reg RegDst_in, ALUSrc_in;
	reg [1:0] ALUOp_in;
	reg [31:0] jump_addr_in, PC_plus4_in;
	reg [31:0] reg_read_data_1_in, reg_read_data_2_in, immi_sign_extended_in;
	reg [4:0] IF_ID_RegisterRs_in, IF_ID_RegisterRt_in, IF_ID_RegisterRd_in;
	reg [5:0] IF_ID_funct_in;
	reg clk, rst; 
	
	wire RegWrite_out, MemtoReg_out;
	wire Branch_out, MemRead_out, MemWrite_out, Jump_out;
	wire RegDst_out, ALUSrc_out;
	wire [1:0] ALUOp_out;
	wire [31:0] jump_addr_out, PC_plus4_out;
	wire [31:0] reg_read_data_1_out, reg_read_data_2_out, immi_sign_extended_out;
	wire [4:0] IF_ID_RegisterRs_out, IF_ID_RegisterRt_out, IF_ID_RegisterRd_out;
	wire [5:0] IF_ID_funct_out;
	
	integer seed = 1;
	integer num_iter = 0 ;
	always #(tck/2) clk <= ~clk; // clocking device
	
	ID_EX dut (
		ID_Hazard_lwstall, ID_Hazard_Branch, Branch_in, MemRead_in, MemWrite_in, Jump_in, 		RegWrite_in, MemtoReg_in, RegDst_in, ALUSrc_in, ALUOp_in, jump_addr_in, PC_plus4_in, 		reg_read_data_1_in, reg_read_data_2_in, immi_sign_extended_in, IF_ID_RegisterRs_in, IF_ID_RegisterRt_in, IF_ID_RegisterRd_in, IF_ID_funct_in, clk, rst, RegWrite_out, MemtoReg_out, Branch_out, MemRead_out, MemWrite_out, Jump_out, RegDst_out, ALUSrc_out, ALUOp_out, 		jump_addr_out, PC_plus4_out, reg_read_data_1_out, reg_read_data_2_out, immi_sign_extended_out, 	IF_ID_RegisterRs_out, IF_ID_RegisterRt_out, IF_ID_RegisterRd_out, IF_ID_funct_out);
	
	initial begin
		$dumpfile("id_ex_ah.vcd");
		$dumpvars(-1, dut);
		$monitor("%b", RegWrite_out, MemtoReg_out, Branch_out, MemRead_out, MemWrite_out, Jump_out, 		RegDst_out, ALUSrc_out, ALUOp_out, jump_addr_out, PC_plus4_out, reg_read_data_1_out,  reg_read_data_2_out, immi_sign_extended_out, IF_ID_RegisterRs_out, IF_ID_RegisterRt_out, IF_ID_RegisterRd_out);
	end
	
	
	initial begin
		ID_Hazard_lwstall = 0;
		ID_Hazard_Branch = 	0;
		Branch_in = 		0;
		MemRead_in = 		0;
		MemWrite_in = 		0;
		Jump_in = 			0;
		RegWrite_in = 		0;
		MemtoReg_in = 		0;
		RegDst_in = 		0;
		ALUSrc_in = 		0;
		ALUOp_in = 			0;
		jump_addr_in = 		0;
		PC_plus4_in = 		0;
		reg_read_data_1_in = 0;
		reg_read_data_2_in = 0;
		immi_sign_extended_in = 0;
		IF_ID_RegisterRs_in = 0;
		IF_ID_RegisterRt_in = 0;
		IF_ID_RegisterRd_in = 0;
		IF_ID_funct_in = 0;
		clk = 0;
		rst = 0;
		
		
		
	end
	
	
	always @(negedge clk) begin
		if (rst) 
			rst = 0;
		else
			ID_Hazard_lwstall = $random(seed);
			ID_Hazard_Branch = $random(seed);
			Branch_in = $random(seed);
			MemRead_in = $random(seed);
			MemWrite_in = $random(seed);
			Jump_in = $random(seed);
			RegWrite_in = $random(seed);
			MemtoReg_in = $random(seed);
			RegDst_in = $random(seed);
			ALUSrc_in = $random(seed);
			ALUOp_in = $random(seed);
			jump_addr_in = $random(seed);
			PC_plus4_in = $random(seed);
			reg_read_data_1_in = $random(seed);
			reg_read_data_2_in = $random(seed);
			immi_sign_extended_in = $random(seed);
			IF_ID_RegisterRs_in = $random(seed);
			IF_ID_RegisterRt_in = $random(seed);
			IF_ID_RegisterRd_in = $random(seed);
			IF_ID_funct_in = $random(seed);
		++ num_iter ;
		
	end
			

	always @(negedge clk) begin
		if (num_iter > 2000)
			$finish;
	end

endmodule
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	