from myhdl import Signal, Simulation, intbv, traceSignals
from Instruction_Memory import Instruction_Memory
from Clock_Generator import clock_generator
from Random_Signal import random_signal
  
# Program Counter Testbench
# Runs the PC for max_cycles
# Gives the branch signal and a new address every 10 cycles
if (__name__ == "__main__"):
    MAX_CYCLES = 1000

    address = Signal(intbv(0, 0, 2**32))
    out  = Signal(intbv(0, 0, 2**32))
    clk = Signal(0)

    instruction_driver = traceSignals(Instruction_Memory(clk, address, out))
    clock_driver = clock_generator(clk)
    rand_driver  = random_signal(address, clk)
  
    sim = Simulation(clock_driver, rand_driver, instruction_driver)
    sim.run(MAX_CYCLES)
