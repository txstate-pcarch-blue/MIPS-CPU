from myhdl import *

@block
def Instruction_Memory(clk, Addr, Out): #Addr and clk input, out is output
    
    mem = [intbv(min = 32, max = 32)] * 256 #create 256 32-bit memory array

    @always(clk.posedge)
    def execute():
        Out.next = mem[address[9:2]] #return the address of the instruciton
        return Out.next

    return execute
