`ifndef REGISTER_FILE_V
`define REGISTER_FILE_V

`include "parallel_register.v"
`include "tri_state_buffer.v"
`include "decoder.v"
`include "zero_reg.v"

module register_file(
  data_d,     //32-bit data input
  data_a,     //32-bit data output
  data_b,     //32-bit data output
  address_d,  //5-bit port address
  address_a,  //5-bit port address
  address_b,  //5-bit port address
  wr,         //enable-writting signal
  rst_port,   //reset port
  clk_port    //clock port
);

  input  wire wr, rst_port, clk_port;
  input  wire[31:0] data_d;
  input  wire[ 4:0] address_d, address_a, address_b;
  output wire[31:0] data_a, data_b;


  wire[31:0] iw_reg[31:0];
  wire[31:0] iw_dec_d, iw_dec_a, iw_dec_b;

  decoder dec_d(address_d, iw_dec_d, wr);
  decoder dec_a(address_a, iw_dec_a, 1'b1);
  decoder dec_b(address_b, iw_dec_b, 1'b1);

  assign iw_reg[0] = 0;

  genvar j;
  generate
    for(j = 0; j < 32; j = j + 1) begin
      defparam buffer_a.n = 32;
      tri_state_buffer buffer_a(iw_reg[j], iw_dec_a[j], data_a);
    end
  endgenerate
  
  genvar k;
  generate
    for(k = 0; k < 32; k = k + 1) begin
      defparam buffer_b.n = 32;
      tri_state_buffer buffer_b(iw_reg[k], iw_dec_b[k], data_b);
    end
  endgenerate
  
  genvar i;
  generate
    for(i = 1; i < 32; i = i + 1) begin
      defparam reg_u.n = 32;
      register reg_u(data_d, iw_reg[i], iw_dec_d[i], rst_port, clk_port);
    end
  endgenerate


endmodule

`endif  // REGISTER_FILE_V