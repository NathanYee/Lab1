// Adder circuit
`define AND and #50
`define OR or #50
`define XOR xor #50
`define NOT not #50

module structuralFullAdder
(
    output sum,
    output carryout,
    input a,
    input b,
    input carryin

);
    wire xor0, and0, and1;
    // Single bit adder with carryin / carryout
    `XOR xor0gate(xor0,a,b);
    `AND and0gate(and0,a,b);
    `XOR sumgate(sum,xor0,carryin);
    `AND and1gate(and1,xor0,carryin);
    `OR orgate(carryout,and0,and1);
endmodule

module FullAdder4bit
(
  output[31:0] sum,  // 2's complement sum of a and b
  output carryout,  // Carry out of the summation of a and b
  output overflow,  // True if the calculation resulted in an overflow
  input[31:0] a,     // First operand in 2's complement format
  input[31:0] b,      // Second operand in 2's complement format
  input carryin       //subtractor option
);
    // Your Code Here
    wire[31:0] carryout0;

    genvar i;
    generate
      structuralFullAdder _adder (sum[0], carryout0[0], a[0], b[0], carryin);
      for (i = 1; i < 32; i = i+1)
        begin:genblock
          structuralFullAdder _adder (sum[i],carryout0[i], a[i], b[i],carryout0[i-1]);
        end
    endgenerate
    wire negand, posand, a3inv, b3inv, s3inv;
    `NOT a3inv(a3inv, a[31]);
    `NOT b3inv(b3inv, b[31]);
    `NOT s3inv(s3inv, sum[31]);
    `AND posand(posand, a3inv, b3inv, carryout0[30]);
    `AND negand(negand, a[31], b[31], s3inv);
    `OR overflowgate(overflow, posand, negand);

endmodule
