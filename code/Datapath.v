`timescale 1ns/1ns

module Datapath(clk, layerrst, layerindex, addr, done);
    parameter size = 8;
    input clk, layerrst;
    input layerindex;
    input [2:0]addr;
    output done;

    wire [511:0] weight;
    wire [63:0] bias;
    wire [63:0] puout, puin;
    wire [63:0] in;
    wire isfirst;

    wire [511:0] weights[1:0]; 
    wire [63:0] biases[1:0]; 
    wire [63:0] ins[1:0];
    wire [63:0] lastin;
    wire dones[1:0]; 
    wire isfirsts[1:0];
    Mux #(1, 512) weightMux(weights, layerindex, weight);
    Mux #(1, 64) biasMux(biases, layerindex, bias);
    Mux #(1, 1) doneMux(dones, layerindex, done);
    Mux #(1, 1) firstMux(isfirsts, layerindex, isfirst);
    Mux #(1, 64) inMux(ins, layerindex, in);

    reg [63:0]inData[7:0];
    assign ins[0] = inData[addr];
    Layer #(size, 5, 8, 4) layer1(clk, 1'b0, layerindex == 0, layerrst, 0, weights[0], biases[0], 0, puout, ins[1], dones[0], isfirsts[0]);
    Layer #(size, 4, 4, 2) layer2(clk, 1'b0, layerindex == 1, layerrst, 0, weights[1], biases[1], 0, puout, lastin, dones[1], isfirsts[1]);

    genvar k;
    generate 
        for(k = 0; k < 8; k = k + 1) begin
            PU pu0(clk, isfirst, in, weight[((k+1)<<6)-1:k<<6], bias[((k+1)<<3)-1:k<<3], puout[((k+1)<<3)-1:k<<3]);
        end
    endgenerate

endmodule