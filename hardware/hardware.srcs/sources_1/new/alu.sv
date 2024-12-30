`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/29/2024 11:22:37 PM
// Design Name: 
// Module Name: alu
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

`include "parameters.vh"

module alu(
    input clk, alu_en,
    input [2:0]op,
    input [15:0] in1, in2,
    output reg [15:0]result
    );
    
    always_comb@(posedge clk) begin
        if (alu_en) begin
            case(op)
                `ALU_ADD:
                    result <= in1 + in2;
                `ALU_ADDI:
                    result <= in1 + in2;
                `ALU_SUB:
                    result <= in1 - in2;
                `ALU_AND:
                    result <= in1 & in2;
                `ALU_OR:
                    result <= in1 | in2;
                `ALU_XOR:
                    result <= in1 ^ in2;
                `ALU_NOT:
                    result <= !in1;
                `ALU_SHIFT:
                    result <= in1 << in2;
            endcase
        end
    end
    
    
endmodule
