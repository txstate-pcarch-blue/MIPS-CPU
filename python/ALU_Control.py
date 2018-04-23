from myhdl import *

@block
def ALU_Control(ALUop, funct, ALUcontrol): 

	@always(ALUop, funct)
	def control():
		if (ALUop == 0):
			ALUcontrol = 0

		elif (ALUop == 1):
			ALUcontrol = 1

		elif (ALUop == 2):
			ALUcontrol = 0

		elif (ALUop == 3):
			ALUcontrol = 1

		elif (ALUop == 4):
			if (funct == 0):
				ALUcontrol = 0

			elif (funct == 2):
				ALUcontrol = 1

			elif (funct == 6):
				ALUcontrol = 2

return ALU_Control

def JR_Control(alu_op, funct, JRControl):

    if alu_op == 0 and funct == 0x8:
       JRControl = 1
   	else
       JRControl = 0

return JR_Control
