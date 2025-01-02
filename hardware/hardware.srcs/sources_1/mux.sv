`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/30/2024 11:42:37 AM
// Design Name: 
// Module Name: mux
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


module mux2_1 #(
    parameter SIZE = 16
    )(
    input [SIZE-1:0]in0,
    input [SIZE-1:0]in1,
    input select,
    output [SIZE-1:0]out
    );
    
    assign out = select ? in1 : in0;
endmodule
