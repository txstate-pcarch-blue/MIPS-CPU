from myhdl import *

@block
def if_id(clk, inst_in, inst_out, PC_in, PC_out):

    class latches:
        inst = intbv(0, 0, 2**32)
        PC = intbv(0, 0, 2**32)

    @always(clk.posedge)
    def input():
        latches.inst = inst_in
        latches.PC = PC_in

    @always(clk.negedge)
    def output():
        inst_out.next = latches.inst
        PC_out.next = latches.PC

    return input, output
