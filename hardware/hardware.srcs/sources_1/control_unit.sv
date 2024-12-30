`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/28/2024 05:03:29 PM
// Design Name: 
// Module Name: control_unit
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module control_unit(opcode, instruction,
    regfile_rwe, 
    imm_enable, imm_value
    );
    
    // Opcode & Instruction
    input [3:0] opcode;
    input [11:0] instruction;
    input regfile_rwe;
    
    input imm_enable;
    input [15:0] imm_value;
    
endmodule
