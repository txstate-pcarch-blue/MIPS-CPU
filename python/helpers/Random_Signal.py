from myhdl import Signal, block, always, intbv
import random

@block
def random_signal(sig, clock, seed=1):
  random.seed(seed)
  @always(clock.posedge)
  def rand_sig():
    sig.next = intbv(random.randint(sig.min, sig.max - 1), sig.min, sig.max)
  
  return rand_sig
