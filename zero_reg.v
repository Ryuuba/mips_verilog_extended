`ifndef ZERO_REG_V
`define ZERO_REG_V

module zero_register(
    d_port,     //n-bit input port
    q_port,     //n-bit output port
    en_port,    //one-bit port, it enables writting op
    rst_port,   //Hard reset signal
    clk_port    //one-bit clk signal
);

  parameter n = 4;
  input wire[n-1:0] d_port;
  input wire en_port, clk_port, rst_port;
  output wire[n-1:0] q_port;

  assign q_port = 'b0;

endmodule


`endif