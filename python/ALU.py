###########################################
#ALU control lines		Function
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
    	if (reset == 1):
            R.next = 0
        else:         
            if CTRL == 0:				                         # if CTRL is equal to 0, then
        		R.next = (A + B) 			                     # and

        	elif CTRL == 1:				                         # if CTRL is equal to 1, then
        		R.next = (A - B) 			                     # sub

        	elif CTRL == 2:				                         # if CTRL is equal to 2, then
        		R.next = (A ^ B) 			                     # Xor

            elif CTRL == 4:                                      # if CTRL is equal to 4, then
                R.next = (A & B)                                 # AND

            elif CTRL == 5:                                      # if CTRL is equal to 5, then
                R.next = ~A 

            elif CTRL == 6:                                      # if CTRL is equal to 6, then
                R.next = ~(A & B)                                # NAND

            elif CTRL == 7:                                      # if CTRL is equal to 7, then
                R.next = ~(A | B)                                # NOR

            elif CTRL == 3:
                    if (A == B):
                        branch = 1

                    else: R.next = 0
            else: R.next = 0

    return execute, zero_ex                                      # Return for ALU class ClassName(object):
