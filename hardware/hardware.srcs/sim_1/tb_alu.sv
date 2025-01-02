`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/31/2024 12:18:48 PM
// Design Name: 
// Module Name: tb_alu
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


module tb_alu;

logic alu_en, loadh = 0;
logic [2:0] op;
logic [15:0] v1, v2, res;

alu alu(
.en(alu_en),
.in1(v1),
.in2(v2),
.result(res),
.op(op),
.loadh(loadh)
);


initial begin
    // Initialize signals
    alu_en  = 0;
    v1      = 0;
    v2      = 0;
    res     = 0;
    loadh   = 0;
    
    #10;
    //$display("Testing enable...");
    alu_en = 0;
    v1 = 5;
    v2 = 6;
    op = 0;
    #10;
    
    $display("[ALU]|Test 1:%h|expected:0", res);
    
    //$display("Setting enable...");
    alu_en = 1;
    v1 = 'h5;
    v2 = 'h6;
    op = 3'h1;
    #10;
    
    $display("[ALU]|Test 2:%d|expected:11", res);

    v1 = 'h9;
    v2 = 'h6;
    op = 3'h4;
    #10;
    
    $display("[ALU]|Test 3:%d|expected:15", res);
    
end
endmodule
