// Control Unit
// Only opcode as input, funct code is sent to ALU Control module as per design
// RegDst must be two bits because it is 1 if R format, 0 if lw, and 2 if jal,
// don't-care for anything else
// MemToReg must be two bits because it is 0 for R format, 1 for lw, 2 if jal, 
// don't-care for anything else
//
module Control(opcode, ALUSrc, RegDst, MemWrite, MemRead, Beq, Jump, MemToReg, RegWrite, ALUOp);
	input [5:0] opcode;
	output reg ALUSrc, MemWrite, MemRead, Beq, Jump, RegWrite;
	output reg [1:0] RegDst, MemToReg;
	output reg [2:0] ALUOp;

	always @(*) begin
		case (opcode)
			// R-type opcode 0x00
			'b 000000: begin
				ALUSrc = 0;  //from reg
				RegDst = 1;
				MemWrite = 0;
				MemRead = 0;
				Beq = 0;
				Jump = 0;
				MemToReg = 0;
				RegWrite = 1;
				ALUOp = 4;
			end

			// lw opcode 0x23
			'b 100011: begin
				ALUSrc = 1;  //sign ext. imm.
				RegDst = 0;
				MemWrite = 0;
				MemRead = 1;
				Beq = 0;
				Jump = 0;
				MemToReg = 1;
				RegWrite = 1;
				ALUOp = 0; 
			end

			// sw opcode 0x2b
			'b 101011: begin
				ALUSrc = 1;  //sign ext. imm.
				MemWrite = 1;
				MemRead = 0;
				Beq = 0;
				Jump = 0;
				RegWrite = 0;
				ALUOp = 0;
			end

			// beq opcode 0x04
			'b 000100: begin
			    ALUSrc = 1;  //sign ext. imm.
			    MemWrite = 0;
			    MemRead = 0;
			    Beq = 1;
			    Jump = 0;
			    RegWrite = 0;
			    ALUOp = 1; 
			end

			// Jump label opcode 0x02
			'b 000010: begin
				RegDst = 0;
				MemToReg = 0;
			    MemWrite = 0;
			    MemRead = 0;
			    Beq = 0;
			    Jump = 1;
			    RegWrite = 0;
			end
			
			// Jump and link opcode 0x03
			'b 000010: begin
				RegDst = 2;
				MemToReg = 2;
			    MemWrite = 0;
			    MemRead = 0;
			    Beq = 0;
			    Jump = 1;
			    RegWrite = 0;
			end

			// addi
			'b 001000: begin
			    ALUSrc = 1;  //sign ext. imm.
			    RegDst = 0;
			    MemWrite = 0;
			    MemRead = 0;
			    Beq = 0;
			    Jump = 0;
			    MemToReg = 0;
			    RegWrite = 1;
			    ALUOp = 2;
			end
			
			// subi
			'b 001000: begin
			    ALUSrc = 1;  //sign ext. imm.
			    RegDst = 0;
			    MemWrite = 0;
			    MemRead = 0;
			    Beq = 0;
			    Jump = 0;
			    MemToReg = 0;
			    RegWrite = 1;
			    ALUOp = 3;
			end
			
		endcase
		
	end
endmodule



// shift-left-2 for jump instruction
// input width: 26 bits
// output width: 28 bits
// fill the void with 0 after shifting
// we don't need to shift in this case, becasue the address of the instructions
// are addressed by words
module Shift_Left_2_Jump (shift_in, shift_out);
	input [25:0] shift_in;
	output [27:0] shift_out;
	assign shift_out[27:0]={shift_in[25:0],2'b00};
endmodule


// this module is not shown in textbook
// all connections acynchronous; no clock signal is provided.
// this module is designed to merge branch(if taken) and jump instruction
// getting an output of PCSrc and a destintion PC address
module jump_OR_branch (Jump, Branch_taken, branch_addr, jump_addr, PCSrc, addr_out);
	input Jump, Branch_taken; 
	input [31:0] branch_addr, jump_addr;
	output PCSrc;
	output [31:0] addr_out;
	reg [31:0] addr_out;
	reg PCSrc;
	// only one of Jump or Branch_taken can be true in MEM in one cycle
	// so if Jump is true, assign jump_addr to addr_out, and set PCSrc to 1
	// and if Branch is true, assign branch_addr to addr_out, and set PCSrc to 1
	// if none of the two are true, set PCSrc to 0. addr_out could be whatever.
	always @(Jump or Branch_taken or branch_addr or jump_addr)
	begin
		if(Branch_taken)
		begin addr_out<=branch_addr;PCSrc<=1; end
		else if (Jump)
		begin addr_out<=jump_addr;PCSrc<=1;end
		else 
		begin PCSrc<=0; addr_out<=32'b0; end
	end
	
endmodule


// 32-bit 3-to-1 MUX for forwarding
// data input width: 3 32-bit
// data output width: 1 32-bit
// control: 2-bit
module Mux_32bit_3to1 (in00, in01, in10, mux_out, control);
	input [31:0] in00, in01, in10;
	output [31:0] mux_out;
	input [1:0] control;
	reg [31:0] mux_out;
	always @(in00 or in01 or in10 or control)
	begin
		case(control)
		2'b00:mux_out<=in00;
		2'b01:mux_out<=in01;
		2'b10:mux_out<=in10;
		default: mux_out<=in00;
		endcase
	end 
endmodule

// this module flushes IF/ID, ID/EX and EX/MEM if branch OR jump is determined viable at MEM stage
//		we previously assumed branch NOT-taken, so 3 next instructions need to be flushed
//		we are pushig jump to MEM stage because there might be a jump instruction right below our branch_not_taken assumption
//		so we need to wait for branch result to come out before executing jump
//		and of course becuase of the wait, all jump need to flush the next 3 instrucitons
// all connecions are aynchronous; no clock signal is provided
module branch_and_jump_hazard_control (MEM_PCSrc, IF_Flush, ID_Flush_Branch, EX_Flush);
	input MEM_PCSrc; // the PCSrc generated in MEM stage will be 1 if branch is taken or a jump instruction is detected at MEM stage
	output IF_Flush, ID_Flush_Branch, EX_Flush;
	reg IF_Flush, ID_Flush_Branch, EX_Flush;
	always @(MEM_PCSrc)
	begin
		if(MEM_PCSrc)
		begin IF_Flush<=1; ID_Flush_Branch<=1; EX_Flush<=1; end
		else 
		begin IF_Flush<=0; ID_Flush_Branch<=0; EX_Flush<=0; end
	end
endmodule



// N-bit 2-to-1 Mux
// input: 2 N-bit input
// output: 1 N-bit output
// control: 1 bit
// possible value of N in single cycle: 5, 6, 32
module Mux_N_bit (in0, in1, mux_out, control);
	parameter N = 32;
	input [N-1:0] in0, in1;
	output [N-1:0] mux_out;
	input control;
	assign mux_out=control?in1:in0;
endmodule