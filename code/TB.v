`timescale 1ns/1ns
module TB ();
    reg clk = 1'b0;
    reg rst = 1'b1;
    reg start = 1'b0;
    wire ready;
    wire [7:0]out[9:0];
    reg [3:0] label[749:0];
    reg [3:0] predict, correct;
    reg [7:0] max;

    always #5 clk = ~clk;

    TPU UUT(clk, rst, start, ready);

    assign out[0] = UUT.datapath.layer2.results[0][7:0];
    assign out[1] = UUT.datapath.layer2.results[0][15:8];
    assign out[2] = UUT.datapath.layer2.results[0][23:16];
    assign out[3] = UUT.datapath.layer2.results[0][31:24];
    assign out[4] = UUT.datapath.layer2.results[0][39:32];
    assign out[5] = UUT.datapath.layer2.results[0][47:40];
    assign out[6] = UUT.datapath.layer2.results[0][55:48];
    assign out[7] = UUT.datapath.layer2.results[0][63:56];
    assign out[8] = UUT.datapath.layer2.results[1][7:0];
    assign out[9] = UUT.datapath.layer2.results[1][15:8];

    integer i, j, k = 0;
    initial begin
        $readmemh("../Files/b1_sm_0.dat", UUT.datapath.layer1.MM.memory);
        $readmemh("../Files/w1_sm_0.dat", UUT.datapath.layer1.genblk1[0].MM.memory);
        $readmemh("../Files/w1_sm_1.dat", UUT.datapath.layer1.genblk1[1].MM.memory);
        $readmemh("../Files/w1_sm_2.dat", UUT.datapath.layer1.genblk1[2].MM.memory);
        $readmemh("../Files/w1_sm_3.dat", UUT.datapath.layer1.genblk1[3].MM.memory);
        $readmemh("../Files/w1_sm_4.dat", UUT.datapath.layer1.genblk1[4].MM.memory);
        $readmemh("../Files/w1_sm_5.dat", UUT.datapath.layer1.genblk1[5].MM.memory);
        $readmemh("../Files/w1_sm_6.dat", UUT.datapath.layer1.genblk1[6].MM.memory);
        $readmemh("../Files/w1_sm_7.dat", UUT.datapath.layer1.genblk1[7].MM.memory);

        $readmemh("../Files/b2_sm_0.dat", UUT.datapath.layer2.MM.memory);
        $readmemh("../Files/w2_sm_0.dat", UUT.datapath.layer2.genblk1[0].MM.memory);
        $readmemh("../Files/w2_sm_1.dat", UUT.datapath.layer2.genblk1[1].MM.memory);
        $readmemh("../Files/w2_sm_2.dat", UUT.datapath.layer2.genblk1[2].MM.memory);
        $readmemh("../Files/w2_sm_3.dat", UUT.datapath.layer2.genblk1[3].MM.memory);
        $readmemh("../Files/w2_sm_4.dat", UUT.datapath.layer2.genblk1[4].MM.memory);
        $readmemh("../Files/w2_sm_5.dat", UUT.datapath.layer2.genblk1[5].MM.memory);
        $readmemh("../Files/w2_sm_6.dat", UUT.datapath.layer2.genblk1[6].MM.memory);
        $readmemh("../Files/w2_sm_7.dat", UUT.datapath.layer2.genblk1[7].MM.memory);
        $readmemh("../Files/te_label_sm.dat", label);

        #20;
        rst=1'b0;
        for (i = 0; i < 750; i = i + 1) begin    
            $readmemh($sformatf("../Files/te_data_sm_%0d.dat", i), UUT.datapath.inData);
            #20;
            start = 1'b1;
            #20;
            start = 1'b0;
            #480;
            max = 0;
            predict = 0;
            correct = label[i];
            for (j = 0; j < 10; j = j + 1) begin
               predict = out[j] > max ? j : predict;
               max = out[j] > max ? out[j] : max;
            end
            if(predict == label[i])
                k = k + 1;
        end
        $stop;
    end
endmodule