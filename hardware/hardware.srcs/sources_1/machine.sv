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


module machine(
    
    );
    logic clock;
    logic init_mem_en = 0;
    logic [11:0] init_mem_address;
    logic [15:0] init_mem_data;
    
    instruction_memory code_mem(
    .clka(clock),
    .ena(init_mem_en),
    .addra(init_mem_address),
    .douta(init_mem_data)
    );
endmodule

