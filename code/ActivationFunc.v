`timescale 1ns/1ns

module ActivationFunc( in, out);

    // Relu
    parameter size = 16;
    input [size-1:0] in;
    output [size-1:0] out;

    assign out = in > 0 ? in : 0;

endmodule