// include and macros for timing
//`include "subtractor.v"
`define XOR xor #30

module SLT
(
  output[31:0] res,  // less than
  input[31:0] a,     // First operand in 2's complement format
  input[31:0] b,     // Second operand in 2's complement format
  input carryin      //subtractor option
);
    wire carryout;   // Carry out of the summation of a and -b
    wire overflow;   // True if the calculation resulted in an overflow
    wire zeros;
    wire [31:0] diff;
    Subtractor32bit fullSubtractor (diff, carryout, overflow, zeros, a, b, carryin); // Calling subtractor

    // Overflow handling
    wire lessThan;
    `XOR handleOverflowGate(lessThan, diff[31], overflow);

    // Assigning output
    assign res[31:1] = 0;
    assign res[0] = lessThan;

endmodule
