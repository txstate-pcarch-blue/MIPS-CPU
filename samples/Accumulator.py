from myhdl import  block, always, now

@block
def Accumulator(clk, din, dout):
  @always(clk.posedge)
  def accu():
    dout.next = dout + din
  
  return accu
