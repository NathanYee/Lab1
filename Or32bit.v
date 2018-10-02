module Or32bit
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
for (i = 0; i < 32; i = i + 1) begin:
    or #30 orgate(result[i], operandA[i], operandB[i]);
end
endgenerate
endmodule
