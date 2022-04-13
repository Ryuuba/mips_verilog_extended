`ifndef ALU
`define ALU
module alu(a, b, aluop, flagz, salida);
    parameter   n = 32;
    input wire  [n-1:0]a;
    input wire  [n-1:0]b;
    input wire  [2:0] aluop;
    output wire [n-1:0] salida;
    output wire flagz;

    wire[n-1:0] wb, w_and, w_or, wsum, w_sign, wres;

    assign wb = (aluop[2] == 0) ? b : ~b ;
    assign w_and = (a & wb);
    assign w_or = (a | wb);
    assign wsum = (a + wb + aluop[2]);
    assign w_sign[n-1:1] = 0;
    assign w_sign[0] = wsum[n-1];
    assign wres = (aluop[1:0] == 0) ? w_and : 
                  (aluop[1:0] == 1) ? w_or  : 
                  (aluop[1:0] == 2) ? wsum  : 
                                      w_sign;
    assign flagz = ~|wres;
    assign salida = wres;
endmodule
`endif