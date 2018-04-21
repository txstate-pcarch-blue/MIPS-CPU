from myhdl import *
from ALU import alu
from Clock_Generator import clock_generator
from Random_Signal import random_signal

if (__name__ == "__main__"):
    clk = Signal(intbv(0, 0, 2**1))
    reset = Signal(intbv(0, 0, 2**1))
    readA = Signal(intbv(0, 0, 2**32))
    readB = Signal(intbv(0, 0, 2**32))
    CTRL = Signal(intbv(0, 0, 2**3))
    R = Signal(intbv(0, 0, 2**32))
    zero = Signal(intbv(0, 0, 2**1))
    ovf = Signal(intbv(0, 0, 2**1))
    branch = Signal(intbv(0, 0, 2**1))

    clock_driver = clock_generator(clk)

    ALUDriver = traceSignals(alu(clk, reset, readA, readB, CTRL, R, zero, ovf, branch))
    readADriver = random_signal(readA, clk)
    readBDriver = random_signal(readB, clk)
    CTRLDriver = random_signal(CTRL, clk)

    sim = Simulation(clock_driver, ALUDriver, readADriver, readBDriver, CTRLDriver)
    sim.run(1000)
