`ifndef D_FLIP_FLOP_V
`define D_FLIP_FLOP_V

module d_flip_flop(
  input  wire d,     //1-bit input port
  output wire q,     //1-bit ouput port
  input  wire en,    //ctrl port enables writing
  input  wire rst,   //Hard reset signal
  input  wire clk    //one-bit clk signal
);

  reg state;

  always@(posedge clk or posedge rst) begin
    if (rst)
      state <= 0;
    else if (en)
      state <= d;
  end

  assign q = state;

endmodule

`endif // D_FLIP_FLOP_V