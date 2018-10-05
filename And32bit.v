module And32bit
  (
  output[31:0]  result,
  input[31:0]   operandA,
  input[31:0]   operandB
  );

  // Looping through 32 bit operands to generate result of AND
  genvar i;
  generate
    for (i = 0; i < 32; i = i + 1)
    begin:genblock
        and #30 _andgate(result[i], operandA[i], operandB[i]);
    end
  endgenerate

endmodule
