from myhdl import *
from EX_MEM import ex_mem
from helpers.Clock_Generator import clock_generator
from helpers.Random_Signal import random_signal

if (__name__ == "__main__"):
    MAX_CYCLES = 1000

    clk = Signal(intbv(0, 0, 2**1))

    ALU_in = Signal(intbv(0, 0, 2**32))
    MemData_in = Signal(intbv(0, 0, 2**32))
    reg_in = Signal(intbv(0, 0, 2**5))
    zero_in = Signal(intbv(0, 0, 2**1))
    PC_in = Signal(intbv(0, 0, 2**32))
    MemToReg_in = Signal(intbv(0, 0, 2**1))
    MemWrite_in = Signal(intbv(0, 0, 2**1))
    WB_in = Signal(intbv(0, 0, 2**1))

    ALU_out = Signal(intbv(0, 0, 2**32))
    MemData_out = Signal(intbv(0, 0, 2**32))
    reg_out = Signal(intbv(0, 0, 2**5))
    zero_out = Signal(intbv(0, 0, 2**1))
    PC_out = Signal(intbv(0, 0, 2**32))
    MemToReg_out = Signal(intbv(0, 0, 2**1))
    MemWrite_out = Signal(intbv(0, 0, 2**1))
    WB_out = Signal(intbv(0, 0, 2**1))


    clock_driver = clock_generator(clk)

    register_driver = traceSignals(ex_mem(clk, ALU_in, ALU_out, MemData_in, MemData_out, reg_in,
                                    reg_out, zero_in, zero_out, PC_in, PC_out, MemToReg_in,
                                    MemToReg_out, MemWrite_in, MemWrite_out, WB_in, WB_out))
    ALU_driver = random_signal(ALU_in, clk)
    MemData_driver = random_signal(MemData_in, clk)
    reg_driver = random_signal(reg_in, clk)
    zero_driver = random_signal(zero_in, clk)
    PC_driver = random_signal(PC_in, clk)
    MemToReg_driver = random_signal(MemToReg_in, clk)
    MemWrite_driver = random_signal(MemWrite_in, clk)
    WB_driver = random_signal(WB_in, clk)


    sim = Simulation(clock_driver, register_driver, ALU_driver, MemData_driver,
                        reg_driver, zero_driver, PC_driver, MemToReg_driver, MemWrite_driver,
                        WB_driver)
    sim.run(MAX_CYCLES)
