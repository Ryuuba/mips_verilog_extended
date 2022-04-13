`ifndef ROM_V
`define ROM_V


module ROM(
  address,  //32-bit input data address
  instruction //32-bits output data instruction
);

//input wire [31:0] data_in;
input  wire[31:0]  address;
output wire [31:0]  instruction;


 //this rom stores 64 words of 32 bits 
wire[7:0] rom[0:127];

//rom program 
assign rom [0]=8'h3c;    assign rom [1]=8'h01;    assign rom [2]= 8'h10;   assign rom [3]=8'h01;
assign rom [4]=8'h34;    assign rom [5]=8'h24;    assign rom [6]= 8'h00;   assign rom [7]=8'h0c;
assign rom [8]=8'h3c;    assign rom [9]=8'h01;    assign rom [10]=8'h10;   assign rom [11]=8'h01;
assign rom [12]=8'h8c;   assign rom [13]=8'h25;   assign rom [14]=8'h00;   assign rom [15]=8'h00;
assign rom [16]=8'h3c;   assign rom [17]=8'h01;   assign rom [18]=8'h10;   assign rom [19]=8'h01;
assign rom [20]=8'h8c;   assign rom [21]=8'h26;   assign rom [22]=8'h00;   assign rom [23]=8'h04;
assign rom [24]=8'h0c;   assign rom [25]=8'h10;   assign rom [26]=8'h00;   assign rom [27]=8'h0b;
assign rom [28]=8'h3c;   assign rom [29]=8'h01;   assign rom [30]=8'h10;   assign rom [31]=8'h01;
assign rom [32]=8'hac;   assign rom [33]=8'h22;   assign rom [34]=8'h00;   assign rom [35]=8'h08;
assign rom [36]=8'h34;   assign rom [37]=8'h02;   assign rom [38]=8'h00;   assign rom [39]=8'h0a;
assign rom [40]=8'h00;   assign rom [41]=8'h00;   assign rom [42]=8'h00;   assign rom [43]=8'h0c;
assign rom [44]=8'h00;   assign rom [45]=8'h00;   assign rom [46]=8'h88;   assign rom [47]=8'h24;
assign rom [48]=8'h00;   assign rom [49]=8'h00;   assign rom [50]=8'h48;   assign rom [51]=8'h24;
assign rom [52]=8'h08;   assign rom [53]=8'h10;   assign rom [54]=8'h00;   assign rom [55]=8'h18;
assign rom [56]=8'h00;   assign rom [57]=8'h09;   assign rom [58]=8'h98;   assign rom [59]=8'h80;
assign rom [60]=8'h00;   assign rom [61]=8'h93;   assign rom [62]=8'ha0;   assign rom [63]=8'h20;
assign rom [64]=8'h8e;   assign rom [65]=8'h8a;   assign rom [66]=8'h00;   assign rom [67]=8'h00;
assign rom [68]=8'h08;   assign rom [69]=8'h10;   assign rom [70]=8'h00;   assign rom [71]=8'h13;
assign rom [72]=8'h01;   assign rom [73]=8'h46;   assign rom [74]=8'h50;   assign rom [75]=8'h22;
assign rom [76]=8'h01;   assign rom [77]=8'h46;   assign rom [78]=8'h08;   assign rom [79]=8'h2a;
assign rom [80]=8'h10;   assign rom [81]=8'h20;   assign rom [82]=8'hff;   assign rom [83]=8'hfd;
assign rom [84]=8'h15;   assign rom [85]=8'h40;   assign rom [86]=8'h00;   assign rom [87]=8'h01;
assign rom [88]=8'h22;   assign rom [89]=8'h31;   assign rom [90]=8'h00;   assign rom [91]=8'h01;
assign rom [92]=8'h21;   assign rom [93]=8'h29;   assign rom [94]=8'h00;   assign rom [95]=8'h01;
assign rom [96]=8'h01;   assign rom [97]=8'h25;   assign rom [98]=8'h08;   assign rom [99]=8'h2a;
assign rom [100]=8'h14;  assign rom [101]=8'h20;  assign rom [102]=8'hff;  assign rom [103]=8'hf4;
assign rom [104]=8'h00;  assign rom [105]=8'h11;  assign rom [106]=8'h10;  assign rom [107]=8'h25;
assign rom [108]=8'h03;  assign rom [109]=8'he0;  assign rom [110]=8'h00;  assign rom [111]=8'h08;

genvar i;
generate
  for(i=112;i<=127;i=i+4)
    assign {rom[i],rom[i+1],rom[i+2],rom[i+3]}=0;
endgenerate
 
  //Asynchronous reading
  //always @ (*) begin
    assign  instruction[31:24] = rom[address];
    assign  instruction[23:16] = rom[address+1];
    assign  instruction[15: 8] = rom[address+2];
    assign  instruction[ 7: 0] = rom[address+3];  
//  end


endmodule

`endif