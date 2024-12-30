`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/28/2024 05:49:55 PM
// Design Name: 
// Module Name: register
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


module register # (
    parameter int SIZE = 16
    )(
    input [(SIZE-1):0] in,
    input clk,
    input reset,
    input enable,
    input [(SIZE-1):0] out
    );
    
    logic [(SIZE-1):0] value = '0;
    assign out = value;
    
    always@(posedge clk) begin
        if(reset) 
            value = '0;
        else if (enable)
           value = in;
    end
    
endmodule
