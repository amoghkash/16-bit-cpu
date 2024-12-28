`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/17/2024 12:39:09 AM
// Design Name: 
// Module Name: regfile
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


module regfile #(
    parameter int WIDTH = 16,
    parameter int DEPTH = 8
    )(
    input [$clog2(DEPTH)-1:0] x,
    input [$clog2(DEPTH)-1:0] y,
    input [$clog2(DEPTH)-1:0] z,
    output [(WIDTH-1):0] x_out,
    output [(WIDTH-1):0] y_out,
    input  [(WIDTH-1):0] z_in,
    input clk,
    input wren,
    input imm_en,
    input rst_n
    );
    
    logic [WIDTH-1:0] registers [0:DEPTH-1];
    logic [WIDTH-1:0] y_temp;
    
    assign x_out = registers[x];
    assign y_out = y_temp;
    
    // TriState Y Bus if immediate_en is high
    always_comb
    begin
        if (imm_en)
            y_temp = 15'bz;
        else
            y_temp = registers[y];
    end
    
    // If wren is enabled, write to REGFILE
    always_ff @(posedge clk or negedge rst_n) begin
        if(rst_n == 'b0) begin
        for (int i = 0; i < DEPTH; i++) begin
            registers[i] <= '0;
        end
        end else if (wren) begin
            registers[z] = z_in;
        end
    end
        
    
endmodule
