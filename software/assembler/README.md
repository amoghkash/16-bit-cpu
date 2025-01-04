# Assembler

## The Different Steps
There are a few different steps required to assembly an assembly file into a binary or other type of memory description file. These steps are:

- Parsing
- Symbol Table Generation
- Linker
- Formatting

Each step is unique and has its own function and processes that are expanded on below.

### Parsing
Parsing makes sure that the input file is a valid filetype and then loads it into into memory. It also reads through any command line arguments that were provided and sets global flags for them.

### Symbol Table Generation
Symbol Table Generation takes all data and labels that are provided and  creates a symbol table that stores all of them along with their respective addresses, size and data types.

An example symbol table looks like this:

|   Name    |   Type    |   Memory Value    |   Size(bytes) |   Values  |
| --------- | --------- | ----------------- | ------------- | --------- |   
| NumArray  |   prim    |       0x0000      |       8       |  2,4,1,7  |
| Counter   |   prim    |       0x0008      |       4       |     0     |
| End       |   label   |       0x00CE      |       4       |   NULL    |

The name column holds the name of the label/data. The type columns holds whether the type is a label or a primitive. For primitives, the memory value is calculated as an offset of the last piece of data. For a label, the memory value is absolute and has to fit within 12 bits.

### Linker
The linker has 3 different steps within it:
- Analysis
- Generation
- Linking

**Analysis** looks to ensure that each line of code adheres to the specified requirements:
- Making sure that immediates are 4 bits long
- Ensuring that the max register is r15
- Each operation has correct # of arguments

**Generation** converts the code into it's respective bitstring based on opcode, register values, immediate values, etc.

**Linking** Takes all the generated code and combines it all together into one contingous file.

### Formatting

Based on the flags and options that were passed, the linked file gets formatted into a few different options:
- .bin file
- .txt file
- .csv file
- .coe file

These files are outputted in the same directory as the input file. You can read more about the different format below.

## Output File Formats

### .bin
The .bin file is a binary file with all the memory data stored in a contiguous block.

### .txt
The .txt file is a txt file with all the memory data.

### .csv
The .csv file is a csv file that holds all the memory values in csv format. There are 16 columns, one for each bit.

### .coe
The .coe file is a memory file specific to Xilinix Vivado. The format is as follows:

memory_initialization_radix = 2

memory_initialization_vector =
0,0,0,0,0,0,0,1,0,1,0,1,0,1,0,0,0,0,0,1,0,1,0,1,1,1,0,1,0,1,0,0,1,1,1,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1

## Development

- Made in python
- CLI (sys.argv or click)
- executable (using pyinstaller)
