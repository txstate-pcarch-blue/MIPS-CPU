from myhdl import *
from ID_EX import id_ex
from helpers.Clock_Generator import clock_generator
from helpers.Random_Signal import random_signal

if (__name__ == "__main__"):
    MAX_CYCLES = 1000

    readA_out = Signal(intbv(0, 0, 2**32))
    readB_out = Signal(intbv(0, 0, 2**32))
    offset_out = Signal(intbv(0, 0, 2**32))
    PC_out = Signal(intbv(0, 0, 2**32))
    RTa_out = Signal(intbv(0, 0, 2**5))
    RTb_out = Signal(intbv(0, 0, 2**5))
    RS_out = Signal(intbv(0, 0, 2**5))
    RD_out = Signal(intbv(0, 0, 2**5))
    WB_out = Signal(intbv(0, 0, 2**1))
    MemToReg_out = Signal(intbv(0, 0, 2**1))
    MemWrite_out = Signal(intbv(0, 0, 2**1))
    MemRead_out = Signal(intbv(0, 0, 2**1))
    lwFlush_out = Signal(intbv(0, 0, 2**1))
    brFlush_out = Signal(intbv(0, 0, 2**1))
    funct_out = Signal(intbv(0, 0, 2**6))
    opCode_out = Signal(intbv(0, 0, 2**3))

    readA_in = Signal(intbv(0, 0, 2**32))
    readB_in = Signal(intbv(0, 0, 2**32))
    offset_in = Signal(intbv(0, 0, 2**32))
    PC_in = Signal(intbv(0, 0, 2**32))
    RTa_in = Signal(intbv(0, 0, 2**5))
    RTb_in = Signal(intbv(0, 0, 2**5))
    RS_in = Signal(intbv(0, 0, 2**5))
    RD_in = Signal(intbv(0, 0, 2**5))
    WB_in = Signal(intbv(0, 0, 2**1))
    MemToReg_in = Signal(intbv(0, 0, 2**1))
    MemWrite_in = Signal(intbv(0, 0, 2**1))
    MemRead_in = Signal(intbv(0, 0, 2**1))
    lwFlush_in = Signal(intbv(0, 0, 2**1))
    brFlush_in = Signal(intbv(0, 0, 2**1))
    funct_in = Signal(intbv(0, 0, 2**6))
    opCode_in = Signal(intbv(0, 0, 2**3))

    clock = Signal(0)

    reg_driver = traceSignals(id_ex(clock, readA_in, readB_in, offset_in, PC_in, RTa_in,
            RTb_in, RS_in, RD_in, WB_in, MemToReg_in, MemWrite_in,
            MemRead_in, lwFlush_in, brFlush_in, funct_in, opCode_in,
            readA_out, readB_out, offset_out, PC_out, RTa_out,
            RTb_out, RS_out, RD_out, WB_out, MemToReg_out, MemWrite_out,
            MemRead_out, lwFlush_out, brFlush_out, funct_out, opCode_out))
    clock_driver = clock_generator(clock)

    readA_driver = random_signal(readA_in, clock)
    readB_driver = random_signal(readB_in, clock)
    offset_driver = random_signal(offset_in, clock)
    PC_driver = random_signal(PC_in, clock)
    RTa_driver = random_signal(RTa_in, clock)
    RTb_driver = random_signal(RTb_in, clock)
    RS_driver = random_signal(RS_in, clock)
    RD_driver = random_signal(RD_in, clock)
    WB_driver = random_signal(WB_in, clock)
    MemToReg_driver = random_signal(MemToReg_in, clock)
    MemWrite_driver = random_signal(MemWrite_in, clock)
    MemRead_driver = random_signal(MemRead_in, clock)
    lwFlush_driver = random_signal(lwFlush_in, clock)
    brFlush_driver = random_signal(brFlush_in, clock)
    funct_driver = random_signal(funct_in, clock)
    opCode_driver = random_signal(opCode_in, clock)


    sim = Simulation(clock_driver, reg_driver, readA_driver, readB_driver,
                    offset_driver, PC_driver, RTa_driver, RTb_driver,
                    RS_driver, RD_driver, WB_driver, MemToReg_driver,
                    MemWrite_driver, MemRead_driver, lwFlush_driver,
                    brFlush_driver, funct_driver, opCode_driver)
    sim.run(MAX_CYCLES)
