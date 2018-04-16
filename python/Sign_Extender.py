from myhdl import *

@block
def Sign_Extender(clk, instruction, output):
    #Instruction should be a 16-bit intbv
    #output is accurate 32-bit intbv.
    output = intbv(max = 32)
    
    @alway(clk.posedge)
    def execute():
        #Insert 16 to 32-bit conversion loginc

        return

    return execute
