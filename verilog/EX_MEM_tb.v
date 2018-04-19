`timescale 1ns / 1ns

module EX_MEM_tb();

	parameter tck = 10; ///< clock tick

	reg clk, rst;
	reg EX_Flush;
	reg RegWrite_in, MemtoReg_in;
	reg Branch_in, MemRead_in, MemWrite_in, Jump_in;
	reg [31:0] jump_addr_in, branch_addr_in;
	reg ALU_zero_in;
	reg [31:0] ALU_result_in, reg_read_data_2_in;
	reg [4:0] ID_EX_RegisterRd_in;
	
	wire RegWrite_out, MemtoReg_out;
	wire Branch_out, MemRead_out, MemWrite_out, Jump_out;
	wire [31:0] jump_addr_out, branch_addr_out;
	wire ALU_zero_out;
	wire [31:0] ALU_result_out, reg_read_data_2_out;
	wire [4:0] EX_MEM_RegisterRd_out;
	
	integer seed = 1;
	integer num_iter = 0 ;
	always #(tck/2) clk <= ~clk; // clocking device
	
	EX_MEM dut (
		clk, rst,
		EX_Flush,
		RegWrite_in, MemtoReg_in,
		Branch_in, MemRead_in, MemWrite_in, Jump_in,
		jump_addr_in, branch_addr_in,
		ALU_zero_in,
		ALU_result_in, reg_read_data_2_in,
		ID_EX_RegisterRd_in,
		
		RegWrite_out, MemtoReg_out,
		Branch_out, MemRead_out, MemWrite_out, Jump_out,
		jump_addr_out, branch_addr_out,
		ALU_zero_out,
		ALU_result_out, reg_read_data_2_out,
		EX_MEM_RegisterRd_out
	 );
	
	initial begin
		$dumpfile("ex_mem_ah.vcd");
		$dumpvars(-1, dut);
		$monitor("%b",  EX_Flush, RegWrite_in, MemtoReg_in, RegWrite_out, MemtoReg_out, Branch_in, MemRead_in, MemWrite_in, Jump_in, Branch_out, MemRead_out, MemWrite_out, Jump_out, jump_addr_in, branch_addr_in, jump_addr_out, branch_addr_out, ALU_zero_in, ALU_zero_out, ALU_result_in, reg_read_data_2_in, ALU_result_out, reg_read_data_2_out, ID_EX_RegisterRd_in, EX_MEM_RegisterRd_out, clk, rst);
	end
	
	
	initial begin
		clk = 0;
		rst = 0;
		EX_Flush = 0;
		RegWrite_in = 0;
		MemtoReg_in = 0;
		Branch_in = 0;
		MemRead_in  = 0;
		MemWrite_in  = 0;
		Jump_in = 0;
		jump_addr_in = 0;
		branch_addr_in = 0;
		ALU_zero_in = 0;
		ALU_result_in = 0;
		reg_read_data_2_in = 0;
		ID_EX_RegisterRd_in = 0;
	end
	
	
	always @(negedge clk) begin
		if (rst) 
			rst = 0;
		else
			clk = $random(seed);
			rst = $random(seed);
			EX_Flush = $random(seed);
			RegWrite_in = $random(seed);
			MemtoReg_in = $random(seed);
			Branch_in = $random(seed);
			MemRead_in = $random(seed);
			MemWrite_in = $random(seed);
			Jump_in = $random(seed);
			jump_addr_in = $random(seed);
			branch_addr_in = $random(seed);
			ALU_zero_in = $random(seed);
			ALU_result_in = $random(seed);
			reg_read_data_2_in = $random(seed);
			ID_EX_RegisterRd_in = $random(seed);

		++ num_iter ;
		
	end
			

	always @(negedge clk) begin
		if (num_iter > 2000)
			$finish;
	end

endmodule
	
	
	