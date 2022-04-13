`timescale 1s/100ns
`include "control_unit.v"
`include "alu_control.v"
`include "factorial/rom.v"
`include "register_file.v"
`include "ram.v"
`include "alu.v"
`include "barrel_shifter.v"
`include "parallel_register.v"
`include "universal_shifter.v"
`include "d_flip_flop.v"
`include "down_counter.v"

module testbench;

  reg rst, clk;
  wire z_flag, pcscr, lo_n1;
  wire[31:0] next_address, current_address, instruction, mux_data_in;
  wire[31:0] rs, rt, mux_alu_src, alu_out, barrel_shifter_out, result, mem_out;
  wire[31:0] jump_address, ra_address, branch_address, next_pc;
  wire[31:0] mux_jr, mux_branch_address, mux_jump_address, sll2, s_ext32;
  wire[31:0] hi, lo;
  wire[4:0]  mux_addr_d;
  wire[5:0]  alu_ctrl_word;
  wire[4:0]  shamnt, mult_counter;
  wire[12:0] ctrl_word;
  wire[15:0] imm16;

  control_unit ctrl_unit(instruction[31:26], ctrl_word);


  assign next_pc = current_address + 4;
  assign mux_jr = (alu_ctrl_word[5] == 0) ? next_pc : rs;
  assign pcscr = z_flag & ctrl_word[4] | ~z_flag & ctrl_word[3];
  assign mux_branch_address = (pcscr == 0) ? mux_jr : sll2 + mux_jr;
  assign jump_address = {next_pc[31:28], instruction[25:0], 2'b00};
  assign mux_jump_address = (ctrl_word[12] == 0) ? mux_branch_address 
                          : jump_address;
  
  register pc(mux_jump_address, current_address, alu_ctrl_word[13], rst, clk);

  ROM factorial(current_address, instruction);

  assign result = (alu_ctrl_word[4] == 1'b0) ? alu_out : barrel_shifter_out;
  assign mux_data_in = ({ctrl_word[12], ctrl_word[8]} == 2'b00) ? result 
                     : ({ctrl_word[12], ctrl_word[8]} == 2'b01) ? mem_out
                     : next_pc;
  assign mux_addr_d = (ctrl_word[11:10] == 2'b00) ? instruction[20:16] // rt
                    : (ctrl_word[11:10] == 2'b01) ? instruction[15:11] // rd
                    : 31;                                              // ra
  register_file rf_unit(mux_data_in, rs, rt, 
                         mux_addr_d, instruction[25:21], instruction[20:16], 
                         ctrl_word[7], rst, clk);
  
  alu_control alu_control_unit(ctrl_word[2:0], instruction[5:0], alu_ctrl_word);

  assign imm16 = instruction[15:0];
  assign s_ext32 = (imm16[15]) ? {16'hFFFF, imm16} : {16'h0000, imm16};
  assign sll2 = s_ext32 << 2;
  assign mux_alu_src = (ctrl_word[9] == 0) ? rt : s_ext32;      //alusrc
  alu alu_unit(rs, mux_alu_src, alu_ctrl_word[2:0], z_flag, alu_out);

  // performs arithmetic shift to the right
  universal_shifter hi_sh(alu_out, hi[31], hi, alu_ctrl_word[11:10], rst, clk);
  // performs logic shift to the right
  universal_shifter lo_sh(rt, hi[0], lo, alu_ctrl_word[9:8], rst, clk);
  // This DFF receives the serial output of lo_sh, i.e., lo[-1]
  d_flip_flop lo_drop_bit(lo[0], lo_n1, alu_ctrl_word[7], rst, clk);
  // This module counts from 31 to zero
  down_counter mod_32_counter(mult_counter, alu_ctrl_word[12], rst, clk);

  assign shamnt = instruction[10:6];
  barrel_shifter bsh(alu_out, shamnt, alu_ctrl_word[3], barrel_shifter_out);

  RAM data_memory(rt, mem_out, alu_out[7:0], ctrl_word[5], ctrl_word[6], clk);
  
  always begin
    #1;
    clk = ~clk;
  end

  initial begin
    $dumpfile("mips_factorial.vcd");
    $dumpvars(0, testbench);
    clk = 1;
    rst = 1;
    #2;
    rst = 0;
    while (instruction != 32'h00000000)
      #2;
    $finish;
  end

endmodule