`timescale 1ns/1ns

module Adder( a, b, out);

    parameter size = 16;
    input [size-1:0] a, b;
    output [size-1:0] out;

    assign out = a + b;

endmodule