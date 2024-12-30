`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/29/2024 11:08:55 PM
// Design Name: 
// Module Name: decoder
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


module decoder(
    input [15:0]instr,
    output [3:0]opcode,
    output [3:0]regx,
    output [3:0]regy,
    output [3:0]regz,
    output [2:0]aluop,
    output isaluop,
    output [11:0]value
    );
    
    assign {opcode, value} = instr;
    assign {regx, regy, regz} = value;
    assign {isaluop, aluop} = opcode;
endmodule
