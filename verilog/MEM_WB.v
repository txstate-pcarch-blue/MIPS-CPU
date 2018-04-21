// MEM/WB stage register
// update content & output updated content at rising edge
// 1. WB control signal
//input RegWrite_in, MemtoReg_in;
//output RegWrite_out, MemtoReg_out;
// 2. data content
//input [31:0] D_MEM_read_data_in, D_MEM_read_addr_in;
//output [31:0] D_MEM_read_data_out, D_MEM_read_addr_out;
//input [4:0] EX_MEM_RegisterRd_in;
//output [4:0] MEM_WB_RegisterRd_out;
// general signal
// rst: async; set all register content to 0
//input clk, rst;

module MEM_WB (
	input RegWrite_in, MemtoReg_in,
	input [31:0] D_MEM_read_data_in, D_MEM_read_addr_in,
	input [4:0] EX_MEM_RegisterRd_in,
	input clk, rst,

	output [31:0] D_MEM_read_data_out, D_MEM_read_addr_out,
	output [4:0] MEM_WB_RegisterRd_out,
	output RegWrite_out, MemtoReg_out
);
	
	reg RegWrite_out, MemtoReg_out;
	reg [31:0] D_MEM_read_data_out, D_MEM_read_addr_out;
	reg [4:0] MEM_WB_RegisterRd_out;
	
	always @(negedge clk)
	begin
		if (rst == 1'b1) begin
			RegWrite_out <= 1'b0;
			MemtoReg_out <= 1'b0;
			D_MEM_read_data_out <= 32'b0;
			D_MEM_read_addr_out <= 32'b0;
			MEM_WB_RegisterRd_out <= 5'b0;
		end
		else begin
			RegWrite_out <= RegWrite_in;
			MemtoReg_out <= MemtoReg_in;
			D_MEM_read_data_out <= D_MEM_read_data_in;
			D_MEM_read_addr_out <= D_MEM_read_addr_in;
			MEM_WB_RegisterRd_out <= EX_MEM_RegisterRd_in;
		end
	end
	
endmodule