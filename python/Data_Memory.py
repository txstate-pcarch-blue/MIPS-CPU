from myhdl import *

@block
def Data_Memory(clk, address, write, readData, writeData):
    #modeled inputs and outputs to match model below

    
    #Use this link's datapath as an example (http://d2vlcm61l7u1fs.cloudfront.net/media%2F63b%2F63b8364b-1ba0-467c-87f2-60b74041b998%2FphpArhSpB.png)
    #Be sure to note that the control line will determine multiplexor
    #that will determine write register(Either writeReg or readA)

    @always(clk.posedge)
    def execute():
        #Insert Memory Read or Write
        #readData.next = execute.mem[address[9:2]] #return memory to be loaded into a register
        if write:
            execute.mem[address[9:2]] = writeData #write register data into memory
        readData.next = execute.mem[address[9:2]]
    mem = []
    for i in range(0, 256):
        mem.append(Signal(intbv(0, 0 ,2**32)))
    #execute.mem = [intbv(max = 2**32)] * 256 #create a mem array with 256 32-bit intbv elements
    return execute

