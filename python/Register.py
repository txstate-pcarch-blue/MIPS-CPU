from myhdl import *

@block
def Register():

    @always(clk.posedge)
    def executePos():
        #Insert Write
        return

    @always(clk.negedge)
    def executeNeg():
        #Insert Read
        return

    return executePos, executeNeg
