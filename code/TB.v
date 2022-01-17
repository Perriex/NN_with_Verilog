`timescale 1ns/1ns
module TB ();
    reg clk = 1'b0;
    reg rst = 1'b0;
    reg start = 1'b0;
    wire ready;

    always #5 clk = ~clk;

    TPU UUT(clk, rst, start, ready);

    initial begin
        UUT.datapath.layer1.genblk1[0].MM.memory[0] = 64'b1;
        UUT.datapath.layer1.genblk1[0].MM.memory[1] = 64'b1;
        UUT.datapath.layer1.MM.memory[0] = 64'b1;
        UUT.datapath.layer1.MM.memory[1] = 64'b1;
        #20;
        start = 1'b1;
        #20
        start = 1'b0;
        #200
        $stop;
    end
endmodule