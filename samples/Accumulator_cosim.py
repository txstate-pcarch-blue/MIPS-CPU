import os
import sys
from myhdl import *

base_d = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
sys.path.append(os.path.join(base_d, "python/"))

from Accumulator import Accumulator
from helpers.Clock_Generator import clock_generator
from helpers.Random_Signal import random_signal
from helpers.Match_Test import match_test_assert as match_test


def accumulator_cosim(clock, din, dout):
  Accu_v = os.path.join(base_d, "samples/Accumulator.v")
  Accu_cosim_v = os.path.join(base_d, "samples/Accumulator_cosim.v")
  Accu_o = os.path.join(base_d, "bin/Accumulator.o")
  myhdl_vpi = os.path.join(base_d, "bin/myhdl.vpi")
  cmd = "iverilog -o %s %s %s" % (Accu_o, Accu_v, Accu_cosim_v)
  os.system(cmd)
  return Cosimulation("vvp -m %s %s" % (myhdl_vpi, Accu_o), clock=clock, din=din, dout=dout)


def run_hello_cosim():
  clock = Signal(0) 
  clock_driver = clock_generator(clock)
  din = Signal(intbv(val = 0, min = 0, max = 256))
  rand = random_signal(din, clock)
  doutver = Signal(intbv(val = 0, min = 0, max = 256))
  v_cosim = accumulator_cosim(clock, din, doutver)
  doutpy  = Signal(modbv(val = 0, min = 0, max = 256))
  py_cosim = Accumulator(clock, din, doutpy)
  match_t = match_test(clock, doutver, doutpy)
  sim = Simulation(clock_driver, rand, v_cosim, py_cosim, match_t)
  sim.run(1000)

run_hello_cosim()
