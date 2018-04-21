from myhdl import *

@block
def Hazard_Detection_Unit(clk, RsD, RtD, Branch, RsE, RtE, WrtieRegE, MemtoRegE, TegWriteE, WriteRegM, MemtoRegM, RegWrtieM, WriteRegW, RegWrtie,W, syscallD, #inputs
                          StallF, StallD, FlushE, ForwardAE, ForwardBE) #outputs

    
