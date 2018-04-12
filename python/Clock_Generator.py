from myhdl import block, delay, instance

@block
def clock_generator(clock, period=20):
  lowTime = int(period / 2)
  highTime = period - lowTime
  
  @instance
  def clk():
    while True:
      yield delay(lowTime)
      clock.next = 1
      yield delay(highTime)
      clock.next = 0

  return clk
