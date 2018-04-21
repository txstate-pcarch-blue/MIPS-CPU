#Use a list of signals to create a homogeneous bit-vector array.

# Logic:
# On HIGH Clock:
#     If the Write Signal is HIGH, Reg[WriteSignal] = Write Data
# Always output the following:
#     Read Data 1 = Registers[Read Addr 1]
#     Read Data 2 = Registers[Read Addr 2]
# R0 = 0
# SP starts at 0xFFFFFFFC

from myhdl import *

@block
def RegisterFile(BusA, BusB, BusW, RA, RB, RW, RegWr, clk, Rst):

    registers = [intbv(0,0,2**32)] * 32

    @always(clk.posedge)
    def executePos():

      if RegWr:
        registers[RW] = BusW

      elif (Rst):
        for i in range (0,32):
          registers[i] = intbv(0, 0, 2**32)

    @always(clk.negedge)
    def executeNeg():

      BusA = registers[RA]
      BusB = registers[RB]

return executePos, executeNeg
