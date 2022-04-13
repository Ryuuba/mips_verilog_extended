`ifndef RAM_V
`define RAM_V

module RAM(
  data_in,  //32-bit input data
  data_out, //32-bits output data
  address,  //8-bit address port
  write,    //write control signal
  cs,       //read control signal (chip select)
  clk       //clock signal
);

  input  wire write, cs, clk;
  input  wire[31:0] data_in;
  input  wire[ 7:0] address;
  output wire[31:0] data_out;
  //this ram stores 64 words of 32 bits
  reg[7:0] memory[0:255];

  always@(posedge clk) begin
    if (write) begin //Synchronous writing
      memory[address+3] = data_in[31:24];
      memory[address+2] = data_in[23:16];
      memory[address+1] = data_in[15: 8];
      memory[address]   = data_in[ 7: 0];
      $display(
        "sw\t%d\t->\tRAM[%d]",
        { memory[address+3], 
          memory[address+2], 
          memory[address+1], 
          memory[address]
        },
        address
      );
    end
    if (cs) begin //Synchronous writing
      $display(
        "lw\t%d\t<-\tRAM[%d]", 
        { memory[address+3], 
          memory[address+2], 
          memory[address+1], 
          memory[address]
        },
        address
      );
    end
  end

  //Asynchronous reading
  assign data_out[31:24] = (cs) ? memory[address+3] : 'bz;
  assign data_out[23:16] = (cs) ? memory[address+2] : 'bz;
  assign data_out[15: 8] = (cs) ? memory[address+1] : 'bz;
  assign data_out[ 7: 0] = (cs) ? memory[address]   : 'bz;

  // This initial block initializes the memory with the data stored in a program
  // Note that this kind of memory is only used to testbench a processor. It's 
  // recommendable you utilize the memory embebbed in your FPGA board.
  // initial begin
  //   //$readmemb(filename, mem_array, start_addr, stop_addr);
  //   //The last two value are optional arguments
  //   $readmemh("./data_program.hex", memory, 0, 255);//maximum program is loaded
  // end

endmodule

`endif