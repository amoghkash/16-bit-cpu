import settings
import output
import definitions
from definitions import operations
import sys

def link(code:tuple[list[str], list[str]], symboltable:dict[str, list]):
    analysis(code, symboltable)
    instructionBinary:list[str] = generate_link(code, symboltable)
    generateOutputInformation(code, instructionBinary)
    return instructionBinary

def analysis(code:tuple[list[str], list[str]], symboltable:dict[str, list]):
    for i, data in enumerate(code[0]):
        if (not checkData(data)):
            output.failed(f"Invalid data variable: {data[0]}")
            sys.exit(1)
    output.passed("Data section is valid")

    for i, instruction in enumerate(code[1]):
        if (not checkInstruction(instruction, symboltable)):
            output.failed(f"Invalid instruction: {instruction}")
            sys.exit(1)
    output.passed("Instruction section is valid")
    return

def generate_link(code:tuple[list[str], list[str]], symboltable:dict[str, list]) -> list[bytes]:
    data_offset = 0
    binary:list[bytes] = ["",""]
    if(not settings.DUAL_FILE_OUTPUT):
        num_instructions = len(code[1])
        output.debug(f"Number of Instructions: {num_instructions}")
        data_offset = num_instructions * 2
        output.debug(f"Data Offset: {data_offset}")

    for symbol in symboltable:
        if (symboltable[symbol][0] == "prim"):
            symboltable[symbol][1] += data_offset
    
    for instruction in code[1]:
        binary_inst:bytes = operations[instruction[0]][0]
        instruction_type = operations[instruction[0]][1]
        for arg in instruction[1:]:
            if (type(arg) == str):
                arg = symboltable[arg][1]
                binary_value = str('{0:012b}'.format(arg))
            else:
                binary_value = get_binary_value(arg)

            binary_inst = binary_inst.__add__(binary_value)

        if((len(instruction_type) == 3) and (instruction_type[2] == "Z")):
            binary_inst = binary_inst.__add__("0000")
        elif(instruction_type[0] == "Z"):
            binary_inst = binary_inst.__add__(12*"0")

        binary_inst = binary_inst.removeprefix("b")

        if (len(binary_inst) != 16):
            output.failed(f"Internal Generation Error: {instruction} -> {binary_inst}")
            sys.exit(1)
        
        output.debug(f"{instruction} -> {binary_inst}")
        binary[0] = binary[0] + binary_inst
    
    for data in code[0]:
        match data[1]:
            case "word":
                binary[1] = binary[1] + get_binary_value(data[2],16)
            case "array":
                for element in data[2:]:
                    binary[1] = binary[1] + get_binary_value(element, 16)
            case "alloc":
                    binary[1] = binary[1] + (16*data[2]*"0")

    if (not settings.DUAL_FILE_OUTPUT):
        binary[0] = binary[0] + binary[1]
        del binary[1]
    
    output.passed("Generated All Outputs")
    return binary        
    
def get_binary_value(num:int, bitsize=4):
    '''
    Returns the signed binary value of a '''
    if num < 0:
        num = bin(num).removeprefix("-0b")
        sign_extend = "1"
    else:
        num = bin(num).removeprefix("0b")
        sign_extend = "0"

    if (len(num) < bitsize):
        append = "0" * (bitsize-len(num))
        num = append + num
    
    if (sign_extend == "1"):
        for i, bitval in enumerate(num):
            if bitval == "0":
                num = num[:i] + "1" + num[i:]
            else:
                num = num[:i] + "0" + num[i:]
        num = num[:bitsize]
        num = int(num, 2) + 1
        num = bin(num).removeprefix("0b")

    return num

def checkData(data:list[str]) -> bool:
    datatype = data[1]
    if (datatype == "word"):
        if (len(data) != 3):
            output.failed(f"Invalid number of arguments for word: {len(data)} provided")
            return False
        elif ((int(data[2]) > definitions.WORD_MAX_VALUE) or (int(data[2]) < definitions.WORD_MIN_VALUE)):
            output.failed(f"Word value out of range [-32768,32767]: {data[2]}")
            return False
        data[2] = int(data[2])
        return True
    
    elif (datatype == "array"):
        element_count = len(data) - 2
        for i in range(2, len(data)):
            if ((int(data[i]) > definitions.WORD_MAX_VALUE) or (int(data[i]) < definitions.WORD_MIN_VALUE)):
                output.failed(f"Array value out of range [-32768,32767]: {data[i]}")
                return False
            data[i] = int(data[i])
        return True
    
    elif (datatype == "alloc"):
        if (len(data) != 3):
            output.failed(f"Invalid number of arguments for alloc: {len(data)} provided")
            return False
        data[2] = int(data[2])
        return True
    else:
        output.failed(f"Invalid data type: {type}")

def checkInstruction(instruction:list[str], symboltable:dict[str, list]) -> bool:
    instruction[0] = instruction[0].lower()
    if (instruction[0] not in operations):
        output.failed(f"Invalid instruction: {instruction[0]}")
        return False
    
    instruction_type = []
    for i in range(1, len(instruction)):
        if ("r" in instruction[i]):
            instruction_type.append("R")
    
    if (instruction[0] == "addi"):
        instruction_type.append("I")
    elif (instruction[0] == "halt"):
        instruction_type = ["Z"]
    elif (len(instruction_type) == 2):
        instruction_type.append("Z")
    elif (len(instruction_type) == 0):
        instruction_type = ["L"]

    if (operations[instruction[0]][1] != instruction_type):
        output.failed(f"Invalid instruction type: {instruction[0]}")
        return False
    
    for (i, arg) in enumerate(instruction[1:]):
        current_type = instruction_type[i]
        if (current_type == "R"):
            register_num = arg.replace("r", "")
            if ((int(register_num) < 0) or (int(register_num) > definitions.MAX_REGISTER_VALUE)):
                output.failed(f"Invalid register number: {register_num}")
                return False
            instruction[i+1] = int(register_num)
        elif (current_type == "I"):
            base = 10
            if ("0x" in arg):
                base = 16
            if ((int(arg, base) > definitions.IMMEDIATE_MAX_VALUE) or (int(arg, base) < definitions.IMMEDIATE_MIN_VALUE)):
                output.failed(f"Invalid immediate value: {arg}")
                return False
            instruction[i+1] = int(arg, base)
        elif (current_type == "L"):
            base = 10
            if ("0x" in arg):
                base = 16
            try:
                value = int(arg, base)
                if (int(arg, base) > definitions.MAX_VAL_12_BIT):
                    output.failed(f"Invalid jump value: {arg}")
                    return False
                instruction[i+1] = int(arg, base)
            except ValueError:
                if (symboltable[arg.lower()] !=  None):
                    continue
                else:
                    output.failed(f"Invalid Jump Label: {arg}")
                    return False
    
    output.debug(f"Instruction {instruction[0]} is valid")
    return True

def generateOutputInformation(code:tuple[list[str], list[str]], binary:list[str]):
    num_instructions = len(code[1])
    if(len(binary) == 2):
        data_size = len(binary[1])/8
        code_size = len(binary[0])/8
        total_size = data_size + code_size
    else:
        code_size = num_instructions * 2
        total_size = len(binary[0])/8
        data_size = total_size - code_size
    
    statistics = f"Number of Instructions: {num_instructions}\n"
    statistics = statistics + f"Total Size(bytes): {int(total_size)}\n"
    statistics = statistics + f"Code Size(bytes): {int(code_size)}\n"
    statistics = statistics + f"Data Size(bytes): {int(data_size)}"
    output.statistics(statistics)
