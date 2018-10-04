module Nand32bit
(
output[31:0]  result,
input[31:0]   operandA,
input[31:0]   operandB
);

genvar i;
generate
for (i = 0; i < 32; i = i + 1)
begin:genblock
    nand #20 _nandgate(result[i], operandA[i], operandB[i]);
end
endgenerate
endmodule
