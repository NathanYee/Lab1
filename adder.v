// Adder circuit
`define AND and
`define OR or
`define XOR xor
`define NOT not

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
  output zeros,
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
    assign carryout = carryout0[31];
    wire negand, posand, a3inv, b3inv, s3inv,one;
    //wire[31:0] sInv;
    `NOT a3inv(a3inv, a[31]);
    `NOT b3inv(b3inv, b[31]);
    `NOT s3inv(s3inv, sum[31]);
    `AND posand(posand, a3inv, b3inv, carryout0[30]);
    `AND negand(negand, a[31], b[31], s3inv);
    `OR overflowgate(overflow, posand, negand);
    `OR zeroGate(one, sum[0],sum[1],sum[2],sum[3],sum[4],sum[5],sum[6],sum[7],sum[8],sum[9],sum[10],sum[11],sum[12],sum[13],sum[14],sum[15],sum[16],sum[17],sum[18],sum[19],sum[20],sum[21],sum[22],sum[23],sum[24],sum[25],sum[26],sum[27],sum[28],sum[29],sum[30],sum[31]);
    `NOT one2zero(zeros,one);


endmodule
