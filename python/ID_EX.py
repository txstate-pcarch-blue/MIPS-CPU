from myhdl import *

@block
def id_ex(clk, readA_in, readB_in, offset_in, PC_in, RTa_in,
        RTb_in, RS_in, RD_in, WB_in, MemToReg_in, MemWrite_in,
        MemRead_in, lwFlush_in, brFlush_in, funct_in, opCode_in,
        readA_out, readB_out, offset_out, PC_out, RTa_out,
        RTb_out, RS_out, RD_out, WB_out, MemToReg_out, MemWrite_out,
        MemRead_out, lwFlush_out, brFlush_out, funct_out, opCode_out):

    class latches:
        readA = intbv(0, 0, 2**32)
        readB = intbv(0, 0, 2**32)
        offset = intbv(0, 0, 2**32)
        PC = intbv(0, 0, 2**32)
        RTa = intbv(0, 0, 2**5)
        RTb = intbv(0, 0, 2**5)
        RS = intbv(0, 0, 2**5)
        RD = intbv(0, 0, 2**5)
        WB = intbv(0, 0, 2**1)
        MemToReg = intbv(0, 0, 2**1)
        MemWrite = intbv(0, 0, 2**1)
        MemRead = intbv(0, 0, 2**1)
        lwFlush = intbv(0, 0, 2**1)
        brFlush = intbv(0, 0, 2**1)
        funct = intbv(0, 0, 2**6)
        opCode = intbv(0, 0, 2**3)

    @always(clk.negedge)
    def output():
        readA_out.next = latches.readA
        readB_out.next = latches.readB
        offset_out.next = latches.offset
        PC_out.next = latches.PC
        RTa_out.next = latches.RTa
        RTb_out.next = latches.RTb
        RS_out.next = latches.RS
        RD_out.next = latches.RD
        WB_out.next = latches.WB
        MemToReg_out.next = latches.MemToReg
        MemWrite_out.next = latches.MemWrite
        MemRead_out.next = latches.MemRead
        lwFlush_out.next = latches.lwFlush
        brFlush_out.next = latches.brFlush
        funct_out.next = latches.funct
        opCode_out.next = latches.opCode

    @always(clk.posedge)
    def input():
        latches.readA = readA_in
        latches.readB = readB_in
        latches.offset = offset_in
        latches.PC = PC_in
        latches.RTa = RTa_in
        latches.RTb = RTb_in
        latches.RS = RS_in
        latches.RD = RD_in
        latches.WB = WB_in
        latches.MemToReg = MemToReg_in
        latches.MemWrite = MemWrite_in
        latches.MemRead = MemRead_in
        latches.lwFlush = lwFlush_in
        latches.brFlush = brFlush_in
        latches.funct = funct_in
        latches.opCode = opCode_in

    return input, output
