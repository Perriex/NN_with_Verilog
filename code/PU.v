`timescale 1ns/1ns

module PU(clk, isfirst, x, w, bias, out);
    input clk, isfirst;
    input [7:0] bias;

    input [63:0] x;
    input [63:0] w;


    wire [14:0] mo [7:0];
    wire [20:0] ao [7:0];
    wire [7:0] saturated;
    reg [20:0] acc;
    output [7:0] out;

    genvar k;
    generate 
        for (k = 0; k < 8 ; k = k + 1 ) begin
            Mulitplier #(8) mm(x[(k<<3)+7:k<<3], w[(k<<3)+7:k<<3], mo[k]);
        end
    endgenerate

    // Neuron - input in wire mo output in ao

    generate
        for(k=0; k < 4; k = k + 1)
            Adder #(21) add1( {mo[k][14], 10'b0, mo[k][13:0]}, {mo[k+1][14], 10'b0, mo[k+1][13:0]}, ao[k]);
    endgenerate

    Adder #(21) add5( ao[0], ao[1], ao[4]);
    Adder #(21) add6( ao[2], ao[3], ao[5]);

    Adder #(21) add7( ao[4], ao[5], ao[6]);

    wire [20:0] lastaddin;
    wire[14:0] biasout;
    wire [20:0] muxin[1:0];
    assign muxin[0] = acc;
    assign muxin[1] = {biasout[14], 10'b0, biasout[13:0]};
    Mulitplier #(8) mm(8'b01111111, bias, biasout);
    Mux #(1,21) mux(muxin, isfirst, lastaddin);
    Adder #(21) add8( ao[6], lastaddin, ao[7]);

    assign saturated = {ao[7][20], ao[7][19:12]};
    ActivationFunc relu( saturated, out);

    always @(posedge clk) begin
        acc <= ao[7];
    end
endmodule