import settings

class bcolors:
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKCYAN = '\033[96m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'

def passed(message:str):
    if (settings.DEBUG_LOW_FLAG):
        print(f"{bcolors.OKGREEN}[PASSED] {bcolors.ENDC}{message}")

def failed(message:str):
    print(f"{bcolors.FAIL}[FAILED] {bcolors.ENDC}{message}")

def debug(message:str):
    if (settings.DEBUG_FLAG):
        print(f"{bcolors.OKCYAN}[DEBUG] {bcolors.ENDC}\n{message}")

def printSettings():
    if (settings.DEBUG_FLAG):
        print(f"{bcolors.HEADER}[SETTINGS] {bcolors.ENDC}")
        print(f"{bcolors.WARNING}Input File: {settings.INPUT_FILE}")
        print(f"Debug Flag: {settings.DEBUG_FLAG}")
        print(f"Format Type: {settings.FORMAT_TYPE}")
        print(f"Number of Addresses: {settings.NUM_OF_ADDRESSES}")
        print(f"Dual File Output: {settings.DUAL_FILE_OUTPUT}{bcolors.ENDC}")

def statistics(message:str):
    print(f"{bcolors.BOLD}{bcolors.OKGREEN}{message}{bcolors.ENDC}")