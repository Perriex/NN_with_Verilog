module LayerController (clk, rst, start, done, layerrst, layerindex, ready);

parameter layercount;
parameter layeraddrsize;
parameter IDLE = 0, CALC = 1, NEXT = 2;

input clk, rst, start, done;

output reg ready, layerrst;
output reg[layeraddrsize-1:0] layerindex = 0;

reg [1:0] ps = IDLE, ns = IDLE;

always @(ps, done, start, layerindex) begin
   case (ps)
       IDLE: ns = start ? CALC : IDLE;
       CALC: ns = done ? NEXT : CALC;
       NEXT: ns = layerindex == layercount ? IDLE : CALC;
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
        IDLE : layerindex <= 0;
        CALC : layerindex <= layerindex;
        NEXT : layerindex <= layerindex + 1;
    endcase
end
    
endmodule