module Nor32bit
(
output[31:0]  result,
input[31:0]   operandA,
input[31:0]   operandB
);

genvar i;
generate
for (i = 0; i < 32; i = i + 1)
begin:genblock
    Nor #20 _norgate(result[i], operandA[i], operandB[i]);
end
endgenerate
endmodule
