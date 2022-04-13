`ifndef DECODER_V
`define DECODER_V

module decoder(
  a,  //address port
  f,  //output port
  e   //enable port
);
  parameter n = 5;
  localparam m = $pow(2, n);
  
  input  wire e;
  input  wire[n-1:0] a;
  output wire[m-1:0] f;


  assign f = (e) ? 1 << a : 'b0;


endmodule

`endif