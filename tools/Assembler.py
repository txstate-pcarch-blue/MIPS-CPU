#!/usr/bin/python3

from Instructions import instructions
from Build_Functions import normalize_hex, get_parser


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
        try:
            parser = get_parser(sp[0])
            opcode = instructions[sp[0]]
            instr = parser(line, opcode, labels, i)
        except KeyError:
            print("Key Error", i + 1, line)
            quit(1)
        # print(instr, hex(instr))
        hexdata.append(hex(instr))
    return hexdata


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
