from myhdl import block, always

# Pulse Generator
#   Sends out a HIGH signal on sig every <delay> clock cycles
#   Resets sig to LOW all other times
@block
def pulse_generator(clock, sig, delay=10):
  @always(clock.posedge)
  def pulse():
    pulse.counter += 1
    if (pulse.counter % delay == 0):
      sig.next = 1
    else:
      sig.next = 0 
  pulse.counter = 0
  return pulse
