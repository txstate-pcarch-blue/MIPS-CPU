`timescale 1ns / 1ns

module Control_tb();

	reg [5:0] opcode, funct;
	wire ALUSrc, RegDst, MemWrite, MemRead, Beq, Bne, Jump, MemToReg, RegWrite;
	wire [2:0] ALUControl;

	Control Con (opcode, funct, ALUSrc, RegDst, MemWrite, MemRead, Beq, Bne, Jump, MemToReg, RegWrite, ALUControl);

	initial begin

		$monitor("  opcode:%b funct:%b A:%b R:%b MW:%b MR:%b Beq:%b Bne:%b J:%b MTR:%b RW:%b ALUC:%b", opcode, funct, ALUSrc, RegDst, 
						MemWrite, MemRead, Beq, Bne, Jump, MemToReg, RegWrite, ALUControl);
		 
		$display("Test ADD");
		opcode = 'b 000000;
		funct = 'b 100000;
		#1;
		 
		$display("Test SUB");
		opcode = 'b 000000;
		funct = 'b 100010;
		#1;

		$display("Test AND");
		opcode = 'b 000000;
		funct = 'b 100100;
		#1;
		   
		$display("Test OR");
		opcode = 'b 000000;
		funct = 'b 100101;
		#1;
		 
		$display("Test SLT");
		opcode = 'b 000000;
		funct = 'b 101010;
		#1;

		$display("Test lw)");
		opcode = 'b 100011;
		#1;
		 
		$display("Test  sw");
		 opcode = 'b 101011;
		#1;
		 
		$display("Test  Beq");
		opcode = 'b 000100;
		#1;
		 
		$display("Test  Bne");
		opcode = 'b 000101;
		#1;
		 
		$display("Test  Jump");
		opcode = 'b 000010;
		#1;

		$finish;

	end
	
endmodule