// Loading all submodules
`include "adder.v"
`include "subtractor.v"
`include "Xor32bit.v"
`include "SLT.v"
`include "And32bit.v"
`include "Nand32bit.v"
`include "Nor32bit.v"
`include "Or32bit.v"

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

    wire[31:0] ncommand;
    // Getting inverse of command digits
    genvar i;
    generate
      for (i = 0; i < 3; i = i+1)
        begin:genblock
          not #10 _ncommand(ncommand[i],command[i]);
        end
    endgenerate

    // Wiring intermediate results buses and flags for all ALU functions
    wire[31:0] resultAdd, resultSub, resultXor, resultSLT, resultOr, resultNand,resultNor, resultAnd;
    wire carryoutAdd, overflowAdd, zeroAdd, carryoutSub, overflowSub, zeroSub;
    wire carryoutXor, overflowXor, zeroXor, carryoutSLT, overflowSLT, zeroSLT;
    wire carryoutOr, overflowOr, zeroOr, carryoutNand, overflowNand, zeroNand;
    wire carryoutNor, overflowNor, zeroNor, carryoutAnd, overflowAnd, zeroAnd;

    // Intantiating all ALU submodules to be input into series of MUXs
    FullAdder32bit adder32bit (resultAdd, carryoutAdd, overflowAdd, zeroAdd, operandA, operandB, 1'b0);
    Subtractor32bit sub32 (resultSub, carryoutSub, overflowSub, zeroSub, operandA, operandB, 1'b1);
    Xor32bit xor32 (resultXor, operandA, operandB); assign carryoutXor = 0; assign overflowXor = 0; assign zeroXor = 0; // Where no flags are present in the module, we define flags of zero
    SLT SLT32 (resultSLT, operandA, operandB, 1'b1); assign carryoutSLT = 0; assign overflowSLT = 0; assign zeroSLT = 0;
    And32bit and32 (resultAnd, operandA, operandB); assign carryoutAnd = 0; assign overflowAnd = 0; assign zeroAnd = 0;
    Nand32bit nand32 (resultNand, operandA, operandB); assign carryoutNand = 0; assign overflowNand = 0; assign zeroNand = 0;
    Nor32bit nor32 (resultNor, operandA, operandB); assign carryoutNor = 0; assign overflowNor = 0; assign zeroNor = 0;
    Or32bit or32 (resultOr, operandA,operandB); assign carryoutOr = 0; assign overflowOr = 0; assign zeroOr = 0;

    // 32 MUXs to process each bit in our 32 bit long inputs/outputs
    wire[31:0] outA,outB,outC,outD,outE,outF,outG,outH;
    genvar j;
    generate
      for (j = 0;j < 32; j = j+1)
      begin:genblock0
          and #50 _andgateA(outA[j],resultAdd[j],ncommand[2],ncommand[1],ncommand[0]);
          and #50 _andgateB(outB[j],resultSub[j],ncommand[2],ncommand[1],command[0]);
          and #50 _andgateC(outC[j],resultXor[j],ncommand[2],command[1],ncommand[0]);
          and #50 _andgateD(outD[j],resultSLT[j],ncommand[2],command[1],command[0]);
          and #50 _andgateE(outE[j],resultAnd[j],command[2],ncommand[1],ncommand[0]);
          and #50 _andgateF(outF[j],resultNand[j],command[2],ncommand[1],command[0]);
          and #50 _andgateG(outG[j],resultNor[j],command[2],command[1],ncommand[0]);
          and #50 _andgateH(outH[j],resultOr[j],command[2],command[1],command[0]);
          or #90 (result[j],outA[j],outB[j],outC[j],outD[j],outE[j],outF[j],outG[j],outH[j]); // Assigns output of MUX to 'result' bus
        end
      endgenerate

      //FLAGS

      wire outAover,outBover,outCover,outDover,outEover,outFover,outGover,outHover;
      wire outAcarry,outBcarry,outCcarry,outDcarry,outEcarry,outFcarry,outGcarry,outHcarry;
      wire outAzero,outBzero,outCzero,outDzero,outEzero,outFzero,outGzero,outHzero;

      // 8 input MUX for selecting the correct overflow flag
      and #50 andgateA0(outAover,overflowAdd,ncommand[2],ncommand[1],ncommand[0]);
      and #50 andgateB0(outBover,overflowSub,ncommand[2],ncommand[1],command[0]);
      and #50 andgateC0(outCover,overflowXor,ncommand[2],command[1],ncommand[0]);
      and #50 andgateD0(outDover,overflowSLT,ncommand[2],command[1],command[0]);
      and #50 andgateE0(outEover,overflowAnd,command[2],ncommand[1],ncommand[0]);
      and #50 andgateF0(outFover,overflowNand,command[2],ncommand[1],command[0]);
      and #50 andgateG0(outGover,overflowNor,command[2],command[1],ncommand[0]);
      and #50 andgateH0(outHover,overflowOr,command[2],command[1],command[0]);
      or #90 (overflow,outAover,outBover,outCover,outDover,outEover,outFover,outGover,outHover);

      // 8 input MUX for selecting the correct carryout flag
      and #50 andgateA1(outAcarry,carryoutAdd,ncommand[2],ncommand[1],ncommand[0]);
      and #50 andgateB1(outBcarry,carryoutSub,ncommand[2],ncommand[1],command[0]);
      and #50 andgateC1(outCcarry,carryoutXor,ncommand[2],command[1],ncommand[0]);
      and #50 andgateD1(outDcarry,carryoutSLT,ncommand[2],command[1],command[0]);
      and #50 andgateE1(outEcarry,carryoutAnd,command[2],ncommand[1],ncommand[0]);
      and #50 andgateF1(outFcarry,carryoutNand,command[2],ncommand[1],command[0]);
      and #50 andgateG1(outGcarry,carryoutNor,command[2],command[1],ncommand[0]);
      and #50 andgateH1(outHcarry,carryoutOr,command[2],command[1],command[0]);
      or #90 (carryout,outAcarry,outBcarry,outCcarry,outDcarry,outEcarry,outFcarry,outGcarry,outHcarry);

      //8 input MUX for selecting the correct zero flag
      and #50 andgateA2(outAzero,zeroAdd,ncommand[2],ncommand[1],ncommand[0]);
      and #50 andgateB2(outBzero,zeroSub,ncommand[2],ncommand[1],command[0]);
      and #50 andgateC2(outCzero,zeroXor,ncommand[2],command[1],ncommand[0]);
      and #50 andgateD2(outDzero,zeroSLT,ncommand[2],command[1],command[0]);
      and #50 andgateE2(outEzero,zeroAnd,command[2],ncommand[1],ncommand[0]);
      and #50 andgateF2(outFzero,zeroNand,command[2],ncommand[1],command[0]);
      and #50 andgateG2(outGzero,zeroNor,command[2],command[1],ncommand[0]);
      and #50 andgateH2(outHzero,zeroOr,command[2],command[1],command[0]);
      or #90 (zero,outAzero,outBzero,outCzero,outDzero,outEzero,outFzero,outGzero,outHzero);


  endmodule
