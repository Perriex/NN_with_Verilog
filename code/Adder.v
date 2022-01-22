`timescale 1ns/1ns

module Adder(
     a, b, 
	 out    
   );
    parameter size = 16;
    input signed[size-1:0] a, b;
    output reg[size-1:0] out;

	always @(*)begin
		out = a + b ;
	end
endmodule