`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/28/2024 05:03:29 PM
// Design Name: 
// Module Name: cpu
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

typedef enum {
    init,
    fetch,
    decode,
    execute
} state;

module cpu(clock, resetn,
    inst_addr, inst_data, inst_en,
    );
    
    input clock, resetn;
    
    // Instruction Memory Interface
    output [11:0]inst_addr;
    input [15:0]inst_data;
    input inst_en;
    
    // Internal Registers
    logic [11:0]pc = '0;
    logic [15:0]ir = '0;
    
    // Instruction Information
    logic [3:0]opcode, v1, v2, v3;
    logic [2:0]aluop;
    logic [11:0]value;
    
    // Control Signals
    logic rwe, imm_en, alu_op;
    
    // Intenal Buses
    logic [15:0] x, y, z;  
    
    
    // Instruction Decoder
    decoder inst_decoder(
    .instr(inst_data),
    .opcode(opcode),
    .regx(v1),
    .regy(v2),
    .regz(v3),
    .aluop(aluop),
    .isaluop(alu_op),
    .value(value)
    );
    
    // Control Signal Generator
    control_unit control(
    .opcode(opcode),
    .instruction(value),
    .regfile_rwe(rwe),
    .imm_enable(imm_en)
    );
    
    // Register File
    regfile registers(
    .x(v1),
    .y(v2),
    .z(v3),
    .x_out(x),
    .y_out(y),
    .z_in(z),
    .wren(rwe),
    .imm_en(imm_en),
    .clk(clock),
    .rst_n(resetn)
    );
    
    // Arithmetic Unit
    alu alu(
    .clk(clock),
    .alu_en(alu_op),
    .in1(x)
    );
    
    
    
    assign inst_addr = pc;
    
    always@(posedge clock, resetn) begin
    end
    
endmodule
