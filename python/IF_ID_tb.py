from myhdl import *
from IF_ID import if_id
from helpers.Clock_Generator import clock_generator
from helpers.Random_Signal import random_signal

if (__name__ == "__main__"):
    MAX_CYCLES = 1000

    clk = Signal(0)
    inst_in = Signal(intbv(0, 0, 2**32))
    inst_out = Signal(intbv(0, 0, 2**32))
    PC_in = Signal(intbv(0, 0, 2**32))
    PC_out = Signal(intbv(0, 0, 2**32))

    clock_driver = clock_generator(clk)

    reg_driver = traceSignals(if_id(clk, inst_in, inst_out, PC_in, PC_out))
    inst_driver = random_signal(inst_in, clk)
    PC_driver = random_signal(PC_in, clk)

    sim = Simulation(clock_driver, reg_driver, inst_driver, PC_driver)
    sim.run(MAX_CYCLES)
