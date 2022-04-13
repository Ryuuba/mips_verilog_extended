`ifndef UNIVERSAL_SHIFTER
`define UNIVERSAL_SHIFTER

module universal_shifter(
  input  wire[n-1:0] data_in,    // parallel data input
  input  wire        serial_in,  // serial data input
  output wire[n-1:0] data_out,   // Parallel output port
  input  wire[1:0]   ctrl,       // ctrl port
  input  wire        rst,        // hard reset port
  input  wire        clk         // clock port
);

  parameter n = 32;
  reg[n-1:0] state;

  always@(posedge clk or posedge rst) begin
    if (rst)
      state <= 0;
    else if (ctrl == 2'b01)   // parallel load
      state <= data_in;
    else if (ctrl == 2'b10)   // serial shift to the left
      state <= {state[n-2:0], serial_in};
    else if (ctrl == 2'b11)   // serial shift to the right
      state <= {serial_in, state[n-1:1]};
  end

  assign data_out = state;

endmodule

`endif // UNIVERSAL_SHIFTER