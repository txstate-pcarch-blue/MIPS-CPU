from myhdl import Signal, Simulation, intbv, traceSignals
from Sign_Extender import Sign_Extender
from helpers.Clock_Generator import clock_generator
from helpers.Random_Signal import random_signal
  
# Program Counter Testbench
# Runs the PC for max_cycles
# Gives the branch signal and a new address every 10 cycles
if (__name__ == "__main__"):
    MAX_CYCLES = 1000

    instruction = Signal(intbv(0, 0, 2**32))
    output  = Signal(intbv(0, 0, 2**32))
    clk = Signal(0)

    pc_driver = traceSignals(Sign_Extender(clk, instruction, output))
    clock_driver = clock_generator(clk)
    rand_driver  = random_signal(instruction, clk)
  
    sim = Simulation(clock_driver, rand_driver, pc_driver)
    sim.run(MAX_CYCLES)
