// Adder testbench
`timescale 1 ns / 1 ps
`include "alu.v"


module aluMod();
    wire[31:0]  result;
    wire        carryout;
    wire        zero;
    wire        overflow;
    reg[31:0]   operandA;
    reg[31:0]   operandB;
    reg[2:0]    command;

    ALU alu32bit (result, carryout, zero, overflow, operandA, operandB, command);


    initial begin
    $dumpfile("alu.vcd");
    $dumpvars;

    operandA = 32'b00000000000000000000000000000000; operandB = 32'b00000000000000000000000000000000; command = 3'b000; #1000
    $display("%b",carryout);
    if((result !== 32'b00000000000000110101101101100000) || (overflow !== 0) || (carryout !== 0) || (zero !== 0)) begin
      $display("%b                                %b        %b        %b    | 00000000000000110101101101100000 0         0         0",result,overflow,carryout,zero);
    end
    operandA = 32'b00000000000000000000000000000000; operandB = 32'b00000000000000000000000000000000; command = 3'b000; #1000
    if((result !== 32'b10010100101101100010111000000000) || (overflow !== 0) || (carryout !== 1) || (zero !== 0)) begin
      $display("%b                                %b        %b        %b    | 10010100101101100010111000000000 0         1         0",result,overflow,carryout,zero);
    end
    operandA = 32'b00000000000000000000000000000001; operandB = 32'b00000000000000000000000000000000; command = 3'b001; #1000
    if((result !== 32'b00000000000000101011111100100000) || (overflow !== 0) || (carryout !== 0) || (zero !== 0)) begin
      $display("%b                                %b        %b        %b    | 00000000000000101011111100100000 0         0         0",result,overflow,carryout,zero);
    end
    operandA = 32'b00000000000000000000000000000001; operandB = 32'b00000000000000000000000000000000; command = 3'b001; #1000
    if((result !== 32'b10000011001000010101011000000000) || (overflow !== 1) || (carryout !== 0) || (zero !== 0)) begin
      $display("%b                                %b        %b        %b    | 10000011001000010101011000000000 1         0         0",result,overflow,carryout,zero);
    end
    operandA = 32'b00000000000000000000000000000001; operandB = 32'b00000000000000000000000000000000; command = 3'b001; #1000
    if((result !== 32'b00000000000000000000000000000000) || (overflow !== 0) || (carryout !== 0) || (zero !== 1)) begin
      $display("%b                                %b        %b        %b    | 00000000000000000000000000000000 0         0         1",result,overflow,carryout,zero);
    end
    operandA = 32'b00000000000000000000000000001010; operandB = 32'b00000000000000000000001111101001; command = 3'b010; #1000
    if((result !== 32'b00000000000000000000000000001001) || (overflow !== 0) || (carryout !== 0) || (zero !== 0)) begin
      $display("%b                                %b        %b        %b    | 00000000000000000000000000001001 0         0         0",result,overflow,carryout,zero);
    end
    operandA = 32'b00000000000000000000000000001011; operandB = 32'b00000000000000000000000000000000; command = 3'b011; #1000
    if((result !== 32'b00000000000000000000000000000000) || (overflow !== 0) || (carryout !== 0) || (zero !== 0)) begin
      $display("%b                                %b        %b        %b    | 00000000000000000000000000000000 0         0         0",result,overflow,carryout,zero);
    end
    operandA = 32'b00000000000000000000000001100100; operandB = 32'b00000000000000000000000000000001; command = 3'b100; #1000
    if((result !== 32'b00000000000000000000000000000001) || (overflow !== 0) || (carryout !== 0) || (zero !== 0)) begin
      $display("%b                                %b        %b        %b    | 00000000000000000000000000000001 0         0         0",result,overflow,carryout,zero);
    end
    operandA = 32'b00000000000000000000000001100101; operandB = 32'b00000000000000000000010001010110; command = 3'b101; #1000
    if((result !== 32'b00000000000000000000000000001110) || (overflow !== 0) || (carryout !== 0) || (zero !== 0)) begin
      $display("%b                                %b        %b        %b    | 00000000000000000000000000001110 0         0         0",result,overflow,carryout,zero);
    end
    operandA = 32'b00000000000000000000000001101110; operandB = 32'b00000000000000000000001111101000; command = 3'b110; #1000
    if((result !== 32'b00000000000000000000000000001000) || (overflow !== 0) || (carryout !== 0) || (zero !== 0)) begin
      $display("%b                                %b        %b        %b    | 00000000000000000000000000001000 0         0         0",result,overflow,carryout,zero);
    end
    operandA = 32'b00000000000000000000000001101111; operandB = 32'b00000000000000000000000001101111; command = 3'b111; #1000
    if((result !== 32'b00000000000000000000000000000111) || (overflow !== 0) || (carryout !== 0) || (zero !== 0)) begin
      $display("%b                                %b        %b        %b    | 00000000000000000000000000000111 0         0         0",result,overflow,carryout,zero);
    end
end
endmodule
