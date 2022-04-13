`ifndef BARREL_SHIFTER_V
`define BARREL_SHIFTER_V

module barrel_shifter(
  data_port,
  shamnt,
  mode,
  result
);

  input  wire mode;
  input  wire[31:0] data_port;
  input  wire[4:0] shamnt;
  output wire[31:0] result;

  assign result = (mode) ? data_port >> shamnt : data_port << shamnt;

endmodule

`endif