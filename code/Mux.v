module Mux (in, s, out);
    parameter addrsize = 1;
    parameter wordsize = 8;

    input [addrsize-1:0] s;
    input [wordsize-1:0] in[2**addrsize-1:0];
    output [wordsize-1:0] out;
    assign out = in[s];
endmodule