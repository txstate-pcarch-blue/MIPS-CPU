module Control(opcode, funct, ALUSrc, RegDst, MemWrite, MemRead, Beq, Bne, Jump,
               MemToReg, RegWrite, ALUControl);
	input [5:0] opcode, funct;
	output reg ALUSrc, RegDst, MemWrite, MemRead, Beq, Bne, Jump, MemToReg,
	RegWrite;
	output reg [2:0] ALUControl;

	always @(*) begin
	case (opcode)
		// R-type
		'b 000000: begin
		  ALUSrc <= 0;
		  RegDst <= 1;
		  MemWrite <= 0;
		  MemRead <= 0;
		  Beq <= 0;
		  Bne <= 0;
		  Jump <= 0;
		  MemToReg <= 0;
		  RegWrite <= 1;

		  case (funct)
			  // ADD
			  'b 100000: ALUControl <= 'b 010;
			  // SUB
			  'b 100010: ALUControl <= 'b 110;
			  // OR
			  'b 100101: ALUControl <= 'b 001;
			  // SLT
			  'b 101010: ALUControl <= 'b 111;
		  endcase
		end

		// lw opcode 0x23
		'b 100011: begin
		  ALUSrc <= 1;
		  RegDst <= 0;
		  MemWrite <= 0;
		  MemRead <= 1;
		  Beq <= 0;
		  Bne <= 0;
		  Jump <= 0;
		  MemToReg <= 1;
		  RegWrite <= 1;
		  // ADD
		  ALUControl <= 'b 010;
		end

		// sw opcode 0x2b
		'b 101011: begin
		  ALUSrc <= 1;
		  MemWrite <= 1;
		  MemRead <= 0;
		  Beq <= 0;
		  Bne <= 0;
		  Jump <= 0;
		  RegWrite <= 0;
		  // ADD
		  ALUControl <= 'b 010;
		end

		// beq opcode 0x04
		'b 000100: begin
		  ALUSrc <= 0;
		  MemWrite <= 0;
		  MemRead <= 0;
		  Beq <= 1;
		  Bne <= 0;
		  Jump <= 0;
		  RegWrite <= 0;
		  // SUB
		  ALUControl <= 'b 110;
		end

		// bne
		'b 000101: begin
		  ALUSrc <= 0;
		  MemWrite <= 0;
		  MemRead <= 0;
		  Beq <= 0;
		  Bne <= 1;
		  Jump <= 0;
		  RegWrite <= 0;
		  // SUB
		  ALUControl <= 'b 110;
		end

		// Jump
		'b 000010: begin
		  MemWrite <= 0;
		  MemRead <= 0;
		  Beq <= 0;
		  Bne <= 0;
		  Jump <= 1;
		  RegWrite <= 0;
		end

		// addi
		'b 001000: begin
		  ALUSrc <= 1;
		  RegDst <= 0;
		  MemWrite <= 0;
		  MemRead <= 0;
		  Beq <= 0;
		  Bne <= 0;
		  Jump <= 0;
		  MemToReg <= 0;
		  RegWrite <= 1;
		  // ADD
		  ALUControl <= 'b 010;
		end
	endcase
	end
endmodule