`ifndef ROM_V
`define ROM_V

module ROM(
  address,  //32-bit input data address
  instruction //32-bits output data instruction
);

  //input wire [31:0] data_in;
  input  wire[31:0]  address;
  output wire[31:0]  instruction;

 //this rom stores 32 words of 32 bits 
  wire[7:0] rom[0:127];

  //rom program 
  assign {rom[3],rom[2],rom[1],rom[0]}     = 32'h8c040000; //lw $a0, 0($zero)
  assign {rom[7],rom[6],rom[5],rom[4]}     = 32'h8c050004; //lw $a1, 4($zero)
  assign {rom[11],rom[10],rom[9],rom[8]}   = 32'h8c060008; //lw $a2, 8($zero)
  assign {rom[15],rom[14],rom[13],rom[12]} = 32'h0c000006; //jal count
  assign {rom[19],rom[18],rom[17],rom[16]} = 32'hac02000C; //sw $v0, 8($zero)
  assign {rom[23],rom[22],rom[21],rom[20]} = 32'h08000017; //j 17
  assign {rom[27],rom[26],rom[25],rom[24]} = 32'h00008824; //and $s1, $zero,$zero
  assign {rom[31],rom[30],rom[29],rom[28]} = 32'h00004824; //and $t1, $zero,$zero
  assign {rom[35],rom[34],rom[33],rom[32]} = 32'h08000013; //j LF
  assign {rom[39],rom[38],rom[37],rom[36]} = 32'h00099880; //sll $s3, $t1, 2
  assign {rom[43],rom[42],rom[41],rom[40]} = 32'h0093a020; //add $s4, $a0, $s3
  assign {rom[47],rom[46],rom[45],rom[44]} = 32'h8e8a0000; //lw $t2, ($s4)
  assign {rom[51],rom[50],rom[49],rom[48]} = 32'h0800000e; //j modulo
  assign {rom[55],rom[54],rom[53],rom[52]} = 32'h01465022; //sub $t2, $t2, $a2
  assign {rom[59],rom[58],rom[57],rom[56]} = 32'h0146082a; //slt $at, $t2, $a2
  assign {rom[63],rom[62],rom[61],rom[60]} = 32'h1020fffd; //beq $at, $zero, resta
  assign {rom[67],rom[66],rom[65],rom[64]} = 32'h15400001; //bne $t2,$zero,LB
  assign {rom[71],rom[70],rom[69],rom[68]} = 32'h22310001; //addi $s1,$s1,1
  assign {rom[75],rom[74],rom[73],rom[72]} = 32'h21290001; //addi $t1,$t1,1
  assign {rom[79],rom[78],rom[77],rom[76]} = 32'h0125082a; //slt $at, $t1, $a1
  assign {rom[83],rom[82],rom[81],rom[80]} = 32'h1420fff4; //bne $at, $zero, LA
  assign {rom[87],rom[86],rom[85],rom[84]} = 32'h00111025; //or $v0,$zero,$s1
  assign {rom[91],rom[90],rom[89],rom[88]} = 32'h03e00008; //jr $ra

  genvar i;
  generate
    for(i=92;i<=127;i=i+4)
      assign {rom[i],rom[i+1],rom[i+2],rom[i+3]} = 0;
  endgenerate
 
  assign  instruction[7:0]   = rom[address];
  assign  instruction[15:8]  = rom[address+1];
  assign  instruction[23:16] = rom[address+2];
  assign  instruction[31:24] = rom[address+3];  

endmodule

`endif