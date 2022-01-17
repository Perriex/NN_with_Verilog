module TPU (clk, rst, start, ready);
    input clk, rst, start;
    output ready;

    wire layerrst, done;
    wire [0:0] layerindex;
    LayerController #(1, 1) controller(clk, rst, start, done, layerrst, layerindex, ready);
    Datapath datapath(clk, layerrst, done);
endmodule