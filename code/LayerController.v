module LayerController (clk, rst, start, done, layerrst, layerindex, addr, ready);

parameter layercount;
parameter layeraddrsize;
parameter addrsize;
parameter IDLE = 0, CALC = 1, NEXT = 2;

input clk, rst, start, done;

output reg ready, layerrst;
output reg[layeraddrsize-1:0] layerindex = 0;
output reg[addrsize-1:0] addr;

reg [1:0] ps = IDLE, ns = IDLE;

always @(ps, done, start, layerindex) begin
   case (ps)
       IDLE: ns = start ? CALC : IDLE;
       CALC: ns = done ? NEXT : CALC;
       NEXT: ns = layerindex == layercount - 1 ? IDLE : CALC;
   endcase 
end

always @(ps) begin
   {ready, layerrst} = 0;
   case (ps)       
       IDLE: begin ready = 1'b1; layerrst = 1'b1; end 
       NEXT: layerrst = 1'b1;
   endcase
end

always @(posedge clk) begin
    ps <= ns;
end

always @(posedge clk) begin
    case(ps)
        IDLE : begin layerindex <= 0; addr <= 0; end
        CALC : addr <= addr + 1;
        NEXT : begin layerindex <= layerindex + 1; addr <= 0; end 
    endcase
end
    
endmodule