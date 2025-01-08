#``
op_add =    'b0000'
op_addi =   'b0001'
op_sub =    'b0010'
op_and =    'b0011'
op_or =     'b0100'
op_xor =    'b0101'
op_not =    'b0110'
op_shift =  'b0111'
op_loadh =  'b1000'
op_lw =     'b1001'
op_sw =     'b1010'
op_j =      'b1011'
op_beqz =   'b1100'
op_bnez =   'b1101'
op_out =    'b1110'
op_halt =   'b1111'

T1 = ["R", "R", "R"]
T2 = ["R", "R", "I"]
T3 = ["R", "R", "Z"]
T4 = ["L"]
T5 = ["Z"]

operations = {"add":    [op_add, T1],
              "addi":   [op_addi, T2],
              "sub":    [op_sub, T1],
              "and":    [op_and, T1],
              "or":     [op_or, T1],
              "xor":    [op_xor, T1],
              "not":    [op_not, T3],
              "shift":  [op_shift, T3],
              "loadh":  [op_loadh, T4],
              "lw":     [op_lw, T3],
              "sw":     [op_sw, T3],
              "jump":   [op_j, T4],
              "beqz":   [op_beqz, T4],
              "bnez":   [op_bnez, T4],
              "out":    [op_out, T3],
              "halt":   [op_halt, T5]}

# Other Constants
WORD_MAX_VALUE = 0xFFFF
IMMEDIATE_MAX_VALUE = 7
IMMEDIATE_MIN_VALUE = -8
WORD_MIN_VALUE = -32768
WORD_MAX_VALUE = 32767
MAX_VAL_12_BIT = 0xFFF
MAX_VAL_4_BIT = 0xF
MAX_REGISTER_VALUE = 15