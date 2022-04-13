`ifndef FACTORIAL_ROM_V
`define FACTORIAL_ROM_V

module ROM(
  address,  //32-bit input data address
  instruction //32-bits output data instruction
);

  //input wire [31:0] data_in;
  input  wire[31:0]  address;
  output wire[31:0]  instruction;

 //this rom stores 64 words of 32 bits 
  wire[7:0] m[0:255];

  //rom program 
  assign {m[3],  m[2],  m[1],  m[0]}   = 32'h201d00fc; //addi  $sp, $0, 252
  assign {m[7],  m[6],  m[5],  m[4]}   = 32'hafbe0000; //sw    $fp, 0($sp)
  assign {m[11], m[10], m[9],  m[8]}   = 32'h23bdfffc; //addi  $sp, $sp, -4
  assign {m[15], m[14], m[13], m[12]}  = 32'h001df025; //or    $fp, $0, $sp
  assign {m[19], m[18], m[17], m[16]}  = 32'h23bdfffc; //addi  $sp, $sp, -4
  assign {m[23], m[22], m[21], m[20]}  = 32'h20040006; //addi  $a0, $0, 5 
  assign {m[27], m[26], m[25], m[24]}  = 32'h0c00000c; //jal   factorial
  assign {m[31], m[30], m[29], m[28]}  = 32'h00024025; //or    $t0, $0, $v0
  assign {m[35], m[34], m[33], m[32]}  = 32'hafc8fffc; //sw    $t0, -4($fp)
  assign {m[39], m[38], m[37], m[36]}  = 32'h23bd0008; //addi  $sp, $sp, 8
  assign {m[43], m[42], m[41], m[40]}  = 32'h8fbe0000; //lw    $fp, 0($sp)
  assign {m[47], m[46], m[45], m[44]}  = 32'h00000000; //nop
  assign {m[51], m[50], m[49], m[48]}  = 32'hafbe0000; //sw    $fp, 0($sp)
  assign {m[55], m[54], m[53], m[52]}  = 32'h23bdfffc; //addi  $sp, $sp, -4
  assign {m[59], m[58], m[57], m[56]}  = 32'h001df025; //or    $fp, $0, $sp
  assign {m[63], m[62], m[61], m[60]}  = 32'h23bdfff8; //addi  $sp, $sp, -8
  assign {m[67], m[66], m[65], m[64]}  = 32'hafdf0000; //sw    $ra, 0($fp)
  assign {m[71], m[70], m[69], m[68]}  = 32'hafd0fffc; //sw    $s0, -4($fp)
  assign {m[75], m[74], m[73], m[72]}  = 32'h00048025; //or    $s0, $0, $a0
  assign {m[79], m[78], m[77], m[76]}  = 32'h2201ffff; //addi  $at, $s0, -1
  assign {m[83], m[82], m[81], m[80]}  = 32'h28210001; //slti  $at, $at, 1
  assign {m[87], m[86], m[85], m[84]}  = 32'h14200006; //bne   $at, $0, L1
  assign {m[91], m[90], m[89], m[88]}  = 32'h2204ffff; //addi  $a0, $s0, -1
  assign {m[95], m[94], m[93], m[92]}  = 32'h0c00000c; //jal   factorial
  assign {m[99], m[98], m[97], m[96]}  = 32'h00102025; //or    $a0, $0, $s0
  assign {m[103],m[102],m[101],m[100]} = 32'h00022825; //or    $a1, $0, $v0
  assign {m[107],m[106],m[105],m[104]} = 32'h0c000022; //jal   mult_u
  assign {m[111],m[110],m[109],m[108]} = 32'h0800001d; //j L2
  assign {m[115],m[114],m[113],m[112]} = 32'h20020001; //addi  $v0, $0, 1
  assign {m[119],m[118],m[117],m[116]} = 32'h8fdf0000; //lw    $ra, 0($fp)
  assign {m[123],m[122],m[121],m[120]} = 32'h8fd0fffc; //lw    $s0, -4($fp)
  assign {m[127],m[126],m[125],m[124]} = 32'h23bd000c; //addi  $sp, $sp, 12
  assign {m[131],m[130],m[129],m[128]} = 32'h8fbe0000; //lw    $fp, 0($sp)
  assign {m[135],m[134],m[133],m[132]} = 32'h03e00008; //jr    $ra
  assign {m[139],m[138],m[137],m[136]} = 32'h00004024; //and   $t0, $0, $0
  assign {m[143],m[142],m[141],m[140]} = 32'h00004824; //and   $t1, $0, $0
  assign {m[147],m[146],m[145],m[144]} = 32'h08000027; //j     LF0
  assign {m[151],m[150],m[149],m[148]} = 32'h01044020; //add   $t0, $t0, $a0
  assign {m[155],m[154],m[153],m[152]} = 32'h21290001; //addi  $t1, $t1, 1
  assign {m[159],m[158],m[157],m[156]} = 32'h0125082a; //slt   $at, $t1, $a1
  assign {m[163],m[162],m[161],m[160]} = 32'h1420fffc; //bne   $at, $zero, LF1
  assign {m[167],m[166],m[165],m[164]} = 32'h00081025; //or    $v0, $zero, $t0
  assign {m[171],m[170],m[169],m[168]} = 32'h03e00008; //jr    $ra

  // Fills ROM with nop
  genvar i;
  generate
    for(i=172;i<=255;i=i+4)
      assign {m[i],m[i+1],m[i+2],m[i+3]} = 0;
  endgenerate
 
  assign  instruction[7:0]   = m[address];
  assign  instruction[15:8]  = m[address+1];
  assign  instruction[23:16] = m[address+2];
  assign  instruction[31:24] = m[address+3];  

endmodule

`endif // FACTORIAL_ROM_V