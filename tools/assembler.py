#!/usr/bin/python3

registers = {"$Zero": 0, "$r0": 0, "$0": 0,
             "$at": 1, "$1": 1,
             "$v0": 2, "$2": 2,
             "$v1": 3, "$3": 3,
             "$a0": 4, "$4": 4,
             "$a1": 5, "$5": 5,
             "$a2": 6, "$6": 6,
             "$a3": 7, "$7": 7,
             "$t0": 8, "$8": 8,
             "$t1": 9, "$9": 9,
             "$t2": 10, "$10": 10,
             "$t3": 11, "$11": 11,
             "$t4": 12, "$12": 12,
             "$t5": 13, "$13": 13,
             "$t6": 14, "$14": 14,
             "$t7": 15, "$15": 15,
             "$s0": 16, "$16": 16,
             "$s1": 17, "$17": 17,
             "$s2": 18, "$18": 18,
             "$s3": 19, "$19": 19,
             "$s4": 20, "$20": 20,
             "$s5": 21, "$21": 21,
             "$s6": 22, "$22": 22,
             "$s7": 23, "$23": 23,
             "$t8": 24, "$24": 24,
             "$t9": 25, "$25": 25,
             "$k0": 26, "$26": 26,
             "$k1": 27, "$27": 27,
             "$gp": 28, "$28": 28,
             "$sp": 29, "$29": 29,
             "$fp": 30, "$30": 30,
             "$ra": 31, "$31": 31,
             }

def build_j(instr, labels, index):
    sp = instr.split()
    opcode = instructions[sp[0]][1]
    if (sp[1] in labels):
        location = labels[sp[1]]
    else:
        raise "Invalid Label"
    print("%#x Building j from %s. Op: %#x, Loc: %#x" % (index, instr, opcode, location))
    return (opcode << 26) | (location & 0x03FFFFFF)


def build_i(instr, labels, index):
    sp = instr.split()
    opcode = instructions[sp[0]][1]
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
    print("%#x Building i from %s. Op: %#x, rs: %#x, rt: %#x, imm: %#x" %\
        (index, instr, opcode, rs, rt, immediate))
    ret = opcode
    ret = (ret << 5) | rs
    ret = (ret << 5) | rt
    ret = (ret << 16) | (immediate & 0x0000FFFF)
    return ret


def build_r(instr, labels, index):
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
    funct = instructions[sp[0]][1]
    # Assemble Instruction
    print("%#x Building r from %s. Op: %#x, rs: %#x, rt: %#x, rd %#x, shamt: %#x, funct: %#x" %\
        (index, instr, opcode, rs, rt, rd, shamt, funct))
    ret = opcode
    ret = ret << 5 | rs
    ret = ret << 5 | rt
    ret = ret << 5 | rd
    ret = ret << 5 | shamt
    ret = ret << 6 | funct
    return ret


instructions = {
    "j": (build_j, 0x02),
    "jal": (build_j, 0x03),
    "lw": (build_i, 0x23),
    "sw": (build_i, 0x2b),
    "addi": (build_i, 0x08),
    "subi": (build_i, 0x09),
    "beq": (build_i, 0x04),
    "add": (build_r, 0x20),
    "sub": (build_r, 0x22),
    "xor": (build_r, 0x26),
    "jr": (build_r, 0x08)
}


def clean_input(inlines):
    lines = []
    for line in inlines:
        # Remove Comments
        line = line.split('#')[0]
        # Remove Commas
        line = line.replace(',', ' ')
        # Normalize spaces
        line = ' '.join(line.split())
        # Remove empty lines
        if len(line) != 0:
            lines.append(line)
    return lines


def parse_labels(inlines):
    labels_dict = dict()
    lines = []
    for i, line in enumerate(inlines):
        sp = line.split(':')
        if len(sp) == 1:
            lines.append(line)
            continue
        print("Label found at %#x, line: %s" % (i, sp))
        labels_dict[sp[0]] = i
        lines.append(sp[1])
    return lines, labels_dict


def assemble(inlines):
    lines = clean_input(inlines)
    lines, labels = parse_labels(lines)
    hexdata = []
    for i, line in enumerate(lines):
        # print(line)
        sp = line.split()
        instr = instructions[sp[0]][0](line, labels, i)
        # print(instr, hex(instr))
        hexdata.append(hex(instr) + '\n')
    return hexdata


def normalize_hex(inlines):
    lines = []
    for line in inlines:
        line = line[2:] # Remove 0x
        if len(line) < 9:
            line = '0'*(9 - len(line)) + line
        lines.append(line)
    return lines


if __name__ == "__main__":
    import argparse
    parser = argparse.ArgumentParser(description="MIPS Assembler for the blue team CPU")
    parser.add_argument('ifile')
    parser.add_argument('-o', '--output', default='a.hex', metavar='ofile')
    args = parser.parse_args()
    with open(args.ifile) as f:
        lines = f.readlines()
    hexdata = assemble(lines)
    normalized = normalize_hex(hexdata)
    with open(args.output, 'w') as f:
        f.writelines(normalized)
