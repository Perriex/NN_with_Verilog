module Layer (clk, we, rst, weightwrite, weight, bias, biaswrite, in, out, done, isfirst);

parameter wordsize = 8;
parameter addrsize;
parameter inputsize;
parameter neuroncount;

input clk, we, rst;
output done, isfirst;
input [511:0] weightwrite;
input [63:0] in, biaswrite;
output [511:0] weight;
output [63:0] bias;
output [63:0] out;
reg [addrsize-1:0] addr;
reg [addrsize-1:0] inputcounter;
reg [63:0] results[addrsize-1:0];
wire islast;

genvar k;
generate 
    for(k=0; k < 8; k = k + 1) begin
        SinglePortMemory #(wordsize<<3, addrsize) MM(clk, we, addr, weightwrite[((k+1)<<6)-1:k<<6], weight[((k+1)<<6)-1:k<<6]);
    end
endgenerate

SinglePortMemory #(wordsize, addrsize) MM(clk, we, addr, biaswrite, bias);

always @(posedge clk) begin
    if(rst)
        addr <= 0;
    else
        addr <= addr+1;
end

always @(posedge clk) begin
    if(rst)
        inputcounter <= 0;
    else if(inputcounter == inputsize) begin
        inputcounter <= 0;
        if(we)
            results[addr] <= in;
    end
    else
        inputcounter <= inputsize+1;
end

assign done = addr == neuroncount*inputsize;
assign isfirst = inputcounter == 0;
assign out = results[addr];
    
endmodule