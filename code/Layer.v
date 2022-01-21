module Layer (clk, we, en, rst, weightwrite, weight, bias, biaswrite, in, out, done, isfirst);

parameter wordsize = 8;
parameter addrsize;
parameter inputsize;
parameter neuroncount;

input clk, we, en, rst;
output done, isfirst;
input [511:0] weightwrite;
input [63:0] in, biaswrite;
output [511:0] weight;
output [63:0] bias;
output [63:0] out;
reg [addrsize-1:0] addr;
reg [neuroncount-1:0] outindex;
reg [addrsize-1:0] inputcounter;
reg [63:0] results[neuroncount-1:0];
wire islast;

genvar k;
generate 
    for(k=0; k < 8; k = k + 1) begin
        SinglePortMemory #(wordsize<<3, addrsize) MM(clk, we, addr, weightwrite[((k+1)<<6)-1:k<<6], weight[((k+1)<<6)-1:k<<6]);
    end
endgenerate

SinglePortMemory #(wordsize<<3, addrsize) MM(clk, we, inputcounter, biaswrite, bias);

always @(posedge en) begin
    addr <= 0;
    inputcounter <= 0;
    outindex <= 0;
end

always @(posedge clk) begin
    if(rst)
        addr <= 0;
    else if(en)
        addr <= addr + 1;
end

always @(posedge clk) begin
    if(rst)
        outindex <= 0;
    else if(en && inputcounter == inputsize - 1) begin
        if(outindex == neuroncount - 1)
            outindex <=  0;
        else 
            outindex <= outindex + 1;
    end
    if(~en) begin
        if(outindex == neuroncount - 1)
            outindex <=  0;
        else 
            outindex <= outindex + 1;
    end
end

always @(posedge clk) begin
    if(rst)
        inputcounter <= 0;
    else if(inputcounter == inputsize - 1 && en) begin
        results[outindex] <= in;
        inputcounter <= 0;
    end
    else if(en)
        inputcounter <= inputcounter+1;
end

assign done = addr == neuroncount*inputsize - 1;
assign isfirst = inputcounter == 0;
assign out = results[outindex];
    
endmodule