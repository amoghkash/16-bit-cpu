`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/17/2024 01:15:02 AM
// Design Name: 
// Module Name: sim_regfile
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

module tb_regfile;

    // Parameters
    parameter WIDTH = 16;
    parameter DEPTH = 8;

    // Signals
    logic                   clk = 0;
    logic                   rst_n = 0;
    logic                   write_en = 0;
    logic [$clog2(DEPTH)-1:0] rd_addr1;
    logic [$clog2(DEPTH)-1:0] rd_addr2;
    logic [$clog2(DEPTH)-1:0] wr_addr;
    logic [WIDTH-1:0]       wr_data;
    logic [WIDTH-1:0]       rd_data1;
    logic [WIDTH-1:0]       rd_data2;

    // Instantiate the DUT (Device Under Test)
    regfile #(
        .WIDTH(WIDTH),
        .DEPTH(DEPTH)
    ) dut (
        .clk(clk),
        .rst_n(rst_n),
        .wren(write_en),
        .x(rd_addr1),
        .y(rd_addr2),
        .z(wr_addr),
        .z_in(wr_data),
        .x_out(rd_data1),
        .y_out(rd_data2)
    );

    // Clock generation
    always #5 clk = ~clk;
    
    initial begin
        // Initialize signals
        clk       = 0;
        rst_n     = 0;
        write_en  = 0;
        rd_addr1  = 0;
        rd_addr2  = 0;
        wr_addr   = 0;
        wr_data   = 0;

        // Apply reset
        //$display("Applying reset...");
        #10;
        rst_n = 1;

        // Write to register 3
        //$display("Writing to register 3...");
        write_en = 1;
        wr_addr = 3;
        wr_data = 16'hABCD;
        #10;

        // Disable write
        write_en = 0;
        wr_addr = 0;
        wr_data = 0;

        // Read from register 3
        //$display("Reading from register 3...");
        rd_addr1 = 3;
        #10;
        $display("[REGFILE]|Test 1:%h|expected:abcd", rd_data1);

        // Write to register 5
        //$display("Writing to register 5...");
        write_en = 1;
        wr_addr = 5;
        wr_data = 16'hCAFE;
        #10;

        // Disable write
        write_en = 0;

        // Simultaneous reads
        //$display("Reading from registers 3 and 5...");
        rd_addr1 = 3;
        rd_addr2 = 5;
        #10;
        $display("[REGFILE]|Test 2:%h|expected:abcd", rd_data1);
        $display("[REGFILE]|Test 3:%h|expected:cafe", rd_data2);
       
        
        // End simulation
        //$display("Simulation complete!");
    end

endmodule

