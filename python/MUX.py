from myhdl import *

@block
def MUX(clk, ctrl, inputA, inputB, output):

    @always(clk.posedge)
    def execute():

        if ctrl:
            output.next = inputA
        else:
            output.next = inputB

    return execute
