`ifndef PARALLEL_REGISTER_V
`define PARALLEL_REGISTER_V

module register(
    d_port,     //n-bit input port
    q_port,     //n-bit output port
    en_port,    //one-bit port, it enables writting op
    rst_port,   //Hard reset signal
    clk_port    //one-bit clk signal
);

  parameter n = 32;
  input wire[n-1:0] d_port;
  input wire en_port, clk_port, rst_port;
  output wire[n-1:0] q_port;

  reg[n-1:0] state;

  always@(posedge clk_port or posedge rst_port) begin
    if (rst_port)
      state = 'b0;
    else if (en_port)
      state = d_port;
  end

  assign q_port = state;

endmodule

`endif