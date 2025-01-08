import settings
import output
import sys

def generate() -> tuple[tuple[list[str], list[str]], dict[str, list]]:
    """
    Parses an input assembly file to generate a symbol table and separate data and text sections.
    The function reads an assembly file specified in the settings.INPUT_FILE, splits it into 
    data and text sections, and processes each section to generate a symbol table and a list 
    of instructions.
    
    Returns:
        tuple: A tuple containing:
            - A tuple of two lists:
                - The first list contains the parsed data section.
                - The second list contains the parsed text section.
            - A dictionary representing the symbol table, where keys are symbol names and values 
              are lists containing symbol attributes.
    """

    datasection = ""
    textsection = ""
    with open(settings.INPUT_FILE, "r") as file:
        contents:str = file.read().split(".text")
        datasection = contents[0].lstrip(".data").lstrip("\n").rstrip("\n")
        textsection = contents[1].rstrip("\n").lstrip("\n")
        output.debug(f"Data Section:\n{datasection}")
        output.debug(f"Text Section:\n{textsection}")
        file.close()
    
    symbolTable = {}

    datasection = datasection.split("\n")
    # Get all Data Values and Parse them
    for i, data in enumerate(datasection):
        data = data.split(" ")
        datasection[i] = list(filter(lambda x: x != '', data))
    currentOffset = 0
    # Add Data to Symbol Table
    for data in datasection:
        data[0] = data[0].replace(":","").lower()
        data[1] = data[1].replace(".","")
        
        if (data[1] == "word"):
            symbolTable[data[0]] = ['prim', currentOffset, 2, data[2]]
            currentOffset += 2
        elif (data[1] == "array"):
            numElements = len(data) - 2
            symbolTable[data[0]] = ['prim', currentOffset, 2*numElements, data[2:]]
            currentOffset += 2*numElements
        elif (data[1] == "alloc"):
            symbolTable[data[0]] = ['prim', currentOffset, int(data[2]), None]
            currentOffset += int(data[2])


    # Get all Instructions
    textsection = textsection.split("\n")
    for i, text in enumerate(textsection):
        if (i > settings.NUM_OF_ADDRESSES):
            output.failed("Too many instructions, unable to fit in specified size")
            sys.exit(1)

        # Remove Comments
        if ("#" in text):
            text = text.split("#")
            text = text[0]
        
        # Remove Tabs
        if ("\t" in text):
            text = text.replace("\t", " ")
        

        if (":" in text):    # Check if there is a label
            text = text.split(":")
            # Add Label to Symbol Table
            symbolTable[text[0].lower()] = ['label', hex(i), 2, None]
            text = text[1]
        
        # Break apart instructions into their components
        text = text.split(" ")
        for j, instr in enumerate(text):
            if ("," in instr):
                instr = instr.split(",")
                instr = [x for x in instr if x != '']
                if (len(instr) > 1):
                    text.pop(j)
                    instr.reverse()
                    for val in instr:
                        text.insert(j, val)
                else:
                    text[j] = instr[0]

        
        textsection[i] = list(filter(lambda x: x != '', text))

    textsection = list(filter(lambda x: x != [], textsection))

    output.debug(f'Data:\n{datasection}')
    output.debug(f'Instructions:\n{textsection}')
    output.debug(f'Symbol Table:\n{symbolTable}')
    
    output.passed("Successfully generated symbol table")
    return (datasection, textsection), symbolTable