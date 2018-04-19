from myhdl import block, always

# Program Counter
# Adds 4 to the current instruction address each clock cycle
# Changes the current instruction address to addr_in if given a branch signal
@block
def program_counter(clock, addr_out, addr_in, branch_signal):
    @always(clock.posedge)
    def program_counter():
      if (branch_signal):
        addr_out.next = addr_in
      else:
        addr_out.next = addr_out + 4

    return program_counter
