// Adder testbench
`timescale 1 ns / 1 ps
`include "adder.v"

module testFullAdder();
    reg [31:0] a, b;
    reg carryin;
    wire [31:0] result;
    wire carryout, overflow;
    reg zero;

    FullAdder4bit fulladder (result, carryout, overflow, a, b,carryin);

    initial begin
    $dumpfile("adder.vcd");
    $dumpvars;
carryin = 0;
zero = 0;
$display("operandA operandB | result overflow carryout zero");
a = 32'b01111111111111111111111111111111; b = 32'b00000000000000000000000000000001; #1000
if((result !== 32'b10000000000000000000000000000000) || (overflow !== 1) || (carryout !== 0) || (zero !== 0)) begin
  $display("%b        %b      %b |        10000000000000000000000000000000 1        0        0",result,overflow, carryout);
end
a = 32'b00000000000000000000000000000101; b = 32'b00000000000000000000000000001010; #1000
if((result !== 32'b00000000000000000000000000001111) || (overflow !== 0) || (carryout !== 0) || (zero !== 0)) begin
  $display("%b        %b      %b |        00000000000000000000000000001111 0        0        0",result,overflow, carryout);
end
a = 32'b10000000000000000000000000000000; b = 32'b10000000000000000000000000000000; #1000
if((result !== 32'b00000000000000000000000000000000) || (overflow !== 1) || (carryout !== 1) || (zero !== 1)) begin
  $display("%b        %b      %b |        00000000000000000000000000000000 1        1        1",result,overflow, carryout);
end
a = 32'b10001000110010100110110000000000; b = 32'b00001011111010111100001000000000; #1000
if((result !== 32'b10010100101101100010111000000000) || (overflow !== 0) || (carryout !== 0) || (zero !== 0)) begin
  $display("%b        %b      %b |        10010100101101100010111000000000 0        0        0",result,overflow, carryout);
end
a = 32'b11111111111111000011100100000110; b = 32'b00000000000000000000000111010101; #1000
if((result !== 32'b11111111111111000011101011011011) || (overflow !== 0) || (carryout !== 0) || (zero !== 0)) begin
  $display("%b        %b      %b |        11111111111111000011101011011011 0        0        0",result,overflow, carryout);
end
a = 32'b00001011111010111100001000000000; b = 32'b10001000110010100110110000000000; #1000
if((result !== 32'b10010100101101100010111000000000) || (overflow !== 0) || (carryout !== 0) || (zero !== 0)) begin
  $display("%b        %b      %b |        10010100101101100010111000000000 0        0        0",result,overflow, carryout);
end
a = 32'b11111111101001101010100111011100; b = 32'b00000000000000000000001011101110; #1000
if((result !== 32'b11111111101001101010110011001010) || (overflow !== 0) || (carryout !== 0) || (zero !== 0)) begin
  $display("%b        %b      %b |        11111111101001101010110011001010 0        0        0",result,overflow, carryout);
end
a = 32'b10000000000000000000000000000000; b = 32'b11111111111111111111111111111111; #1000
if((result !== 32'b01111111111111111111111111111111) || (overflow !== 1) || (carryout !== 1) || (zero !== 0)) begin
  $display("%b        %b      %b |        01111111111111111111111111111111 1        1        0",result,overflow, carryout);
end
a = 32'b11111111111111111111110000011000; b = 32'b11111111111111111111110000011000; #1000
if((result !== 32'b11111111111111111111100000110000) || (overflow !== 0) || (carryout !== 1) || (zero !== 0)) begin
  $display("%b        %b      %b |        11111111111111111111100000110000 0        1        0",result,overflow, carryout);
end
a = 32'b00000000000000000000000000000000; b = 32'b00000000000000000000000000000000; #1000
if((result !== 32'b00000000000000000000000000000000) || (overflow !== 0) || (carryout !== 0) || (zero !== 1)) begin
  $display("%b        %b      %b |        00000000000000000000000000000000 0        0        1",result,overflow, carryout);
end
a = 32'b00000000000001100001101010000000; b = 32'b11111111111110011110010110000000; #1000 //WRONG!!!
if((result !== 32'b00000000000000000000000000000000) || (overflow !== 0) || (carryout !== 0) || (zero !== 1)) begin
  $display("%b        %b      %b |        00000000000000000000000000000000 0        0        1",result,overflow, carryout);
end

$finish();
end
endmodule
