`ifndef DOWN_COUNTER_V
`define DOWN_COUNTER_V

module down_counter (
  output wire[m-1:0] data_out,  // n-bit data output
  input  wire        count,     // ctrl port
  input  wire        set,       // set the counter
  input  wire        clk        // clock port
);

  parameter n = 32;
  localparam m = $clog2(n);
  reg[m-1:0] state;

  always @(posedge clk or posedge set) begin
    if (set)
      state <= 1;
    else if(count)
      state <= state - 1;
  end

  assign data_out = state;

endmodule


`endif // DOWN_COUNTER_V