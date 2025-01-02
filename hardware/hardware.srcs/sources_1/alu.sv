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



module alu #(
    parameter SIZE = 16
    )(
    input en, loadh,
    input [2:0]op,
    input [SIZE-1:0] in1, in2,
    output reg [SIZE-1:0]result
    );
    `include "parameters.vh"
    
    logic [3:0]op_type;
    
    assign op_type = {loadh, op};
    always_comb begin
        if (en) begin
           case(op_type)
                `ALU_ADD:   result <= in1 + in2;
                `ALU_ADDI:  result <= in1 + in2;
                `ALU_SUB:   result <= in1 - in2;
                `ALU_AND:   result <= in1 & in2;
                `ALU_OR:    result <= in1 | in2;
                `ALU_XOR:   result <= in1 ^ in2;
                `ALU_NOT:   result <= !in1;
                `ALU_SHIFT: result <= in1 << in2;
                `OP_LOADH:  result <= in2 << 12;
                 default:   result <= 'z;
            endcase
        end else begin
            result <= 16'b0;
        end
    end
    
    
endmodule
