// ALU testbench
`timescale 1 ns / 1 ps
`include "alu.v"

// Testing full ALU
module aluMod();
    wire[31:0]  result;
    wire        carryout;
    wire        zero;
    wire        overflow;
    reg[31:0]   operandA;
    reg[31:0]   operandB;
    reg[2:0]    command;

    //Instantiating ALU
    ALU alu32bit (result, carryout, zero, overflow, operandA, operandB, command);


    initial begin
    $dumpfile("alu.vcd");   //Creating .vcd file for timing analysis
    $dumpvars;
    $display("result                           overflow carryout zero | Eresult                          Eoverflow Ecarryout Ezero");
    operandA = 32'b00000000000000110000110101000000; operandB = 32'b00000000000000000100111000100000; command = 3'b000; #3000
    if((result !== 32'b00000000000000110101101101100000) || (overflow !== 0) || (carryout !== 0) || (zero !== 0)) begin
      $display("%b                                %b        %b        %b    | 00000000000000110101101101100000 0         0         0",result,overflow,carryout,zero);
    end
    operandA = 32'b00001011111010111100001000000000; operandB = 32'b10001000110010100110110000000000; command = 3'b000; #3000
    if((result !== 32'b10010100101101100010111000000000) || (overflow !== 0) || (carryout !== 0) || (zero !== 0)) begin
      $display("%b                                %b        %b        %b    | 10010100101101100010111000000000 0         0         0",result,overflow,carryout,zero);
    end
    operandA = 32'b00000000000000110000110101000000; operandB = 32'b00000000000000000100111000100000; command = 3'b001; #3000
    if((result !== 32'b00000000000000101011111100100000) || (overflow !== 0) || (carryout !== 1) || (zero !== 0)) begin
      $display("%b                                %b        %b        %b    | 00000000000000101011111100100000 0         1         0",result,overflow,carryout,zero);
    end
    operandA = 32'b00001011111010111100001000000000; operandB = 32'b10001000110010100110110000000000; command = 3'b001; #3000
    if((result !== 32'b10000011001000010101011000000000) || (overflow !== 1) || (carryout !== 0) || (zero !== 0)) begin
      $display("%b                                %b        %b        %b    | 10000011001000010101011000000000 1         0         0",result,overflow,carryout,zero);
    end
    operandA = 32'b00000000000000011000011010100000; operandB = 32'b00000000000000011000011010100000; command = 3'b001; #3000
    if((result !== 32'b00000000000000000000000000000000) || (overflow !== 0) || (carryout !== 1) || (zero !== 1)) begin
      $display("%b                                %b        %b        %b    | 00000000000000000000000000000000 0         1         1",result,overflow,carryout,zero);
    end
    operandA = 32'b00000000000000000000000000000011; operandB = 32'b00000000000000000000000000000101; command = 3'b010; #3000
    if((result !== 32'b00000000000000000000000000000110) || (overflow !== 0) || (carryout !== 0) || (zero !== 0)) begin
      $display("%b                                %b        %b        %b    | 00000000000000000000000000000110 0         0         0",result,overflow,carryout,zero);
    end
    operandA = 32'b00000000000000000000000000000011; operandB = 32'b00000000000000000000000000000101; command = 3'b011; #3000
    if((result !== 32'b00000000000000000000000000000001) || (overflow !== 0) || (carryout !== 0) || (zero !== 0)) begin
      $display("%b                                %b        %b        %b    | 00000000000000000000000000000001 0         0         0",result,overflow,carryout,zero);
    end
    operandA = 32'b00000000000000000000000000000011; operandB = 32'b00000000000000000000000000000101; command = 3'b100; #3000
    if((result !== 32'b00000000000000000000000000000001) || (overflow !== 0) || (carryout !== 0) || (zero !== 0)) begin
      $display("%b                                %b        %b        %b    | 00000000000000000000000000000001 0         0         0",result,overflow,carryout,zero);
    end
    operandA = 32'b00000000000000000000000000000011; operandB = 32'b00000000000000000000000000000101; command = 3'b101; #3000
    if((result !== 32'b11111111111111111111111111111110) || (overflow !== 0) || (carryout !== 0) || (zero !== 0)) begin
      $display("%b                                %b        %b        %b    | 11111111111111111111111111111110 0         0         0",result,overflow,carryout,zero);
    end
    operandA = 32'b00000000000000000000000000000011; operandB = 32'b00000000000000000000000000000101; command = 3'b110; #3000
    if((result !== 32'b11111111111111111111111111111000) || (overflow !== 0) || (carryout !== 0) || (zero !== 0)) begin
      $display("%b                                %b        %b        %b    | 11111111111111111111111111111000 0         0         0",result,overflow,carryout,zero);
    end
    operandA = 32'b00000000000000000000000000000011; operandB = 32'b00000000000000000000000000000101; command = 3'b111; #3000
    if((result !== 32'b00000000000000000000000000000111) || (overflow !== 0) || (carryout !== 0) || (zero !== 0)) begin
      $display("%b                                %b        %b        %b    | 00000000000000000000000000000111 0         0         0",result,overflow,carryout,zero);
    end
    end
endmodule
