import settings
from pathlib import Path
import sys
import output

def format(binary:list[str]):
    output_file = settings.INPUT_FILE.split(".")[0] 
    if (settings.DUAL_FILE_OUTPUT):
        create_file(binary[0], output_file)
        create_file(binary[1], output_file + "_data")
    else:
        create_file(binary[0], output_file)
    
    output.passed(f"Created {settings.FORMAT_TYPE} file")
    

def create_file(binary:str, filename:str):
    if (settings.FORMAT_TYPE == '.coe'):
        create_coe(binary, filename)
    elif (settings.FORMAT_TYPE == '.bin'):
        create_bin(binary, filename)
    elif (settings.FORMAT_TYPE == '.csv'):
        create_csv(binary, filename)
    elif (settings.FORMAT_TYPE == '.txt'):
        create_txt(binary, filename)
    else:
        output.failed("Invalid Format Type")
        sys.exit(1)

def create_coe(binary:str, filename:str):
    output.debug("Creating .coe file")
    filename = filename + ".coe"
    with open(filename, "w") as file:
        file.write("memory_initialization_radix=2;\n")
        file.write("memory_initialization_vector=\n")
        initalization_vector = ""
        for (i, line) in enumerate(binary):
            for bit in line:
                initalization_vector += bit
                initalization_vector += ","
                if ((i+1) % 16 == 0):
                    initalization_vector += "\n"
                else:
                    initalization_vector += " "
                if (i != len(binary)-1):
                    initalization_vector = initalization_vector.removesuffix(",")
                    
        initalization_vector = initalization_vector.removesuffix("\n").removesuffix(",") + ";"
        file.write(initalization_vector)
        file.close()

def create_bin(binary:str, filename:str):
    output.debug("Creating .bin file")
    filename = filename + ".bin"
    temp_buffer = ""
    with open(filename, "wb") as file:
        binary_string = b''
        for bit in binary:
            temp_buffer += bit
            if (len(temp_buffer) == 8):
                binary_string += int(temp_buffer, 2).to_bytes(1, byteorder='big')
                temp_buffer = ""
        file.write(binary_string)
        file.close()

def create_csv(binary:str, filename:str):
    output.debug("Creating .csv file")
    filename = filename + ".csv"
    with open(filename, "wb") as file:
        line = ""
        for i in range(16):
            line += f"bit{i},"
        #line += "\n"
        file.write(line.removesuffix(",").encode())
        line = ""
        for i, bit in enumerate(binary):
            if (i % 16 == 0):
                file.write((line.removesuffix(",")+"\n").encode())
                line = ""
            line += bit + ","

def create_txt(binary:str, filename:str):
    output.debug("Creating .txt file")
    filename = filename + ".txt"
    with open(filename, "wb") as file:
        for bit in binary:
            file.write(bit.encode())
        file.close()