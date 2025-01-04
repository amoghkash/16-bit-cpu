
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

operations = {"ADD":    [op_add, T1],
              "ADDI":   [op_addi, T2],
              "SUB":    [op_sub, T1],
              "AND":    [op_and, T1],
              "OR":     [op_or, T1],
              "XOR":    [op_xor, T1],
              "NOT":    [op_not, T3],
              "SHIFT":  [op_shift, T3],
              "LOADH":  [op_loadh, T4],
              "LW":     [op_lw, T3],
              "SW":     [op_sw, T3],
              "J":      [op_j, T4],
              "BEQZ":   [op_beqz, T4],
              "BNEZ":   [op_bnez, T4],
              "OUT":    [op_out, T3],
              "HALT":   [op_halt, T5]}