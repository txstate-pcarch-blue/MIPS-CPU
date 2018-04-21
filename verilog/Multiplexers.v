//This file contains modules for all the necessary multiplexors
//While a general purpose multiplexor can be used, an an instance created as needed, 
//decision is to explicitly define each multiplexor to aid in readability, understanding, 
//and reduced risk of error
//Once one of the choice inputs presented to the multiplexor is selected
//based on the provided control line, it is sent out as an output


//1st ALU source rs: 
//Control is forwarding unit - Forward A
//if 0, selected input is 1st register file's output: rs 
//if 1, selected input is forwarded ex to ex
//if 2, selected input is forwarded mem to ex
module first_alu_mux_3_to_1(In1_RegRs, In2_fwdEx, In3_fwdMem, Ctrl_FwdA, out)
	input [31:0] In1_RegRs, In2_fwdEx, In3_fwdMem;
	input Ctrl_FwdA;
	output reg [31:0] out; // 32-bit output
	always @(In1_RegRs, In2_fwdEx, In3_fwdMem, Ctrl_FwdA) begin
		case (Ctrl_FwdA) 
			0: out <= In1_RegRs;
			1: out <= In2_fwdEx;
			2: out <= In3_fwdMem; 
		endcase
	end
endmodule

//2nd ALU source rt: 
//Control is from Forwarding Unit - Forward B
//if 0, selected input is 2nd register output rt 
//if 1, selected input is forwarded ex to ex
//if 2, selected input is forwarded mem to ex
module second_alu_mux_3_to_1(In1_RegRt, In2_fwdEx, In3_fwdMem, Ctrl_FwdB, out)
	input [31:0] In1_RegRt, In2_fwdEx, In3_fwdMem;
	input [1:0] Ctrl_FwdB;
	output reg [31:0] out; // 32-bit output
	always @(In1_RegRt, In2_fwdEx, In3_fwdMem, Ctrl_FwdB) begin
		case (Ctrl_FwdB) 
			0: out <= In1_RegRt;
			1: out <= In2_fwdEx;
			2: out <= In3_fwdMem;
		endcase
	end
endmodule

//3rd ALU for source: 2nd mux output feeds into this one
// Control is ALUSrc
// if 0, take input from 2nd mux (can be either 2nd register rt, forwarded value mem to ex, 
// or forwarded value ex to ex
// if 1, take input from 16bit immediate after it's sign extended
module third_alu_mux_2_to_1(In1_second_alu_mux, In2_immediate, Ctrl_ALUSrc, out)
	input [31:0] In1_second_alu_mux, In2_immediate;
	input Ctrl_ALUSrc;
	output reg [31:0] out; // 32-bit output
	always @(In1_second_alu_mux, In2_immediate, Ctrl_ALUSrc) begin
		case (Ctrl_ALUSrc) 
			0: out <= In1_second_alu_mux;
			1: out <= In2_immediate;
		endcase
	end
endmodule

//Mux to determine which value to send to ex/mem pipeline stage
//TBD ????
module idEx_to_exMem_mux_2_to_1(In1, In2, Selector, out)
	input [31:0] In1, In2;
	input Selector;
	output reg [31:0] out; // 32-bit output
	always @(In1, In2, Selector) begin
		case (Selector) 
			0: out <= In1;
			1: out <= In2;
		endcase
	end
endmodule


//mux to determine writeback source (32 bit value)
//Control is MemToReg
//if 0, R type and take ALU result
//if 1, lw and take mem stage output
//if 2, jal and take hardcoded PC+4 because we need to save in $ra for returning
module writeback_source_mux_3_to_1(In1_ALU_Result, In2_Mem_output, In3_PC_plus_4, Ctrl_MemToReg, out)
	input [31:0] In1_ALU_Result, In2_Mem_output, In3_PC_plus_4;
	input [1:0] Ctrl_MemToReg;
	output reg [31:0] out; // 32-bit output
	always @(In1_ALU_Result, In2_Mem_output, In3_PC_plus_4, Ctrl_MemToReg) begin
		case (Ctrl_MemToReg) 
			0: out <= In1_ALU_Result;
			1: out <= In2_Mem_output;
			2: out <= In3_PC_plus_4;
		endcase
	end
endmodule



