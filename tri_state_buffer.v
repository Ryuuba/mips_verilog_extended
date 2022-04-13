`ifndef TRI_STATE_BUFFER_V
`define TRI_STATE_BUFFER_V

module tri_state_buffer(x, enable, f);

  parameter n = 10;
  input  wire[n-1:0] x;
  input  wire        enable;
  output wire[n-1:0] f;

  assign f = (enable) ? x : 'bz;

endmodule

`endif