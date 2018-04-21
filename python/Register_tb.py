from Pulse_Generator import pulse_generator
from myhdl import Signal, Simulation, intbv, traceSignals
from Register import RegisterFile
from Clock_Generator import clock_generator
from Random_Signal import random_signal

if (__name__ == "__main__"):
    MAX_CYCLES = 1000

    BusA = Signal(intbv(0, 0, 2**32)) #output
    BusB = Signal(intbv(0, 0, 2**32)) #output
    BusW = Signal(intbv(0, 0, 2**32)) #input

    RA = Signal(intbv(0, 0, 2**5)) #input
    RB = Signal(intbv(0, 0, 2**5)) #input
    RW = Signal(intbv(0, 0, 2**5)) #input
    RegWr = Signal(intbv(0)) #input
    clk = Signal(0) #input
    rst = Signal(0) #input

    busWAddress_driver = random_signal(BusW, clk)
    readAAddress_driver = random_signal(RA, clk)
    readBAddress_driver = random_signal(RB, clk)
    readWAddress_driver = random_signal(RW, clk)
    RegWr_driver = pulse_generator(clk, RegWr)
    register_driver = traceSignals(RegisterFile(BusA, BusB, BusW, RA, RB, RW, RegWr, clk, rst))
    clock_driver = clock_generator(clk)

    sim = Simulation(busWAddress_driver, readAAddress_driver, readBAddress_driver, readWAddress_driver, RegWr_driver, register_driver, clock_driver)
    sim.run(MAX_CYCLES)
