from myhdl import *

@block
def Sign_Extender(clk, instruction, output):
    #Instruction should be a 16-bit intbv
    #output is accurate 32-bit intbv.
    output = intbv(max = 2**32)
    
    @always(clk.posedge)
    def execute():
        #Insert 16 to 32-bit conversion logic
        for out in output[31:16]:
            output.next = instruction[15] #make the first new bits match the first bit

    return execute
