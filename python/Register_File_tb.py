from helpers.Pulse_Generator import pulse_generator
from myhdl import Signal, Simulation, intbv, traceSignals, instances
from Register_File import RegisterFile
from helpers.Clock_Generator import clock_generator
from helpers.Random_Signal import random_signal

if (__name__ == "__main__"):
    MAX_CYCLES = 100000

    BusA = Signal(intbv(0, 0, 2**32)) #output
    BusB = Signal(intbv(0, 0, 2**32)) #output
    BusW = Signal(intbv(0, 0, 2**32)) #input

    RA = Signal(intbv(0, 0, 2**5)) #input
    RB = Signal(intbv(0, 0, 2**5)) #input
    RW = Signal(intbv(0, 0, 2**5)) #input
    RegWr = Signal(0) #input
    clk = Signal(0) #input
    rst = Signal(0) #input
    outregs = []
    for i in range(0, 32):
        outregs.append(Signal(intbv(0, 0, 2**32)))
        outregs[i].driven = not outregs[i].driven

    busWAddress_driver = random_signal(BusW, clk)
    readAAddress_driver = random_signal(RA, clk)
    readBAddress_driver = random_signal(RB, clk)
    readWAddress_driver = random_signal(RW, clk)
    RegWr_driver = pulse_generator(clk, RegWr, delay=2)
    reset_driver = pulse_generator(clk, rst, delay=40)
    register_driver = traceSignals(RegisterFile(BusA, BusB, BusW, RA, RB, RW, RegWr, clk, rst, outregs))
    clock_driver = clock_generator(clk)

    sim = Simulation(instances())
    sim.run(MAX_CYCLES)
