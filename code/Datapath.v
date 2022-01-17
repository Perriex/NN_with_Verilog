`timescale 1ns/1ns

module Datapath(clk, layerrst, done);
    parameter size = 8;
    input clk, layerrst;
    output done;

    wire [511:0] weight;
    wire [63:0] bias;
    wire [63:0] puout, puin;
    reg  [63:0] in = 1;
    wire isfirst;

    Layer #(size, 1, 1, 1) layer1(clk, we, layerrst, 0, weight, bias, 0, puout, puin, done, isfirst);

    genvar k;
    generate 
        for(k = 0; k < 8; k = k + 1) begin
            PU pu0(clk, isfirst, in, weight[((k+1)<<6)-1:k<<6], bias[((k+1)<<3)-1:k<<3], puout[((k+1)<<3)-1:k<<3]);
        end
    endgenerate

endmodule