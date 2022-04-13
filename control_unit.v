`ifndef Control_Unit_V
`define Control_Unit_V
/** @brief asfasdfasf */
module control_unit(
  op_code,            // bit [31:26] from an MIPS instructions
  control_word        // 13 bit word
);

  input  wire[5:0]  op_code;
  output reg [12:0]  control_word;
  // jump      [12]
  // regdest   [11:10] ($ra or rd)
  // alusrc    [9]
  // memtoreg  [8]
  // regwrite  [7]
  // memread   [6]
  // memwrite  [5]
  // beq       [4]
  // bne       [3]
  // aluop     [2:0]

  always @(*)begin
    case(op_code)
      6'h0  : control_word  = 13'b0_01_0_0_1_0_0_0_0_010; // R-type instructions
      6'h2  : control_word  = 13'b1_00_0_0_0_0_0_0_0_011; // jump
      6'h3  : control_word  = 13'b1_10_0_0_1_0_0_0_0_011; // jump and link
      6'h4  : control_word  = 13'b0_00_0_0_0_0_0_1_0_001; // branch equal
      6'h5  : control_word  = 13'b0_00_0_0_0_0_0_0_1_001; // branch not equal
      6'h8  : control_word  = 13'b0_00_1_0_1_0_0_0_0_100; // add immediate
      6'hA  : control_word  = 13'b0_00_1_0_1_0_0_0_0_111; // slt immediate
      6'hC  : control_word  = 13'b0_00_1_0_1_0_0_0_0_101; // and immediate
      6'hD  : control_word  = 13'b0_00_1_0_1_0_0_0_0_110; // ori immediate
      6'h23 : control_word  = 13'b0_00_1_1_1_1_0_0_0_000; // load Word
      6'h2B : control_word  = 13'b0_00_1_0_0_0_1_0_0_000; // store Word
      default: control_word = 0;
    endcase
  end

endmodule

`endif // Control_Unit_V