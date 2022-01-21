`timescale 1ns/1ns

module Mulitplier( a, b, out);

    parameter size = 16;
    input [size-1:0] a, b;
    output [(size<<1)-1:0] out;
    wire [14:0] mult = a[size-2:0] * b[size-2:0]   ;

    assign out = { a[size-1] ^ b[size-1], mult};
endmodule