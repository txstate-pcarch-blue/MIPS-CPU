`timescale 1ns / 1ns

module MEM_WB_tb();

	parameter tck = 10; ///< clock tick

	reg RegWrite_in, MemtoReg_in;
	reg [31:0] D_MEM_read_data_in, D_MEM_read_addr_in;
	reg [4:0] EX_MEM_RegisterRd_in;
	reg clk, rst;

	wire [31:0] D_MEM_read_data_out, D_MEM_read_addr_out;
	wire [4:0] MEM_WB_RegisterRd_out;
	wire RegWrite_out, MemtoReg_out;
	
	integer seed = 1;
	integer num_iter = 0 ;
	always #(tck/2) clk <= ~clk; // clocking device
	
	MEM_WB dut (
		RegWrite_in, MemtoReg_in, D_MEM_read_data_in, D_MEM_read_addr_in, EX_MEM_RegisterRd_in, 		clk, rst,

		D_MEM_read_data_out, D_MEM_read_addr_out, 
		MEM_WB_RegisterRd_out,
		RegWrite_out, MemtoReg_out
	 );
	
	initial begin
		$dumpfile("ex_mem_ah.vcd");
		$dumpvars(-1, dut);
		$monitor("%b",  RegWrite_in, MemtoReg_in, D_MEM_read_data_in, D_MEM_read_addr_in, EX_MEM_RegisterRd_in, clk, rst, D_MEM_read_data_out, D_MEM_read_addr_out, MEM_WB_RegisterRd_out, RegWrite_out, MemtoReg_out);
	end
	
	
	initial begin
		RegWrite_in = 0;
		MemtoReg_in = 0;
		D_MEM_read_data_in = 0;
		D_MEM_read_addr_in = 0;
		EX_MEM_RegisterRd_in = 0;
		clk = 0;
		rst = 0;
	
	end
	
	
	always @(negedge clk) begin
		if (rst) 
			rst = 0;
		else
			RegWrite_in = $random(seed);
			MemtoReg_in = $random(seed);
			D_MEM_read_data_in = $random(seed);
			D_MEM_read_addr_in = $random(seed);
			EX_MEM_RegisterRd_in = $random(seed);
			clk = $random(seed);
			rst = $random(seed);
		++ num_iter ;
		
	end
			

	always @(negedge clk) begin
		if (num_iter > 2000)
			$finish;
	end

endmodule
	
	
	