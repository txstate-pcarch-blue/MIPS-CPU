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
			3'b000: ALUcontrol = 0; //lw,sw: add 
			3'b001: ALUcontrol = 1; //beq: subtract 
			3'b010: ALUcontrol = 0; //addi: add
			3'b011: ALUcontrol = 1; //subi: add
			
			3'b100:  begin
						case(funct)
							6'b10_0000: ALUcontrol <= 0; //add
							6'b10_0010: ALUcontrol <= 1; //sub
							6'b10_0110: ALUcontrol <= 2; //xor
						endcase
					end
		endcase
	end
endmodule

// Verilog code for JR control unit
module JR_Control( input[1:0] alu_op, 
       input [5:0] funct,
       output JRControl
    );
	
	assign JRControl = ({alu_op,funct}==6'b001000) ? 1'b1 : 1'b0;
endmodule