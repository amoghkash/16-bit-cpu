import settings
import parser
import symboltable
import linker
import formatter

def main():
    
    parser.parse()
    info, table = symboltable.generate()
    binary = linker.link(info, table)
    formatter.format(binary)




if __name__ == '__main__':
    main()
