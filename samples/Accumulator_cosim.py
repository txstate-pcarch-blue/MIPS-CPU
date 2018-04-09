import os
import sys
from myhdl import *

sys.path.insert(0,'../python') # Add the python library files
from Clock import ClkDriver
from Random_Signal import random_signal
from Accumulator import Accumulator

cmd = "iverilog -o ../bin/Accumulator.o Accumulator.v Accumulator_cosim.v"

def accumulator_cosim(clock, din, dout):
  os.system(cmd)
  return Cosimulation("vvp -m ../bin/myhdl.vpi ../bin/Accumulator.o", clock=clock, din=din, dout=dout)

@block
def match_test(clock, dver, dpy):
  @always(clock.negedge)
  def match_t():
    if (dver != dpy):
      print("No Match: v %s, py %s" % (bin(dver), bin(dpy)))
    else:
      print("Match: v %s, py %s" % (bin(dver), bin(dpy)))
  return match_t

def run_hello_cosim():
  clock = Signal(0) 
  clock_driver = ClkDriver(clock)
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
