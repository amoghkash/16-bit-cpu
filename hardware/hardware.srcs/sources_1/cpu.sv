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
} State;

module cpu(clock, resetn,
    inst_addr, inst_data, inst_en,
    m_addr, m_datain, m_dataout, m_en, m_we
    //ext_int
    );
    
    input clock, resetn;
    
    // Instruction Memory Interface
    output [11:0]inst_addr;
    input  [15:0]inst_data;
    output inst_en;
    
    // General Memory Interface
    output [15:0]   m_addr;
    input  [15:0]    m_datain;
    output [15:0]   m_dataout;
    output m_en, m_we;
    
    // Interrupt
    //output ext_int;   
    
    // Instruction Information
    logic [3:0] opcode, v1, v2, v3;
    logic [11:0] value;
    
    logic [3:0]x_tmp, z_tmp;
    
    // Control Signals
    logic rwe, imm_en, alu_en, x_ctl, z_ctl, j_en;
    logic jump, loadh; 
    logic [1:0] jtype;
    logic [2:0] aluop;
    
    // Internal Registers
    logic [11:0]pc = '0;
    logic [15:0]ir = '0;
    State state;
    
    // Intenal Buses
    logic [15:0] x, y, z, imm_va;
    logic [15:0] y_regfile;
    logic [15:0] alu_output = '0;
    
    // Instruction Decoder
    decoder inst_decoder(
    .instr(ir),
    .opcode(opcode),
    .regx(x_tmp),
    .regy(v2),
    .regz(z_tmp),
    .value(value)
    );
    
    // Control Signal Generator
    control_unit control(
    .opcode(opcode),
    .instruction(value),
    .regfile_rwe(rwe),
    .imm_enable(imm_en),
    .imm_value(imm_va),
    .jump_en(j_en),
    .jump_type(jtype),
    .mem_en(m_en),
    .mem_store(m_we),
    .x_reg_ctl(x_ctl),
    .z_reg_ctl(z_ctl),
    .alu_en(alu_en),
    .alu_type(aluop),
    .loadh_flag(loadh),
    .peripheral_en(),
    .peripheral_val()
    );
    
    // Y Bus Selector - RegFile Y Value and Immediate Value
    mux2_1 y_bus_select(
    .in0(y_regfile),
    .in1(imm_va),
    .select(imm_en),
    .out(y)
    );
    
    // X Register Selector - Instruction Value or Register 1
    mux2_1 #(.SIZE(4)) x_reg_select (
    .in0(x_tmp),
    .in1(4'b0001),
    .select(x_ctl),
    .out(v1)
    );
    
    // Z Register Selector - Instruction Value or Register 1
    mux2_1 #(.SIZE(4)) z_reg_select (
    .in0(z_tmp),
    .in1(4'b0001),
    .select(z_ctl),
    .out(v3)
    );
    
    // Z Input Selector - ALU output or Memory Output
    mux2_1 z_bus_select (
    .in0(m_datain),
    .in1(alu_output),
    .select(alu_en),
    .out(z)
    );
    
    // Register File
    regfile registers(
    .x(v1),
    .y(v2),
    .z(v3),
    .x_out(x),
    .y_out(y_regfile),
    .z_in(z),
    .wren(rwe),
    .clk(clock),
    .rst_n(resetn)
    );
    
    // Arithmetic Unit
    alu alu(
    .en(alu_en),
    .loadh(loadh),
    .in1(x),
    .in2(y),
    .op(aluop),
    .result(z)
    );
    
    jump_unit jumpu(
    .en(j_en),
    .func(jtype),
    .in(x),
    .out(jump)
    );
    
    assign inst_addr = pc;
    assign inst_en = 'b1;
    assign m_dataout = y;
    
    always@(posedge(clock), negedge(resetn)) begin
        if (resetn == 0) begin        
            state <= init;
        end else if (clock) begin
            case(state)
                init: begin
                    pc <= 0;
                    ir <= 0;
                    state <= decode;
                end
             
                fetch: begin
                    if (pc == 12'hFFF) begin
                        pc <= 0;
                    end else begin
                        pc <= pc + 1;
                    end
                    state <= decode;
                end
                
                decode: begin
                    ir = inst_data;
                    state <= execute;
                end
                
                execute: begin
                    if(jump == 'b1) begin
                        pc <= value;
                    end
                    state <= fetch;
                end
            endcase
        end
        
    end
    
endmodule
