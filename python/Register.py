#Use a list of signals to create a homogeneous bit-vector array.

# Logic:
# On HIGH Clock:
#     If the Write Signal is HIGH, Reg[WriteSignal] = Write Data
# Always output the following:
#     Read Data 1 = Registers[Read Addr 1]
#     Read Data 2 = Registers[Read Addr 2]
#
# SP starts at 0xFFFFFFFC

from myhdl import *

@block
def RegisterFile(BusA, BusB, BusW, RA, RB, RW, RegWr, clk, Rst):

    registers = []
    regSig = Signal(0, 5)
    period = 10

    #Generate Signals of intbv type for registers (Signal is used to track on gtkwave)
    for i in range(0, 32):
        registers.append(Signal(intbv(0, 0, 2**32)))
        registers[i].driven = not registers[i].driven

    #Create clocking iterator to switch every quarter full clock cycle (used to read and write on quarter of clock cycle)
    @instance
    def regSig_generator():
        highTime = int(period/2)
        lowTime = period - highTime

        while True:
          yield delay(highTime)
          regSig.next = 1
          yield delay(lowTime)
          regSig.next = 0

    #Every posedge of regSig (a.k.a. every quareter clock cycle), perform either read or write (notice write will happen before read)
    @always(regSig.posedge)
    def writeReg():
        nonlocal registers
        if(clk and RegWr):
            registers[RW.unsigned()].next = BusW
        elif(not clk):
            BusA.next = registers[int(RA)]
            BusB.next = registers[int(RB)]

    return regSig_generator, writeReg
