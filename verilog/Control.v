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
			
			// Jump return opcode 0x00
			'b 000010: begin
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