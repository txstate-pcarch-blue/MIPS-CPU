from myhdl import *

@block
def Instruction_Memory(clk, address, out): #Addr and clk input, out is output
    

    @always(clk.posedge)
    def execute():
        out.next = execute.mem[address[9:2]] #return the address of the instruciton
    mem = []
    for i in range(0, 256):
        mem.append(Signal(intbv(0, 0, 2**32)))
    #execute.mem = [intbv(max = 2**32)] * 256
    return execute
