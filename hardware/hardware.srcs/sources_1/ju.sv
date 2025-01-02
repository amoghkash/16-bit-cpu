`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/31/2024 03:21:15 PM
// Design Name: 
// Module Name: jump_unit
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


module jump_unit(en, func, in, out);
    input en;
    input [1:0]func;
    input [`WORD_SIZE-1:0]in;
    output reg out;
    
    always_comb begin
        if (en) begin
            case(func)
                `JUMP_NOCOND:   out <= 1;
                `JUMP_BEQZ:     out <= (in == 15'b0) ? 1 : 0;
                `JUMP_BNEZ:     out <= (in != 15'b0) ? 1 : 0;
                default:        out <= 0;
            endcase
        end
    end
    
    
endmodule
