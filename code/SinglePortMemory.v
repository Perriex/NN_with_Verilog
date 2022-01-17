module SinglePortMemory (clk, we, addr, writedata, readdata);
    parameter wordsize = 8;
    parameter addrsize = 4;
    input clk, we;
    input [wordsize-1:0] writedata;
    input [addrsize-1:0] addr;
    output[wordsize-1:0] readdata;

    reg [wordsize-1:0] memory[2**addrsize-1:0];
    
    always @(posedge clk) begin
        if(we)
            memory[addr] <= writedata;
    end

    assign readdata = memory[addr];

endmodule