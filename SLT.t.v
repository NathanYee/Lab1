// Adder testbench
//`timescale 1 ns / 1 ps
//include "SLT.v"

module testSLT();
    reg [31:0] a, b;
    reg carryin;
    wire [31:0] result;
    reg overflow, carryout, zero;

    SLT SLT32 (result, a, b,1);


    initial begin
    overflow = 0; carryout = 0; zero = 0;
    $dumpfile("slt.vcd");
    $dumpvars;
        $display("result                           overflow carryout zero | Eresult                          Eoverflow Ecarryout Ezero");
        a = 32'b01111111111111111111111111111111; b = 32'b00000000000000000000000000000001; #2000
        if((result !== 32'b00000000000000000000000000000000) || (overflow !== 0) || (carryout !== 0) || (zero !== 0)) begin
          $display("%b                                %b        %b        %b    | 00000000000000000000000000000000 0         0         0",result,overflow,carryout,zero);
        end
        a = 32'b00000000000000000000000000000001; b = 32'b01111111111111111111111111111111; #2000
        if((result !== 32'b00000000000000000000000000000001) || (overflow !== 0) || (carryout !== 0) || (zero !== 0)) begin
          $display("%b                                %b        %b        %b    | 00000000000000000000000000000001 0         0         0",result,overflow,carryout,zero);
        end
        a = 32'b10000000000000000000000000000000; b = 32'b10000000000000000000000000000000; #2000
        if((result !== 32'b00000000000000000000000000000000) || (overflow !== 0) || (carryout !== 0) || (zero !== 0)) begin
          $display("%b                                %b        %b        %b    | 00000000000000000000000000000000 0         0         0",result,overflow,carryout,zero);
        end
        a = 32'b10001000110010100110110000000000; b = 32'b00001011111010111100001000000000; #2000
        if((result !== 32'b00000000000000000000000000000001) || (overflow !== 0) || (carryout !== 0) || (zero !== 0)) begin
          $display("%b                                %b        %b        %b    | 00000000000000000000000000000001 0         0         0",result,overflow,carryout,zero);
        end
        a = 32'b11111111111111000011100100000110; b = 32'b00000000000000000000000111010101; #2000
        if((result !== 32'b00000000000000000000000000000001) || (overflow !== 0) || (carryout !== 0) || (zero !== 0)) begin
          $display("%b                                %b        %b        %b    | 00000000000000000000000000000001 0         0         0",result,overflow,carryout,zero);
        end
        a = 32'b00001011111010111100001000000000; b = 32'b10001000110010100110110000000000; #2000
        if((result !== 32'b00000000000000000000000000000000) || (overflow !== 0) || (carryout !== 0) || (zero !== 0)) begin
          $display("%b                                %b        %b        %b    | 00000000000000000000000000000000 0         0         0",result,overflow,carryout,zero);
        end
        a = 32'b00000000010110010101011000100100; b = 32'b11111111111111111111110100010010; #2000
        if((result !== 32'b00000000000000000000000000000000) || (overflow !== 0) || (carryout !== 0) || (zero !== 0)) begin
          $display(" %b                                %b        %b        %b    | 00000000000000000000000000000000 0         0         0",result,overflow,carryout,zero);
        end
        a = 32'b00000000000000000000001111101000; b = 32'b00000000000000000000001111101000; #2000
        if((result !== 32'b00000000000000000000000000000000) || (overflow !== 0) || (carryout !== 0) || (zero !== 0)) begin
          $display("%b                                %b        %b        %b    | 00000000000000000000000000000000 0         0         0",result,overflow,carryout,zero);
        end
        a = 32'b11111111111111111111110000011000; b = 32'b11111111111111111111110000011000; #2000
        if((result !== 32'b00000000000000000000000000000000) || (overflow !== 0) || (carryout !== 0) || (zero !== 0)) begin
          $display("%b                                %b        %b        %b    | 00000000000000000000000000000000 0         0         0",result,overflow,carryout,zero);
        end
        a = 32'b00000000000000000000000000000000; b = 32'b00000000000000000000000000000000; #2000
        if((result !== 32'b00000000000000000000000000000000) || (overflow !== 0) || (carryout !== 0) || (zero !== 0)) begin
          $display("%b                                %b        %b        %b    | 00000000000000000000000000000000 0         0         0",result,overflow,carryout,zero);
        end
        a = 32'b00000000000001100001101010000000; b = 32'b11111111111110011110010110000000; #2000
        if((result !== 32'b00000000000000000000000000000000) || (overflow !== 0) || (carryout !== 0) || (zero !== 0)) begin
          $display("%b                                %b        %b        %b    | 00000000000000000000000000000000 0         0         0",result,overflow,carryout,zero);
        end
    end
endmodule
