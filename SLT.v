// include and macros for timing
`include "subtractor.v"
`define AND and
`define OR or
`define XOR xor
`define NOT not

module SLT 
(
  output[31:0] res,  // less than
  output carryout,   // Carry out of the summation of a and b
  output overflow,   // True if the calculation resulted in an overflow
  output zeros,
  input[31:0] a,     // First operand in 2's complement format
  input[31:0] b,     // Second operand in 2's complement format
  input carryin      //subtractor option
);
    // Your Code Here
    wire [31:0] diff;
    Subtractor32bit fullSubtractor (diff, carryout, overflow, zeros, a, b, carryin);
    wire lessThan;
    `XOR handleOverflowGate(lessThan, diff[31], overflow);

    genvar i;
    generate
      for (i = 0; i < 32; i = i+1)
        begin:genblock
	  assign res[i] = lessThan;  
        end
    endgenerate
endmodule
