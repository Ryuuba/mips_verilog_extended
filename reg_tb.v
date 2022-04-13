`timescale 1ns/100ps
`include "structural_parallel_register.v"

module testbench;

    parameter m = 32;
    reg[m-1:0] input_d;
    reg clk_in, enable_in, rst;
    wire[m-1:0] output_q;

    defparam reg_unit.n = m;
    parallel_register reg_unit(
        input_d,
        output_q,
        enable_in,
        rst,
        clk_in
    );

    always begin
        #1;
        clk_in = ~clk_in;
    end

    initial begin
        $dumpfile("register.vcd");
        $dumpvars(0, testbench);
        clk_in = 0;
        rst = 0;
        input_d = 32'hFF0000FF;
        enable_in = 0;
        #10;
        enable_in = 1;
        #10;
        enable_in = 0;
        rst = 1;
        #2;
        rst = 0;
        #4;
        enable_in = 1;
        #4;
        $finish;
    end

endmodule