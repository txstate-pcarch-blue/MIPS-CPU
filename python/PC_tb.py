from myhdl import Signal, Simulation, intbv, traceSignals
from PC import program_counter
from helpers.Clock_Generator import clock_generator
from helpers.Random_Signal import random_signal
from helpers.Pulse_Generator import pulse_generator
  
# Program Counter Testbench
# Runs the PC for max_cycles
# Gives the branch signal and a new address every 10 cycles
if (__name__ == "__main__"):
  MAX_CYCLES = 1000

  addr_out = Signal(intbv(0, 0, 2**32))
  addr_in  = Signal(intbv(0, 0, 2**32))
  branch_signal = Signal(0)
  clock = Signal(0)

  pc_driver = traceSignals(program_counter(clock, addr_out, addr_in, branch_signal))
  clock_driver = clock_generator(clock)
  rand_driver  = random_signal(addr_in, clock)
  pulse_driver = pulse_generator(clock, branch_signal)
  
  sim = Simulation(clock_driver, rand_driver, pc_driver, pulse_driver)
  sim.run(MAX_CYCLES)
