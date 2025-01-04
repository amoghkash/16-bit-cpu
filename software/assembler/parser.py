import sys
import settings
from output import failed, passed, debug, printSettings

def parse():
    parse_args()
    check_file()
    printSettings()
    return

def parse_args():
    if("-h" in sys.argv):
        print("Usage: python main.py [INPUTFILE] [-d] [-f <format>] [-s <num_of_addresses>]")
        print("-d: Debug flag")
        print("-f: Format type")
        print("-s: Number of addresses")
        sys.exit(0)
    
    if(len(sys.argv) < 2):
        print("Usage: python main.py [INPUTFILE] [-d] [-f <format>] [-s <num_of_addresses>]")
        print("-d: Debug flag")
        print("-f: Format type")
        print("-s: Number of addresses")
        sys.exit(0)
    
    settings.INPUT_FILE = sys.argv[1]

    if("-d" in sys.argv):
        settings.DEBUG_LOW_FLAG = True
    
    if("-D" in sys.argv):
        settings.DEBUG_FLAG = True
        settings.DEBUG_LOW_FLAG = True

    if("-f" in sys.argv):
        if (".bin" in sys.argv):
            settings.FORMAT_TYPE = '.bin'
        elif (".coe" in sys.argv):
            settings.FORMAT_TYPE = '.coe'
        elif (".csv" in sys.argv):
            settings.FORMAT_TYPE = '.csv'
        elif (".txt" in sys.argv):
            settings.FORMAT_TYPE = '.txt'

    if("-dual" in sys.argv):
        settings.DUAL_FILE_OUTPUT = True

    if("-s" in sys.argv):
        settings.NUM_OF_ADDRESSES = int(sys.argv[sys.argv.index("-s") + 1])

    return

def check_file():
    if(settings.INPUT_FILE == ""):
        failed("No input file specified")
        sys.exit(1)

    filetype = settings.INPUT_FILE.split(".")
    if (filetype[-1] != "asm"):
        failed("Invalid file type")
        sys.exit(1)
    
    try:
        with open(settings.INPUT_FILE, "r") as file:
            contents = file.read()
            if (".data" not in contents):
                failed("File doesn't contains .data section")
                sys.exit(1)
            elif (".text" not in contents):
                failed("File doesn't contains .text section")
                sys.exit(1)
            passed("File is valid")
            file.close()
        
    except FileNotFoundError:
        failed("File not found")
        sys.exit(1)