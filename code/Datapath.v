`timescale 1ns/1ns

module Datapath();

    parameter size = 16;

    reg [size-1:0] bias [7:0];

    reg [size-1:0] out [7:0];

    // PU pu0 ( x0, w0, bias[0], out[0]);
    // PU pu1 ( x1, w1, bias[1], out[1]);
    // PU pu2 ( x2, w2, bias[2], out[2]);
    // PU pu3 ( x3, w3, bias[3], out[3]);
    // PU pu4 ( x4, w4, bias[4], out[4]);
    // PU pu5 ( x5, w5, bias[5], out[5]);
    // PU pu6 ( x6, w6, bias[6], out[6]);
    // PU pu7 ( x7, w7, bias[7], out[7]);

endmodule