// multiplexer reg_dst to determine write address
//assign reg_write_dest = (reg_dst==2'b10) ? 3'b111: ((reg_dst==2'b01) ? instr[6:4] :instr[9:7]);
// Control line is RegDst
// if 0, if some immediate type (e.g., lw) address comes from 2nd read register, bits 20:16
// if 1, R type, address comes from rd bits 15:11
// if 2, jal and address is hardcoded $31 for $ra slot
module regDst_mux_3_to_1(In1_imm_destination_rt, In2_rType_rd, In3_jal_ra, Ctrl_RegDst, out)
	input [31:0] In1_imm_destination_rt, In2_rType_rd, In3_jal_ra;
	input [1:0] Ctrl_RegDst;
	output reg [31:0] out; // 32-bit output
	always @(In1_imm_destination_rt, In2_rType_rd, In3_jal_ra, Ctrl_RegDst) begin
		case (Ctrl_RegDst) 
			0: out <= In1_imm_destination_rt;
			1: out <= In2_rType_rd;
			2: out <= In3_jal_ra;
		endcase
	end
endmodule


//Jump and branch: can't use the simple 1 mux with PCSrc strategy in the book
//Need 3 muxes, outlined below. If result of last two muxes is 0, then what
//gets passed to the PC is simply PC+4. 

// 1st mux: Jump or branch 2:1
// Control line comes from branch decision AND gate
// if control is 0, select PC+4
// if control is 1, select sign extended label added to PC for BTA
module first_jump_or_branch_mux_2_to_1(In1_PC_plus_4, In2_BTA, Ctrl_Branch_Gate, out)
	input [31:0] In1_PC_plus_4, In2_BTA;
	input [1:0] Ctrl_Branch_Gate;
	output reg [31:0] out; // 32-bit output
	always @(In1_PC_plus_4, In2_BTA, Ctrl_Branch_Gate) begin
		case (Ctrl_Branch_Gate) 
			0: out <= In1_PC_plus_4;
			1: out <= In2_BTA;
		endcase
	end
endmodule


// 2nd mux: jal
// 1st mux feeds it's output value into 2nd as one of the inputs. 
// 2nd input comes from jump_address_calculator. 
// Control line comes from Control Unit jump line. If 1, then it's a jump. Take 2nd input.
// If 0, it is the 1st input (can be either PC+4 or BTA depending on 1st mux result)
// If 1, calculated jump address (shift two, concat top 4 of PC)
module second_jump_or_branch_mux_2_to_1(In1_first_mux, In2_jump_addr_calc, Ctrl_Jump, out)
	input [31:0] In1_first_mux, In2_jump_addr_calc;
	input Ctrl_Jump;
	output reg [31:0] out; // 32-bit output
	always @(In1_first_mux, In2_jump_addr_calc, Ctrl_Jump) begin
		case (Ctrl_Jump) 
			0: out <= In1_first_mux;
			1: out <= In2_jump_addr_calc;
		endcase
	end
endmodule

//3rd mux: jr
//2nd mux sends its output as one of the inputs. 2nd input comes from 1st read data
//in register (rs) at all times. 
//Control line comes from the JRControl module in ALU Control
//If control is 0 we take 1st input as determined by 2nd mux
//If control is 1 we take register value which contains jr address
module third_jump_or_branch_mux_2_to_1(In1_second_mux, In2_reg_value_ra, JRCtrl, out)
	input [31:0] In1_second_mux, In2_reg_value_ra;
	input [1:0] JRCtrl;
	output reg [31:0] out; // 32-bit output
	always @(In1_second_mux, In2_reg_value_ra, JRCtrl) begin
		case (JRCtrl) 
			0: out <= In1_second_mux;
			1: out <= In2_reg_value_ra;
		endcase
	end
endmodule


//Hazard detection mux in ID stage
//2:1 mux that stalls if lw conflict detected
//Control line: Mux_Select_Stall (from Hazard Unit)
//Inputs: Control Unit signal, hardcoded zero 
//If Control is 0, output is whatever is sent by Control Unit
//If Control is 1, output is 0 and sent to ID/EX wb, m, and ex control lines
module hazard_stall_mux_2_to_1(In1_zero, In2_control_unit, Ctrl_Mux_Select_Stall, out)
	input [31:0] In1_zero, In2_control_unit;
	input [1:0] Ctrl_Mux_Select_Stall;
	output reg [31:0] out; // 32-bit output
	always @(In1_zero, In2_control_unit, Ctrl_Mux_Select_Stall) begin
		case (Ctrl_Mux_Select_Stall) 
			0: out <= In1_zero;
			1: out <= In2_control_unit; 
		endcase
	end
endmodule

