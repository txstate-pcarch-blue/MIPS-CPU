from myhdl import Signal, Simulation, intbv, traceSignals
from MUX import MUX
from Clock_Generator import clock_generator
from Random_Signal import random_signal
from Pulse_Generator import pulse_generator

if (__name__ == "__main__"):
    MAX_CYCLES = 1000

    clk = Signal(0)
    ctrl = Signal(0)
    inputA = Signal(intbv(0, 0, 2**32))
    inputB = Signal(intbv(0, 0, 2**32))
    output = Signal(intbv(0, 0, 2**32))

    clock_driver = clock_generator(clk)
    ctrl_driver = pulse_generator(clk, ctrl)
    inputA_driver = random_signal(inputA, clk)
    inputB_driver = random_signal(inputB, clk)

    MUX_driver = traceSignals(MUX(clk, ctrl, inputA, inputB, output))

    sim = Simulation(clock_driver, ctrl_driver, inputA_driver, inputB_driver, MUX_driver)
    sim.run(MAX_CYCLES)
