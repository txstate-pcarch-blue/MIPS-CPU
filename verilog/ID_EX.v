// ID/EX stage register
// 1. Hazard control signal (sync rising edge)
// if ID_Hazard_lwstall or ID_Hazard_Branch equals 1,
// then clear all WB, MEM and EX control signal to 0 on rising edge
// do not need to clear addr, data or reg content
//input ID_Flush_lwstall, ID_Flush_Branch;
// 2. WB control signal
//input RegWrite_in, MemtoReg_in;
//output RegWrite_out, MemtoReg_out;
// 3. MEM control signal
//input Branch_in, MemRead_in, MemWrite_in, Jump_in;
//output Branch_out, MemRead_out, MemWrite_out, Jump_out;
// 4. EX control signal
//input RegDst_in, ALUSrc_in;
//input [1:0] ALUOp_in;
//output RegDst_out, ALUSrc_out;
//output [1:0] ALUOp_out;
// 5. addr content
//input [31:0] jump_addr_in, PC_plus4_in;
//output [31:0] jump_addr_out, PC_plus4_out;
// 6. data content
//input [31:0] reg_read_data_1_in, reg_read_data_2_in, immi_sign_extended_in;
//output [31:0] reg_read_data_1_out, reg_read_data_2_out, immi_sign_extended_out;
// 7. reg content
//input [4:0] IF_ID_RegisterRs_in, IF_ID_RegisterRt_in, IF_ID_RegisterRd_in;
//output [4:0] IF_ID_RegisterRs_out, IF_ID_RegisterRt_out, IF_ID_RegisterRd_out;
//input [5:0] IF_ID_funct_in;
//output [5:0] IF_ID_funct_out;
// general signal
// rst: async; set all register content to 0
//
module ID_EX (
	input ID_Hazard_lwstall, ID_Hazard_Branch,
	input Branch_in, MemRead_in, MemWrite_in, Jump_in,
	input RegWrite_in, MemtoReg_in,
	input RegDst_in, ALUSrc_in,
	input [1:0] ALUOp_in,
	input [31:0] jump_addr_in, PC_plus4_in,
	input [31:0] reg_read_data_1_in, reg_read_data_2_in, immi_sign_extended_in,
	input [4:0] IF_ID_RegisterRs_in, IF_ID_RegisterRt_in, IF_ID_RegisterRd_in,
	input [5:0] IF_ID_funct_in,
	input clk, rst,
	
	output RegWrite_out, MemtoReg_out,
	output Branch_out, MemRead_out, MemWrite_out, Jump_out,
	output RegDst_out, ALUSrc_out,
	output [1:0] ALUOp_out,
	output [31:0] jump_addr_out, PC_plus4_out,
	output [31:0] reg_read_data_1_out, reg_read_data_2_out, immi_sign_extended_out,
	output [4:0] IF_ID_RegisterRs_out, IF_ID_RegisterRt_out, IF_ID_RegisterRd_out,
	output [5:0] IF_ID_funct_out
);

	reg RegWrite_out, MemtoReg_out;
	reg Branch_out, MemRead_out, MemWrite_out, Jump_out;
	reg RegDst_out, ALUSrc_out;
	reg [1:0] ALUOp_out;
	reg [31:0] jump_addr_out, PC_plus4_out;
	reg [31:0] reg_read_data_1_out, reg_read_data_2_out, immi_sign_extended_out;
	reg [4:0] IF_ID_RegisterRs_out, IF_ID_RegisterRt_out, IF_ID_RegisterRd_out;
	reg [5:0] IF_ID_funct_out;

	
	always @(posedge clk or posedge rst)
	begin
		if (rst == 1'b1) begin
			RegWrite_out = 1'b0;
			MemtoReg_out = 1'b0;
			Branch_out = 1'b0;
			MemRead_out = 1'b0;
			MemWrite_out = 1'b0;
			Jump_out = 1'b0;
			RegDst_out = 1'b0;
			ALUSrc_out = 1'b0;
			ALUOp_out = 2'b0;
			jump_addr_out = 32'b0;
			PC_plus4_out = 32'b0;
			reg_read_data_1_out = 32'b0;
			reg_read_data_2_out = 32'b0;
			immi_sign_extended_out = 32'b0;
			IF_ID_RegisterRs_out = 5'b0;
			IF_ID_RegisterRt_out = 5'b0;
			IF_ID_RegisterRd_out = 5'b0;
			IF_ID_funct_out = 6'b0;			
		end
		else if (ID_Hazard_lwstall == 1'b1) begin
			RegWrite_out = 1'b0;
			MemtoReg_out = 1'b0;
			Branch_out = 1'b0;
			MemRead_out = 1'b0;
			MemWrite_out = 1'b0;
			Jump_out = 1'b0;
			RegDst_out = 1'b0;
			ALUSrc_out = 1'b0;
			ALUOp_out = 2'b0;
		end
		else if (ID_Hazard_Branch == 1'b1) begin
			RegWrite_out = 1'b0;
			MemtoReg_out = 1'b0;
			Branch_out = 1'b0;
			MemRead_out = 1'b0;
			MemWrite_out = 1'b0;
			Jump_out = 1'b0;
			RegDst_out = 1'b0;
			ALUSrc_out = 1'b0;
			ALUOp_out = 2'b0;
		end
		else begin
			RegWrite_out = RegWrite_in;
			MemtoReg_out = MemtoReg_in;
			Branch_out = Branch_in;
			MemRead_out = MemRead_in;
			MemWrite_out = MemWrite_in;
			Jump_out = Jump_in;
			RegDst_out = RegDst_in;
			ALUSrc_out = ALUSrc_in;
			ALUOp_out = ALUOp_in;
			jump_addr_out = jump_addr_in;
			PC_plus4_out = PC_plus4_in;
			reg_read_data_1_out = reg_read_data_1_in;
			reg_read_data_2_out = reg_read_data_2_in;
			immi_sign_extended_out = immi_sign_extended_in;
			IF_ID_RegisterRs_out = IF_ID_RegisterRs_in;
			IF_ID_RegisterRt_out = IF_ID_RegisterRt_in;
			IF_ID_RegisterRd_out = IF_ID_RegisterRd_in;
			IF_ID_funct_out = IF_ID_funct_in;
		end	
		
	end	
	
endmodule