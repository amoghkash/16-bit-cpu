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
    imm_enable, imm_value,
    jump_en, jump_type,
    mem_en, mem_store,
    x_reg_ctl, z_reg_ctl,
    alu_en, alu_type, loadh_flag,
    peripheral_en, peripheral_val
    );
    `include "parameters.vh"
    // Opcode & Instruction
    input logic [3:0]opcode;
    input logic [11:0]instruction;
    
    output logic regfile_rwe;
    
    logic [3:0]imm;
    output logic imm_enable;
    output logic [15:0]imm_value;
    
    output logic jump_en;
    output logic [1:0]jump_type;
    
    output logic mem_en, mem_store;
    
    output logic x_reg_ctl, z_reg_ctl;
    
    logic alu_n;
    output logic alu_en, loadh_flag;
    output logic [2:0]alu_type;
    
    output logic peripheral_en;
    output logic [3:0]peripheral_val;
    
    assign alu_en = ~alu_n;
    assign imm = instruction[3:0];
    
    always_comb begin
        case(opcode)
            `ALU_ADD: begin
                {alu_n, alu_type} = opcode;
                regfile_rwe = 1;
                imm_enable = 0;
                imm_value = 'x;
                jump_en = 0;
                jump_type = opcode[1:0];
                mem_en = 0;
                mem_store = 0;
                x_reg_ctl = 0;
                z_reg_ctl = 0;
                loadh_flag = 0;
                peripheral_en = 0;
                peripheral_val = 'x;
            end
            `ALU_ADDI: begin
                {alu_n, alu_type} = opcode;
                regfile_rwe = 1;
                imm_enable = 1;
                imm_value = {{12{imm[3]}}, imm};
                jump_en = 0;
                jump_type = opcode[1:0];
                mem_en = 0;
                mem_store = 0;
                x_reg_ctl = 0;
                z_reg_ctl = 0;
                loadh_flag = 0;
                peripheral_en = 0;
                peripheral_val = 'x;
            end
            `ALU_SUB: begin
                {alu_n, alu_type} = opcode;
                regfile_rwe = 1;
                imm_enable = 0;
                imm_value = 'x;
                jump_en = 0;
                jump_type = opcode[1:0];
                mem_en = 0;
                mem_store = 0;
                x_reg_ctl = 0;
                z_reg_ctl = 0;
                loadh_flag = 0;
                peripheral_en = 0;
                peripheral_val = 'x;
            end
            `ALU_AND: begin
                {alu_n, alu_type} = opcode;
                regfile_rwe = 1;
                imm_enable = 0;
                imm_value = 'x;
                jump_en = 0;
                jump_type = opcode[1:0];
                mem_en = 0;
                mem_store = 0;
                x_reg_ctl = 0;
                z_reg_ctl = 0;
                loadh_flag = 0;
                peripheral_en = 0;
                peripheral_val = 'x;
            end
            `ALU_OR: begin
                {alu_n, alu_type} = opcode;
                regfile_rwe = 1;
                imm_enable = 0;
                imm_value = 'x;
                jump_en = 0;
                jump_type = opcode[1:0];
                mem_en = 0;
                mem_store = 0;
                x_reg_ctl = 0;
                z_reg_ctl = 0;
                loadh_flag = 0;
                peripheral_en = 0;
                peripheral_val = 'x;
            end
            `ALU_XOR: begin
                {alu_n, alu_type} = opcode;
                regfile_rwe = 1;
                imm_enable = 0;
                imm_value = 'x;
                jump_en = 0;
                jump_type = opcode[1:0];
                mem_en = 0;
                mem_store = 0;
                x_reg_ctl = 0;
                z_reg_ctl = 0;
                loadh_flag = 0;
                peripheral_en = 0;
                peripheral_val = 'x;
            end
            `ALU_NOT: begin
                {alu_n, alu_type} = opcode;
                regfile_rwe = 1;
                imm_enable = 0;
                imm_value = 'x;
                jump_en = 0;
                jump_type = opcode[1:0];
                mem_en = 0;
                mem_store = 0;
                x_reg_ctl = 0;
                z_reg_ctl = 0;
                loadh_flag = 0;
                peripheral_en = 0;
                peripheral_val = 'x;
            end
            `ALU_SHIFT: begin
                {alu_n, alu_type} = opcode;
                regfile_rwe = 1;
                imm_enable = 1;
                imm_value = {{12{imm[3]}}, imm};
                jump_en = 0;
                jump_type = opcode[1:0];
                mem_en = 0;
                mem_store = 0;
                x_reg_ctl = 0;
                z_reg_ctl = 0;
                loadh_flag = 0;
                peripheral_en = 0;
                peripheral_val = 'x;
            end
            `OP_LOADH: begin
                {alu_n, alu_type} = 4'b0000;
                regfile_rwe = 1;
                imm_enable = 1;
                imm_value = {{4{instruction[11]}}, instruction};
                jump_en = 0;
                jump_type = opcode[1:0];
                mem_en = 0;
                mem_store = 0;
                x_reg_ctl = 0;
                z_reg_ctl = 1;
                loadh_flag = 1;
                peripheral_en = 0;
                peripheral_val = 'x;
            end
            `OP_LW: begin
                {alu_n, alu_type} = opcode;
                regfile_rwe = 1;
                imm_enable = 0;
                imm_value = 'x;
                jump_en = 0;
                jump_type = opcode[1:0];
                mem_en = 1;
                mem_store = 0;
                x_reg_ctl = 0;
                z_reg_ctl = 0;
                loadh_flag = 0;
                peripheral_en = 0;
                peripheral_val = 'x;
            end
            `OP_SW: begin
                {alu_n, alu_type} = opcode;
                regfile_rwe = 0;
                imm_enable = 0;
                imm_value = 'x;
                jump_en = 0;
                jump_type = opcode[1:0];
                mem_en = 1;
                mem_store = 1;
                x_reg_ctl = 0;
                z_reg_ctl = 0;
                loadh_flag = 0;
                peripheral_en = 0;
                peripheral_val = 'x;
            end
            `OP_JUMP: begin
                {alu_n, alu_type} = opcode;
                regfile_rwe = 0;
                imm_enable = 0;
                imm_value = 'x;
                jump_en = 1;
                jump_type = opcode[1:0];
                mem_en = 0;
                mem_store = 0;
                x_reg_ctl = 0;
                z_reg_ctl = 0;
                loadh_flag = 0;
                peripheral_en = 0;
                peripheral_val = 'x;
            end
            `OP_BEQZ: begin
                {alu_n, alu_type} = opcode;
                regfile_rwe = 0;
                imm_enable = 0;
                imm_value = 'x;
                jump_en = 1;
                jump_type = opcode[1:0];
                mem_en = 0;
                mem_store = 0;
                x_reg_ctl = 1;
                z_reg_ctl = 0;
                loadh_flag = 0;
                peripheral_en = 0;
                peripheral_val = 'x;
            end
            `OP_BNEZ: begin
                {alu_n, alu_type} = opcode;
                regfile_rwe = 0;
                imm_enable = 0;
                imm_value = 'x;
                jump_en = 1;
                jump_type = opcode[1:0];
                mem_en = 0;
                mem_store = 0;
                x_reg_ctl = 1;
                z_reg_ctl = 0;
                loadh_flag = 0;
                peripheral_en = 0;
                peripheral_val = 'x;
            end
            `OP_OUT: begin
                {alu_n, alu_type} = opcode;
                regfile_rwe = 0;
                imm_enable = 0;
                imm_value = 'x;
                jump_en = 1;
                jump_type = opcode[1:0];
                mem_en = 0;
                mem_store = 0;
                x_reg_ctl = 1;
                z_reg_ctl = 0;
                loadh_flag = 0;
                peripheral_en = 1;
                peripheral_val = instruction[11:8];
            end
            `OP_HALT: begin
                {alu_n, alu_type} = opcode;
                regfile_rwe = 0;
                imm_enable = 0;
                imm_value = 'x;
                jump_en = 0;
                jump_type = opcode[1:0];
                mem_en = 0;
                mem_store = 0;
                x_reg_ctl = 0;
                z_reg_ctl = 0;
                loadh_flag = 0;
                peripheral_en = 0;
                peripheral_val = instruction[11:8];
            end
        endcase
    end
endmodule
