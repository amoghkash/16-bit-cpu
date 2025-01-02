`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/28/2024 05:01:13 PM
// Design Name: 
// Module Name: machine
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


module machine(reset, clk_in);
    input reset, clk_in;
    
    logic clock;
    logic init_mem_en = 0;
    logic [11:0] init_mem_address;
    logic [15:0] init_mem_data;
    
    logic mem_en, mem_we = 0;
    logic [15:0] mem_addr = '0;
    logic [15:0] mem_din, mem_dout;
    
    assign rstn = ~reset;
    
    general_memory your_instance_name (
    .clka(clock),    // input wire clka
    .ena(mem_en),      // input wire ena
    .wea(mem_we),      // input wire [0 : 0] wea
    .addra(mem_addr),  // input wire [15 : 0] addra
    .dina(mem_din),    // input wire [15 : 0] dina
    .douta(mem_dout)  // output wire [15 : 0] douta
    );
      
    instruction_memory code_mem(
    .clka(clock),
    .ena(init_mem_en),
    .addra(init_mem_address),
    .douta(init_mem_data)
    );
    
    mhz_12_clock sys_clock(
    .clk_out1(clock),     // output clk_out1
    .reset(reset),  // input reset
    .clk_in1(clk_in)      // input clk_in1
    );
    
    cpu cpu(
    .clock(clock),
    .resetn(rstn),
    .inst_addr(init_mem_address),
    .inst_data(init_mem_data),
    .inst_en(init_mem_en),
    .m_addr(mem_addr),
    .m_datain(mem_dout),
    .m_dataout(mem_din),
    .m_en(mem_en),
    .m_we(mem_we)
    );
endmodule

