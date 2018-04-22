from myhdl import *
from ALU import alu
from helpers.Clock_Generator import clock_generator
from helpers.Random_Signal import random_signal

if (__name__ == "__main__"):
    clk = Signal(intbv(0, 0, 2**1))
    reset = Signal(intbv(0, 0, 2**1))
    readA = Signal(intbv(0, 0, 2**32))
    readB = Signal(intbv(0, 0, 2**32))
    CTRL = Signal(intbv(0, 0, 2**2))
    R = Signal(intbv(0, 0, 2**32))
    zero = Signal(intbv(0, 0, 2**1))
    ovf = Signal(intbv(0, 0, 2**1))

    clock_driver = clock_generator(clk)

    ALUDriver = traceSignals(alu(clk, reset, readA, readB, CTRL, R, zero, ovf))
    readADriver = random_signal(readA, clk)
    readBDriver = random_signal(readB, clk)
    CTRLDriver = random_signal(CTRL, clk)

    sim = Simulation(instances())
    sim.run(1000)
