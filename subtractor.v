// include and macros for timing
`include "adder.v"
`define AND and
`define OR or
`define XOR xor
`define NOT not

module Subtractor32bit 
(
  output[31:0] diff,  // 2's complement difference of a and b
  output carryout,    // Carry out of the summation of a and b
  output overflow,    // True if the calculation resulted in an overflow
  output zeros,
  input[31:0] a,      // First operand in 2's complement format
  input[31:0] b,      // Second operand in 2's complement format
  input carryin       //subtractor option
);
    // Your Code Here
    wire[31:0] invertedB;

    genvar i;
    generate
      for (i = 0; i < 32; i = i+1)
        begin:genblock
	  `NOT _invertBGate(invertedB[i], b[i]);
        end
    endgenerate

    FullAdder4bit fulladder (diff, carryout, overflow, zeros, a, invertedB, carryin);  //TODO: should change adder name to 32bit
endmodule
