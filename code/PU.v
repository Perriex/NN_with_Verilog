`timescale 1ns/1ns

module PU( x, w, bias, out);

    parameter size = 16;
    input [size-1:0] bias;

    //input [size-1:0] x [7:0];
    //input [size-1:0] w [7:0];


    wire [size-1:0] mo [7:0];
    wire [size-1:0] ao [7:0];

    output [size-1:0] out;

    // use Multi  

    // Neuron - input in wire mo output in ao
    
    Adder #(size) add1( mo[0], mo[1], ao[0]);
    Adder #(size) add2( mo[2], mo[3], ao[1]);
    Adder #(size) add3( mo[4], mo[5], ao[2]);
    Adder #(size) add4( mo[6], mo[7], ao[3]);

    Adder #(size) add5( ao[0], ao[1], ao[4]);
    Adder #(size) add6( ao[2], ao[3], ao[5]);

    Adder #(size) add7( ao[4], ao[5], ao[6]);

    Adder #(size) add8( ao[6], bias, ao[7]);

    //ActivationFunc relu( ao[7], out);

endmodule