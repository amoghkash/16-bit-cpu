import settings
import parser
import symboltable

def main():
    
    parser.parse()
    info, table = symboltable.generate()

if __name__ == '__main__':
    main()