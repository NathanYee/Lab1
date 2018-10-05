// include and macros for timing
//`include "adder.v"
`define NOT not #10

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
    wire[31:0] invertedB;

    // Inverting input b so that an adder module can be used for subtractor
    genvar i;
    generate
      for (i = 0; i < 32; i = i+1)
        begin:genblock
	  `NOT _invertBGate(invertedB[i], b[i]);
        end
    endgenerate

    // Calling Adder: Note: Carryin must be 1 for inversion to result in 2s compliment inversion
    FullAdder32bit fulladder (diff, carryout, overflow, zeros, a, invertedB, carryin);
endmodule
