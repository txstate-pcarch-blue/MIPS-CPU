from myhdl import *

@block
def ex_mem(clk, ALU_in, ALU_out, MemData_in, MemData_out, reg_in,
            reg_out, zero_in, zero_out, PC_in, PC_out, MemtoReg_in,
            MemtoReg_out, MemWrite_in, MemWrite_out, WB_in, WB_out):

    class latches:
        ALU = intbv(0, 0, 2**32)
        MemData = intbv(0, 0, 2**32)
        reg = intbv(0, 0, 2**5)
        zero = intbv(0, 0, 2**1)
        PC = intbv(0, 0, 2**32)
        MemtoReg = intbv(0, 0, 2**1)
        MemWrite = intbv(0, 0, 2**1)
        WB = intbv(0, 0, 2**1)



    @always(clk.posedge)
    def input():
        latches.ALU = ALU_in
        latches.MemData =
        latches.reg = reg_in
        latches.zero = zero_in
        latches.PC = PC_in
        latches.MemToReg = MemToReg_in
        latches.MemWrite = MemWrite_in
        latches.WB = WB_in

    @always(clk.negedge)
    def output():
        Alu_out.next = latches.ALU
        MemData_out.next = latches.MemData
        reg_in.next = latches.reg
        zero_out.next = latches.zero
        PC_out.next = latches.PC
        MemToReg_out.next = latches.MemToReg
        MemWrite_out.next = latches.MemWrite
        WB_out.next = latches.WB

    return input, output
