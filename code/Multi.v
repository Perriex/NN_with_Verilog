`timescale 1ns/1ns

module Multi( x, w, mo);

    parameter size = 16;
    input [size-1:0] x [7:0];
    input [size-1:0] w [7:0];

    output [size-1:0] mo [7:0];

    genvar i;
    generate;
        for( i = 0; i < 8; i = i + 1 )begin
            Mulitplier mx( x[i], w[i], mo[i]);
        end
    endgenerate

endmodule