parameter WORD_SIZE = 16;

`define ALU_ADD         4'h0
`define ALU_ADDI        4'h1
`define ALU_SUB         4'h2
`define ALU_AND         4'h3
`define ALU_OR          4'h4
`define ALU_XOR         4'h5
`define ALU_NOT         4'h6
`define ALU_SHIFT       4'h7

`define OP_LOADH        4'h8
`define OP_LW           4'h9
`define OP_SW           4'hA
`define OP_JUMP         4'hB
`define OP_BEQZ         4'hC
`define OP_BNEZ         4'hD
`define OP_OUT          4'hE
`define OP_HALT         4'hF