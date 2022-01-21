module TPU (clk, rst, start, ready);
    input clk, rst, start;
    output ready;

    wire layerrst, done;
    wire [0:0] layerindex;
    wire [2:0] addr;
    LayerController #(2, 1, 3) controller(clk, rst, start, done, layerrst, layerindex, addr, ready);
    Datapath datapath(clk, layerrst, layerindex, addr, done);
endmodule