###########################################
#ALU control lines		   Function
#0000					add
#0001					sub
#0010					xor
###########################################
# 32-bit ALU
# Input width: A and B, both 32-bit values
# Output width: R, 32-bit
# Control: 2-bits
# Zero: output 1 if R is 0
# reset:
# clk:

from myhdl import *

@block
def alu(clk, reset, A, B, CTRL, R, zero, ovf, branch): 			 # Note that input and outputs are type intbv type

    @always_comb                                                 # Combinational assignment for zero
    def zero_ex():
        zero.next = (R==0)

    @always(clk.posedge)
    def execute():
        output = intbv(0, -2**32, (2**32)-1)                     #output is an intbv that is 33 bits wide to hold any possible overflow
        if (reset == 1):
            R.next = 0
        else:
            if CTRL == 0:				                         # if CTRL is equal to 0, then
                output = intbv(A.signed() + B.signed())			                     # and
            elif CTRL == 1:				                         # if CTRL is equal to 1, then
                output = intbv(A.signed() - B.signed())			                     # sub
            elif CTRL == 2:				                         # if CTRL is equal to 2, then
                output = (A ^ B)			                     # Xor
            elif CTRL == 4:                                      # if CTRL is equal to 4, then
                output = A & B                                   # AND
            elif CTRL == 5:                                      # if CTRL is equal to 5, then
                output = ~A
            elif CTRL == 6:                                      # if CTRL is equal to 6, then
                output = ~(A & B)                                # NAND
            elif CTRL == 7:                                      # if CTRL is equal to 7, then
                output = ~(A | B)                                # NOR
            elif CTRL == 3:
                if (A == B):
                    branch.next = 1
                else:
                    output = intbv(0)
            else:
                output = intbv(0)

            if(output > (2**31)-1):                              #Check for overflow and set
                ovf.next = 1
            elif(output < -(2**31)):
                ovf.next = 1
            else:
                ovf.next = 0

            R.next = output[32:0]                                #Set the lower 32 bits of the 33 bit output

    return execute, zero_ex                                      # Return for ALU class ClassName(object):
