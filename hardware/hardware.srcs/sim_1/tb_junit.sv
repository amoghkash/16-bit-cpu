`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/01/2025 03:12:16 PM
// Design Name: 
// Module Name: tb_junit
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


module tb_junit;

logic jump_en;
logic [1:0]jump_type;
logic [`WORD_SIZE-1:0]val;
logic result;

jump_unit junit(
.en(jump_en),
.func(jump_type),
.in(val),
.out(result)
);

initial begin
    jump_en = 0;
    jump_type = 0;
    val = 0;
    result = 0; 
    
    #1
    // Make Sure Enable Works
    $display("[JUMP UNIT]|Test 1:%h|expected:0", result);
    
    jump_type = 2'b11;
    val = 7;
    #1
    // Make Sure Enable Works
    $display("[JUMP UNIT]|Test 2:%h|expected:0", result);
    
    jump_en = 1;
    #1
    // Make Sure JUMP works
    $display("[JUMP UNIT]|Test 3:%h|expected: 1", result);
    
    jump_type = 2'b00;
    #1
    // Make Sure BEQZ works without a 0 in R1
    $display("[JUMP UNIT]|Test 4:%h|expected: 0", result);
    
    val = 0;
    #1
    // Make Sure BEQZ works with a 0 in R1
    $display("[JUMP UNIT]|Test 5:%h|expected: 1", result);
    
    jump_type = 2'b01;
    #1
    // Make Sure BNEZ works with a 0 in R1
    $display("[JUMP UNIT]|Test 6:%h|expected: 0", result);
    
    val = 15;
    #1
    // Make Sure BNEZ works without a 0 in R1
    $display("[JUMP UNIT]|Test 7:%h|expected: 1", result);
    
end

endmodule
