`timescale 1 ns / 1 ps
`include "adder.v"
`include "subtractor.v"
`include "Xor32bit.v"
`include "SLT.v"
`include "And32bit.v"
`include "Nand32bit.v"
`include "Nor32bit.v"
`include "Or32bit.v"

`define ADD  3'b000
`define SUB  3'b001
`define XOR  3'b010
`define SLT  3'b011
`define AND  3'b100
`define NAND 3'b101
`define NOR  3'b110
`define OR   3'b111

module ALU
    (
      output[31:0]  result,
      output        carryout,
      output        zero,
      output        overflow,
      input[31:0]   operandA,
      input[31:0]   operandB,
      input[2:0]    command
    );
    genvar i;
    generate
      for (i = 0; i < 3; i = i+1)
        begin:genblock
          not #10 _ncommand(ncommand[i],command[i]);
        end
    endgenerate

//generate
//    FullAdder32bit adder32bit (result, carryout, overflow, zero, operandA, operandB, 0);
//    genvar l;
//    generate
//      for (l = 0; l < 32; l = l+1)
//        begin:genblock
//          and #50 _andgate(and0[l],ncommand[0],ncommand[1],ncommand[2],result[l]);
//        end
//    endgenerate
//    Subtractor32bit sub32 (result, carryout, overflow, zero, operandA, operandB, 1);
//    genvar m;
//    generate
//      for (m = 0; m < 32; m = m+1)
//        begin:genblock
//          and #50 _andgate(and1[m],command[0],ncommand[1],ncommand[2],result[m]);
//        end
//    endgenerate
//    Xor32bit xor32 (result, operandA, operandB); carryout = 0; overflow = 0; zero = 0;
//    genvar n;
//    generate
//      for (n = 0; n < 32; n = n+1)
//        begin:genblock
//          and #50 _andgate(and2[n],ncommand[0],command[1],ncommand[2],result[n]);
//        end
//    endgenerate
//    SLT SLT32 (result, a, b, 1); carryout = 0; overflow = 0; zero = 0;
//    genvar o;
//    generate
//      for (o = 0; o < 32; o = o+1)
//        begin:genblock
//          and #50 _andgate(and3[o],command[0],command[1],ncommand[2],result[o]);
//        end
//    endgenerate
//    And32bit and32 (result, operandA, operandB); carryout = 0; overflow = 0; zero = 0;
//    genvar p;
//    generate
//      for (p = 0; p < 32; p = p+1)
//        begin:genblock
//          and #50 _andgate(and4[p],ncommand[0],ncommand[1],command[2],result[p]);
//        end
//    endgenerate
//    Nand32bit nand32 (result, operandA, operandB); carryout = 0; overflow = 0; zero = 0;
//    genvar q;
//    generate
//      for (q = 0; q < 32; q = q+1)
//        begin:genblock
//          and #50 _andgate(and5[q],command[0],ncommand[1],command[2],result[q]);
//        end
//    endgenerate
//    Nor32bit nor32 (result, operandA, operandB); carryout = 0; overflow = 0; zero = 0;
//    genvar r;
//    generate
//      for (r = 0; r < 32; r = r+1)
//        begin:genblock
//          and #50 _andgate(and6[r],ncommand[0],command[1],command[2],result[r]);
//        end
//    endgenerate
//    Or32bit or32 (result, operandA,operandB); carryout = 0; overflow = 0; zero = 0;
//    genvar s;
//    generate
//      for (s = 0; s < 32; s = s+1)
//        begin:genblock
//          and #50 _andgate(and7[s],command[0],command[1],command[2],result[s]);
//        end
//    endgenerate
//    genvar t;
//    generate
//      for (t = 0; t < 32; t = t + 1)
//          or #90 finalorgate(result[t],and0[k]);
//      end
//    endgenerate
//endgenerate



    //always @(command) begin
    //    case (command)
    //      `ADD:  begin FullAdder32bit adder32bit (result, carryout, overflow, zero, operandA, operandB, 0); end
    //      `SUB:  begin Subtractor32bit sub32 (result, carryout, overflow, zero, operandA, operandB, 1); end
    //      `XOR:  begin Xor32bit xor32 (result, operandA, operandB); carryout = 0; overflow = 0; zero = 0;  end
    //      `SLT:  begin SLT SLT32 (result, a, b, 1); carryout = 0; overflow = 0; zero = 0; end
    //      `AND:  begin And32bit and32 (result, operandA, operandB); carryout = 0; overflow = 0; zero = 0; end
    //      `NAND: begin Nand32bit nand32 (result, operandA, operandB); carryout = 0; overflow = 0; zero = 0; end
    //      `NOR:  begin Nor32bit nor32 (result, operandA, operandB); carryout = 0; overflow = 0; zero = 0; end
    //      `OR:   begin Or32bit or32 (result, operandA,operandB); carryout = 0; overflow = 0; zero = 0; end
    //    endcase
    //end
endmodule
