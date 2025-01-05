import settings
import output
import definitions
from definitions import operations
import sys

def link(code:tuple[list[str], list[str]], symboltable:dict[str, list]):
    analysis(code, symboltable)
    instructionBinary:list[bytes] = generate_link(code, symboltable)
    return instructionBinary

def analysis(code:tuple[list[str], list[str]], symboltable:dict[str, list]):
    for i, data in enumerate(code[0]):
        if (not checkData(data)):
            output.failed(f"Invalid data variable: {data[0]}")
            sys.exit(1)
    output.passed("Data section is valid")

    for i, instruction in enumerate(code[1]):
        if (not checkInstruction(instruction)):
            output.failed(f"Invalid instruction: {instruction}")
            sys.exit(1)
    output.passed("Instruction section is valid")
    return

def generate_link(code:tuple[list[str], list[str]], symboltable:dict[str, list]) -> list[bytes]:
    data_offset = 0
    binary:list[bytes] = []
    if(not settings.DUAL_FILE_OUTPUT):
        num_instructions = len(code[1])
        output.debug(f"Number of Instructions: {num_instructions}")
        data_offset = num_instructions * 2
        output.debug(f"Data Offset: {data_offset}")


def checkData(data:list[str]) -> bool:
    datatype = data[1]
    if (datatype == "word"):
        if (len(data) != 3):
            output.failed(f"Invalid number of arguments for word: {len(data)} provided")
            return False
        elif (int(data[2]) > definitions.WORD_MAX_VALUE):
            output.failed(f"Word value too large: {data[2]}")
            return False
        data[2] = int(data[2])
        return True
    
    elif (datatype == "array"):
        element_count = len(data) - 2
        for i in range(2, len(data)):
            if (int(data[i]) > definitions.WORD_MAX_VALUE):
                output.failed(f"Array value too large: {data[i]}")
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

def checkInstruction(instruction:list[str]) -> bool:
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
            if (int(arg, base) > definitions.MAX_VAL_12_BIT):
                output.failed(f"Invalid jump value: {arg}")
                return False
            instruction[i+1] = int(arg, base)
    
    output.debug(f"Instruction {instruction[0]} is valid")
    return True
        