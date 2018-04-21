from Registers import registers
from Instructions import *


# Builds a j-format instruction by parts
def build_j(opcode, location):
    return (opcode << 26) | (location & 0x03FFFFFF)


# Builds a i-format instruction by parts
def build_i(opcode, rs, rt, immediate):
    ret = (opcode << 5) | rs
    ret = (ret << 5) | rt
    ret = (ret << 16) | (immediate & 0x0000FFFF)
    return ret


# Builds a r-format instruction by parts
def build_r(opcode, rs, rt, rd, shamt, funct):
    ret = opcode << 5 | rs
    ret = ret << 5 | rt
    ret = ret << 5 | rd
    ret = ret << 5 | shamt
    ret = ret << 6 | funct
    return ret


# Parses J instructions
def parse_j(instr, opcode, labels, index):
    sp = instr.split()
    if (sp[1] in labels):
        location = labels[sp[1]]
    else:
        raise "Invalid Label"
    return build_j(opcode, location)


# Parses I instructions
def parse_i(instr, opcode, labels, index):
    sp = instr.split()
    if sp[0] == "beq":
        rt = registers[sp[2]]
        rs = registers[sp[1]]
        if (sp[3] in labels):
            immediate = labels[sp[3]] - index
        else:
            raise "Invalid Label"
    elif sp[0] in ["sw", "lw"]:
        rt = registers[sp[1]]
        sp2 = sp[2].replace(')', '').split('(')
        rs = registers[sp2[1]]
        immediate = int(sp2[0])
    else:
        rt = registers[sp[1]]
        rs = registers[sp[2]]
        try:
            immediate = int(sp[3])
        except:
            immediate = int(sp[3], 16)
    return build_i(opcode, rs, rt, immediate)


# Parses R instructions
def parse_r(instr, funct, labels, index):
    sp = instr.split()
    # Gather part values
    opcode = 0
    if sp[0] == "jr":
        rs = registers[sp[1]]
        rt = 0
        rd = 0
    else:
        rs = registers[sp[2]]
        rt = registers[sp[3]]
        rd = registers[sp[1]]
        # Verify no write to r0
        if rd == 0:
            raise "Write to $0"
    shamt = 0
    # Assemble Instruction
    return build_r(opcode, rs, rt, rd, shamt, funct)


# Ensures all hex values are 8 digits long with no leading 0x
def normalize_hex(inlines):
    lines = []
    for line in inlines:
        line = line[2:] # Remove 0x
        if line[-1] != '\n':
            line = line + '\n'
        if len(line) < 9:
            line = '0'*(9 - len(line)) + line
        lines.append(line)
    return lines


# Returns the correct parser for a given mnemonic
def get_parser(mnemonic):
    if mnemonic in j_instructions:
        return parse_j
    elif mnemonic in i_instructions:
        return parse_i
    elif mnemonic in r_instructions:
        return parse_r
    # else
    raise KeyError


# Returns the correct builder for a given mnemonic
def get_builder(mnemonic):
    if mnemonic in j_instructions:
        return build_j
    elif mnemonic in i_instructions:
        return build_i
    elif mnemonic in r_instructions:
        return build_r
    # else
    raise KeyError
