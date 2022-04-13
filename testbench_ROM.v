`timescale 1ns/100ps
`include "ROM.v"

module ROM_U;

 reg[31:0]  address;
 wire [31:0]  instruction;

integer i;

ROM ROM_T(address, instruction);
initial begin
    $dumpfile("ROM_PRO.vcd");
    $dumpvars(0,ROM_U);

    address=0;
    
    for (i=0 ; i<127 ; i=i+4) begin
      address=i;
      #2;
    end

    
    $finish;
end
endmodule

