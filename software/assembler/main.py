import settings
import parser
import symboltable
import linker

def main():
    
    parser.parse()
    info, table = symboltable.generate()
    linker.link(info, table)

if __name__ == '__main__':
    main()
