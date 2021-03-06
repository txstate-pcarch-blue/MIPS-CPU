# Type imports
from myhdl import intbv, Signal, always, block, instances

#Clock import
from helpers.Clock_Generator import clock_generator

# Module Imports
from PC import program_counter
from Instruction_Memory import Instruction_Memory
from Register_File import RegisterFile
from ALU import alu
from Data_Memory import Data_Memory
from Sign_Extender import Sign_Extender

# Control Imports
from Control import control
from ALU_Control import *
from branch_jump_calc import *
from Forwarding_Unit import ForwardingUnit
from Hazard_Detection_Unit import *
from Multiplexers import *
from isBranch import isBranch

# Pipeline Registers Imports
from IF_ID import if_id
from ID_EX import id_ex
from EX_MEM import ex_mem
from MEM_WB import mem_wb

# CPU Assignments
from CPU_Assigns import *
from helpers.Paths import IM_in_file

# CPU - five stage MIPS CPU with forwarding and hazard control
# This file drives the processor. Control wiring signals are handled here.
# Wires are associated with their respective stage
# Multiplexers drive control decision making
# Modules receive pre-determined inputs based on mux output
@block
def CPU(clock, reset, regOut):



    # Wires in the IF stage
    PC_out = Signal(intbv(0, 0, 2**32))
    PC_plus4 = Signal(intbv(4, 0, 2**32))
    instruction_out = Signal(intbv(0, 0, 2**32))
    PO_write = Signal(intbv(0, 0, 2**1))

    pcp4_driver = PC_Increment(clock, PC_out, PC_plus4)

    # Wires in the ID stage
    IF_ID_PC_plus4 = Signal(intbv(0, 0, 2**32))
    IF_ID_instruction = Signal(intbv(0, 0, 2**32))
    MEM_WB_RegisterRd = Signal(intbv(0, 0, 2**5))
    reg_read_data_1 = Signal(intbv(0, 0, 2**32))
    reg_read_data_2 = Signal(intbv(0, 0, 2**32))
    immi_sign_extended = Signal(intbv(0, 0, 2**32))

    # Jump within the ID stage
    BTA = Signal(intbv(0, 0, 2**32))
    Jump_Address = Signal(intbv(0, 0, 2**32))
    jump_base28 = Signal(intbv(0, 0, 2**28))

    # Control Signal generation within the ID stage
    Jump = Signal(intbv(0, 0, 2**1))
    Branch = Signal(intbv(0, 0, 2**1))
    MemRead = Signal(intbv(0, 0, 2**1))
    MemWrite = Signal(intbv(0, 0, 2**1))
    ALUSrc = Signal(intbv(0, 0, 2**1))
    RegWrite = Signal(intbv(0, 0, 2**1))
    RegDst = Signal(intbv(0, 0, 2**2))
    MemToReg = Signal(intbv(0, 0, 2**2))
    ALUOp = Signal(intbv(0, 0, 2**3))

    # ID Stage constants
    In3_jal_ra = Signal(intbv(31, 0, 2**5))

    # Mux output wires
    first_alu_mux_3_to_1_out = Signal(intbv(0, 0, 2**32))
    second_alu_mux_3_to_1_out = Signal(intbv(0, 0, 2**32))
    third_alu_mux_2_to_1_out = Signal(intbv(0, 0, 2**32))
    idEx_to_exMem_mux_2_to_1_out = Signal(intbv(0, 0, 2**5))
    writeback_source_mux_3_to_1_out = Signal(intbv(0, 0, 2**32))
    regDst_mux_2_to_1_out = Signal(intbv(0, 0, 2**5))
    first_PC4_or_branch_mux_2_to_1_out = Signal(intbv(0, 0, 2**32))
    second_jump_or_first_mux_2_to_1_out = Signal(intbv(0, 0, 2**32))
    third_jr_or_second_mux_2_to_1_out = Signal(intbv(0, 0, 2**32))
    h_RegWrite_out = Signal(intbv(0, 0, 2**1))
    h_MemWrite_out = Signal(intbv(0, 0, 2**1))

    # Wires for the LW hazard stall
    PCWrite = Signal(intbv(0, 0, 2**1))            # PC stop writing if PCWrite == 0
    IF_ID_Write = Signal(intbv(1, 0, 2**1))        # IF/ID reg stops writing if IF_ID_Write == 0
    ID_Flush_lwstall = Signal(intbv(0, 0, 2**1))

    # Wires for jump/branch control
    PCSrc = Signal(intbv(0, 0, 2**1))
    IF_Flush = Signal(intbv(0, 0, 2**1))
    ID_Flush_Branch = Signal(intbv(0, 0, 2**1))
    EX_Flush = Signal(intbv(0, 0, 2**1))


    # Wires in the EX stage
    ID_EX_Jump = Signal(intbv(0, 0, 2**1))
    ID_EX_Branch = Signal(intbv(0, 0, 2**1))
    ID_EX_MemRead = Signal(intbv(0, 0, 2**1))
    ID_EX_MemWrite = Signal(intbv(0, 0, 2**1))
    ID_EX_ALUSrc = Signal(intbv(0, 0, 2**1))
    ID_EX_RegWrite = Signal(intbv(0, 0, 2**1))
    ALU_zero = Signal(intbv(0, 0, 2**1))
    JRControl = Signal(intbv(0, 0, 2**1))
    ID_EX_jump_addr = Signal(intbv(0, 0, 2**32))
    ID_EX_branch_address = Signal(intbv(0, 0, 2**32))
    ID_EX_PC_plus4 = Signal(intbv(0, 0, 2**32))
    ID_EX_reg_read_data_1 = Signal(intbv(0, 0, 2**32))
    ID_EX_reg_read_data_2 = Signal(intbv(0, 0, 2**32))
    ID_EX_immi_sign_extended = Signal(intbv(0, 0, 2**32))
    muxA_out = Signal(intbv(0, 0, 2**32))
    muxB_out = Signal(intbv(0, 0, 2**32))
    after_ALUSrc = Signal(intbv(0, 0, 2**32))
    ALU_result = Signal(intbv(0, 0, 2**32))
    after_shift = Signal(intbv(0, 0, 2**32))
    ID_EX_RegDst = Signal(intbv(0, 0, 2**2))
    ID_EX_MemtoReg = Signal(intbv(0, 0, 2**2))
    out_to_ALU = Signal(intbv(0, 0, 2**2))
    ID_EX_ALUOp = Signal(intbv(0, 0, 2**3))
    ID_EX_RegisterRs = Signal(intbv(0, 0, 2**5))
    ID_EX_RegisterRt = Signal(intbv(0, 0, 2**5))
    ID_EX_RegisterRd = Signal(intbv(0, 0, 2**5))
    EX_RegisterRd = Signal(intbv(0, 0, 2**5))
    ID_EX_funct = Signal(intbv(0, 0, 2**6))

    # Wires in the MEM stage
    EX_MEM_PC_plus_4 = Signal(intbv(0, 0, 2**32))
    EX_MEM_RegisterRd = Signal(intbv(0, 0, 2**5))
    EX_MEM_Branch = Signal(intbv(0, 0, 2**1))
    EX_MEM_MemRead = Signal(intbv(0, 0, 2**1))
    EX_MEM_MemWrite = Signal(intbv(0, 0, 2**1))
    EX_MEM_Jump = Signal(intbv(0, 0, 2**1))
    Branch_taken = Signal(intbv(0, 0, 2**1))
    EX_MEM_ALU_zero = Signal(intbv(0, 0, 2**1))
    EX_MEM_MemtoReg = Signal(intbv(0, 0, 2**2))
    EX_MEM_RegWrite = Signal(intbv(0, 0, 2**1))
    EX_MEM_jump_addr = Signal(intbv(0, 0, 2**32))
    EX_MEM_branch_addr = Signal(intbv(0, 0, 2**32))
    EX_MEM_ALU_result = Signal(intbv(0, 0, 2**32))
    EX_MEM_reg_read_data_2 = Signal(intbv(0, 0, 2**32))
    D_MEM_data = Signal(intbv(0, 0, 2**32))

    # Wires in the WB Stage
    reg_write_data = Signal(intbv(0, 0, 2**32))
    MEM_WB_PC_plus_4 = Signal(intbv(0, 0, 2**32))
    MEM_WB_RegWrite = Signal(intbv(0, 0, 2**1))
    MEM_WB_MemtoReg = Signal(intbv(0, 0, 2**2))
    MEM_WB_RegDst = Signal(intbv(0, 0, 2**2))
    MEM_WB_D_MEM_read_data = Signal(intbv(0, 0, 2**32))
    MEM_WB_D_MEM_read_addr = Signal(intbv(0, 0, 2**32))

    # Wires for forwarding
    ForwardA = Signal(intbv(0, 0, 2**2))
    ForwardB = Signal(intbv(0, 0, 2**2))

    mem = []

    branch_or_jump_taken = Signal(intbv(0, 0, 2**1))
    PC_in = Signal(intbv(0, 0, 2**32))

    Unit27 = PC_input_2_to_1(PC_plus4, third_jr_or_second_mux_2_to_1_out, branch_or_jump_taken, PC_in)
    Unit0 = program_counter(clock, reset, PC_out, PC_in, PCWrite)
    Unit1 = Instruction_Memory(clock, PC_out, instruction_out, "instructions.txt", mem)


    #IF stage: PC, IM, IF_ID_Reg

    # TODO: infile #
    se_driver = Sign_Extender(IF_ID_instruction(17,0), immi_sign_extended)
    Unit3 = if_id(clock, reset, instruction_out, IF_ID_instruction, PC_plus4, IF_ID_PC_plus4, IF_Flush, IF_ID_Write)

    #ID Stage: Control, Registers, branch_jump_cal, sign_extend, regDst_mux_3_to_1,
    #ID_EX_reg, Hazard_Detection_Unit
    Unit4 = control(IF_ID_instruction(32, 26), ALUSrc, RegDst, MemWrite, MemRead, Branch, Jump, MemToReg, RegWrite, ALUOp)

    Unit5 = regDst_mux_2_to_1(MEM_WB_RegisterRd, In3_jal_ra, MEM_WB_RegDst, regDst_mux_2_to_1_out)

    Unit25 = hazard_unit(ID_EX_MemRead, ID_EX_RegisterRt, IF_ID_instruction(26,21), IF_ID_instruction(21,16), ID_Flush_lwstall, PCWrite, IF_ID_Write)

    Unit6 = hazard_stall_mux_2_to_1(RegWrite, MemWrite, ID_Flush_lwstall, h_RegWrite_out, h_MemWrite_out)

    Unit28 = writeback_source_mux_3_to_1(MEM_WB_D_MEM_read_addr, MEM_WB_D_MEM_read_data,  MEM_WB_PC_plus_4, MEM_WB_MemtoReg, writeback_source_mux_3_to_1_out)

    Unit7 = RegisterFile(reg_read_data_1, reg_read_data_2, writeback_source_mux_3_to_1_out, IF_ID_instruction(26, 21), IF_ID_instruction(21, 16), regDst_mux_2_to_1_out, MEM_WB_RegWrite, clock, reset, regOut)

    Unit8 = branch_calculator(immi_sign_extended, IF_ID_PC_plus4, BTA)

    Unit9 = jump_calculator(IF_ID_instruction, IF_ID_PC_plus4, Jump_Address)

    Unit24 = id_ex(clock, reset, ID_Flush_lwstall, ID_Flush_Branch, Branch, MemRead, MemWrite, Jump, RegWrite, ALUSrc, ALUOp, RegDst, MemToReg, Jump_Address, IF_ID_PC_plus4, BTA, reg_read_data_1, reg_read_data_2, immi_sign_extended,  IF_ID_instruction(26,21), IF_ID_instruction(21,16), IF_ID_instruction(16,11), IF_ID_instruction(6,0), ID_EX_RegWrite, ID_EX_Branch, ID_EX_MemRead, ID_EX_MemWrite, ID_EX_Jump, ID_EX_ALUSrc, ID_EX_ALUOp, ID_EX_RegDst, ID_EX_MemtoReg, ID_EX_jump_addr, ID_EX_branch_address, ID_EX_PC_plus4, ID_EX_reg_read_data_1, ID_EX_reg_read_data_2, ID_EX_immi_sign_extended, ID_EX_RegisterRs, ID_EX_RegisterRt, ID_EX_RegisterRd, ID_EX_funct)

    #EX Stage:
    Unit11 = alu_control(ID_EX_ALUOp, ID_EX_funct, out_to_ALU)

    Unit12 = JR_Control(ID_EX_ALUOp, ID_EX_funct, JRControl)
    #ID_EX_RegRs, ID_EX_RegRt, EX_MEM_RegRd, EX_MEM_RegWrite, MEM_WB_RegRd, MEM_WB_RegWrite, Mux_ForwardA, Mux_ForwardB
    Unit13 = ForwardingUnit(ID_EX_RegisterRs, ID_EX_RegisterRt, EX_MEM_RegisterRd, MEM_WB_RegisterRd, MEM_WB_RegWrite, EX_MEM_RegWrite, ForwardA, ForwardB)

    Unit14 = first_alu_mux_3_to_1(ID_EX_reg_read_data_1, EX_MEM_reg_read_data_2, MEM_WB_D_MEM_read_data, ForwardA, first_alu_mux_3_to_1_out)

    Unit15 = second_alu_mux_3_to_1(ID_EX_reg_read_data_2, EX_MEM_reg_read_data_2, MEM_WB_D_MEM_read_data, ForwardB, second_alu_mux_3_to_1_out)

    Unit16 = third_alu_mux_2_to_1(second_alu_mux_3_to_1_out, immi_sign_extended, ALUSrc, third_alu_mux_2_to_1_out)

    Unit10 = alu(clock, reset, first_alu_mux_3_to_1_out, third_alu_mux_2_to_1_out, out_to_ALU, ALU_result, ALU_zero)

    Unit17 = idEx_to_exMem_mux_2_to_1(ID_EX_RegisterRd, ID_EX_RegisterRt, ID_EX_RegDst, idEx_to_exMem_mux_2_to_1_out)

    Unit18 = ex_mem(clock, reset, EX_Flush, ID_EX_RegWrite, ID_EX_MemtoReg, ID_EX_Branch, ID_EX_MemRead, ID_EX_MemWrite, ID_EX_Jump, ID_EX_jump_addr, ID_EX_branch_address, ALU_zero, ALU_result, second_alu_mux_3_to_1_out, idEx_to_exMem_mux_2_to_1_out, ID_EX_PC_plus4, EX_MEM_RegWrite, EX_MEM_MemtoReg, EX_MEM_Branch, EX_MEM_MemRead, EX_MEM_MemWrite, EX_MEM_Jump, EX_MEM_jump_addr, EX_MEM_branch_addr, EX_MEM_ALU_zero, EX_MEM_ALU_result, EX_MEM_reg_read_data_2, EX_MEM_RegisterRd, EX_MEM_PC_plus_4)

    #Mem Stage:
    Unit19 = Data_Memory(clock, EX_MEM_ALU_result, EX_MEM_MemWrite, EX_MEM_MemRead, D_MEM_data, EX_MEM_reg_read_data_2)
    Unit26 = branch_or_jump_taken_flush(EX_MEM_Branch, EX_MEM_Jump, EX_MEM_ALU_zero, IF_Flush, ID_Flush_Branch, EX_Flush, branch_or_jump_taken)

    Unit20 = mem_wb(clock, reset, EX_MEM_RegWrite, EX_MEM_MemtoReg, D_MEM_data, EX_MEM_ALU_result, EX_MEM_RegisterRd, EX_MEM_PC_plus_4, MEM_WB_D_MEM_read_data, MEM_WB_D_MEM_read_addr, MEM_WB_RegisterRd, MEM_WB_RegWrite, MEM_WB_MemtoReg, MEM_WB_PC_plus_4)

    branch_taken = Signal(intbv(0, 0, 2**1))
    branch_checker = isBranch(ALU_zero, Branch, branch_taken)

    Unit21 = first_PC4_or_branch_mux_2_to_1(ID_EX_PC_plus4, BTA, branch_taken, first_PC4_or_branch_mux_2_to_1_out)

    Unit22 = second_jump_or_first_mux_2_to_1(first_PC4_or_branch_mux_2_to_1_out, Jump_Address, Jump, second_jump_or_first_mux_2_to_1_out)

    Unit23 = third_jr_or_second_mux_2_to_1(second_jump_or_first_mux_2_to_1_out, regOut[31], JRControl, third_jr_or_second_mux_2_to_1_out)

    return instances()
