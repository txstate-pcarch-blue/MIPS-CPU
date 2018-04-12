// async control to generate ALU input signal
// input: 3-bit ALUOp control signal from Control Unit and 6-bit funct field from instruction
// output: 4-bit ALU control input
module ALUControl(ALUcontrol,ALUop,funct);
	input[2:0] ALUop;
	input[5:0] funct;
	output reg [1:0] ALUcontrol;
	
	//lw, sw require add
	//branch requires sub for comparison 
	//addi, subi require add and sub respectively
	always @(ALUop, funct) begin
		case(ALUop)
			3'b000: ALUcontrol = 0; //lw,sw
			3'b001: ALUcontrol = 1; //beq,bne
			3'b011: ALUcontrol = 0; //addi
			3'b100: ALUcontrol = 1; //subi
			
			3'b010:  begin
						case(funct)
							6'b10_0000: ALUcontrol = 0; //add
							6'b10_0010: ALUcontrol = 1; //sub
							6'b10_0110: ALUcontrol = 2; //xor
							6'b10_0101: ALUcontrol = 3; //or
						endcase
					end
		endcase
	end
 
endmodule