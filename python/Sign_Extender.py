from myhdl import *

@block
def Sign_Extender(clk, instruction, output, out):
    #Instruction should be a 16-bit intbv
    #output is accurate 32-bit intbv.
    output = intbv(min = 0, max = 2**32)
    
    @alway(clk.posedge)
    def execute():
        #Insert 16 to 32-bit conversion logic
        for out in output[16:31]:
            out.Next = instruction[15] #make the first new bits match the first bit
        return

    return execute
