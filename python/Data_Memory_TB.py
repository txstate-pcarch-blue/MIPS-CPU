from myhdl import Signal, Simulation, intbv, traceSignals
from Data_Memory import Data_Memory
from helpers.Clock_Generator import clock_generator
from helpers.Random_Signal import random_signal
from PC import program_counter

# Program Counter Testbench
# Runs the PC for max_cycles
# Gives the branch signal and a new address every 10 cycles
if (__name__ == "__main__"):
    MAX_CYCLES = 102800
    
    clk = Signal(0)
    address = Signal(intbv(0, 0, 2**32))
    write = Signal(1)
    readData = Signal(intbv(0, 0, 2**32))
    writeData = Signal(intbv(0, 0, 2**32))
    pc_driver = program_counter(clk, address, Signal(0), Signal(0))
    
    writeData_driver = random_signal(writeData, clk)
    dataMemory_driver = traceSignals(Data_Memory(clk, address, write, readData, writeData))
    clock_driver = clock_generator(clk)
  
    sim = Simulation(pc_driver, clock_driver, dataMemory_driver, writeData_driver)
    sim.run(MAX_CYCLES)
