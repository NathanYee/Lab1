// Subtractor testbench
`timescale 1 ns / 1 ps
`include "subtractor.v"
`include "adder.v"

module testFullSubtract();
    // Defining inputs and outputs
    reg [31:0] a, b;
    reg carryin;
    wire [31:0] result;
    wire carryout, overflow;
    wire zero;

    // Instatntiating subtractor
    Subtractor32bit sub32 (result, carryout, overflow, zero, a, b,carryin);


    initial begin
    $dumpfile("slt.vcd");
    $dumpvars;
        carryin = 1;    // Specifying key input for subtraction
        $display("result                           overflow carryout zero | Eresult                          Eoverflow Ecarryout Ezero");
        a = 32'b00000000000000000000000000001010; b = 32'b00000000000000000000000000000101; #3000
        if((result !== 32'b00000000000000000000000000000101) || (overflow !== 0) || (carryout !== 1) || (zero !== 0)) begin
          $display("%b                                %b        %b        %b    | 00000000000000000000000000000101 0         1         0",result,overflow,carryout,zero);
        end
        a = 32'b00000000000000000000000000000101; b = 32'b00000000000000000000000000001010; #3000
        if((result !== 32'b11111111111111111111111111111011) || (overflow !== 0) || (carryout !== 0) || (zero !== 0)) begin
          $display("%b                                %b        %b        %b    | 11111111111111111111111111111011 0         0         0",result,overflow,carryout,zero);
        end
        a = 32'b11111111111111111111111111110110; b = 32'b11111111111111111111111111111011; #3000
        if((result !== 32'b11111111111111111111111111111011) || (overflow !== 0) || (carryout !== 0) || (zero !== 0)) begin
          $display("%b                                %b        %b        %b    | 11111111111111111111111111111011 0         0         0",result,overflow,carryout,zero);
        end
        a = 32'b11111111111111111111111111111011; b = 32'b11111111111111111111111111110110; #3000
        if((result !== 32'b00000000000000000000000000000101) || (overflow !== 0) || (carryout !== 1) || (zero !== 0)) begin
          $display("%b                                %b        %b        %b    | 00000000000000000000000000000101 0         1         0",result,overflow,carryout,zero);
        end
        a = 32'b11111111111111000011100100000110; b = 32'b00000000000000000000000111010101; #3000
        if((result !== 32'b11111111111111000011011100110001) || (overflow !== 0) || (carryout !== 1) || (zero !== 0)) begin
          $display("%b                                %b        %b        %b    | 11111111111111000011011100110001 0         1         0",result,overflow,carryout,zero);
        end
        a = 32'b10001000110010100110110000000000; b = 32'b00001011111010111100001000000000; #3000
        if((result !== 32'b01111100110111101010101000000000) || (overflow !== 1) || (carryout !== 1) || (zero !== 0)) begin
          $display("%b                                %b        %b        %b    | 01111100110111101010101000000000 1         1         0",result,overflow,carryout,zero);
        end
        a = 32'b00001011111010111100001000000000; b = 32'b10001000110010100110110000000000; #3000
        if((result !== 32'b10000011001000010101011000000000) || (overflow !== 1) || (carryout !== 0) || (zero !== 0)) begin
          $display("%b                                %b        %b        %b    | 10000011001000010101011000000000 1         0         0",result,overflow,carryout,zero);
        end
        a = 32'b00000000000000000000000111010101; b = 32'b11111111111111000011100100000110; #3000
        if((result !== 32'b00000000000000111100100011001111) || (overflow !== 0) || (carryout !== 0) || (zero !== 0)) begin
          $display("%b                                %b        %b        %b    | 00000000000000111100100011001111 0         0         0",result,overflow,carryout,zero);
        end
        a = 32'b11111111111111111111110000011000; b = 32'b11111111111111111111110000011000; #3000
        if((result !== 32'b00000000000000000000000000000000) || (overflow !== 0) || (carryout !== 1) || (zero !== 1)) begin
          $display("%b                                %b        %b        %b    | 00000000000000000000000000000000 0         1         1",result,overflow,carryout,zero);
        end
        a = 32'b00000000000000000000000000000000; b = 32'b00000000000000000000000000000000; #3000
        if((result !== 32'b00000000000000000000000000000000) || (overflow !== 0) || (carryout !== 1) || (zero !== 1)) begin
          $display("%b                                %b        %b        %b    | 00000000000000000000000000000000 0         1         1",result,overflow,carryout,zero);
        end
        a = 32'b00000000000001100001101010000000; b = 32'b00000000000001100001101010000000; #3000
        if((result !== 32'b00000000000000000000000000000000) || (overflow !== 0) || (carryout !== 1) || (zero !== 1)) begin
          $display("%b                                %b        %b        %b    | 00000000000000000000000000000000 0         1         1",result,overflow,carryout,zero);
        end
    end
endmodule
