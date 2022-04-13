`ifndef ALU_CONTROL_V
`define ALU_CONTROL_V

module alu_control(
  input  wire[2:0]  mulst,          // msts
  input  wire[2:0]  alu_op,         // instruction kind
  input  wire[5:0]  funct,          // Field from R-type mips instructions
  output reg [17:0] alu_cwd         // 17-bit control word
);

  /** Bit description of the alu control word 
    * [0:2] ALU's selector
    * [3] controls the barrel shifter
    * [5:4] control the mux result
    * [6] selects hi as ALU's 2nd operand
    * [8:7] controls DFF storing lo[-1]
    * [11:9] controls the lo universal shifter 
    * [14:12] controls the hi universal shifter 
    * [15] controls the modulus-32 down counter
    * [16] enables the program counter to be written
    **/

  wire[16:0] mult_cwd;

  always@(*) begin
    case(alu_op)
      0: alu_cwd = 17'b1000000000000010;                        // lw or sw
      1: alu_cwd = 17'b1000000000000110;                        // beq or bne
      2: alu_cwd = (funct == 'h20) ? 17'b1000000000000010 :     // add
                   (funct == 'h22) ? 17'b1000000000000110 :     // sub
                   (funct == 'h24) ? 17'b1000000000000000 :     // and
                   (funct == 'h25) ? 17'b1000000000000001 :     // or
                   (funct == 'h2A) ? 17'b1000000000000111 :     // slt
                   (funct == 'h00) ? 17'b1000000000110001 :     // sll
                   (funct == 'h02) ? 17'b1000000000111001 :     // srl
                   (funct == 'h18) ? mul_cwd                    // mul
                   (funct == 'h10) ? 17'b1000000000010000 :     // mfhi
                   (funct == 'h12) ? 17'b1000000000100000 :     // mflo
                   (funct == 'h08) ? 17'b1000000000100000 : 0;  // jr
       3: alu_cwd = 17'b1000000000000001;                       // jal?
       4: alu_cwd = 17'b1000000000000010;                       // addi  
       5: alu_cwd = 17'b1000000000000000;                       // andi
       6: alu_cwd = 17'b1000000000000001;                       // ori 
      default:
          alu_cwd = 17'b1000000000000111;                       // slti
    endcase
  end

endmodule

`endif