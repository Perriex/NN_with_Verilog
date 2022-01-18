`timescale 1ns/1ns

module Adder(
     a, b, 
	 out    
   );
    parameter size = 16;
    input [size-1:0] a, b;
    output [size-1:0] out;

	reg [size-1:0] mag_a, mag_b, max, min;
	reg sign_a, sign_b, sign;

	always @* begin
	  mag_a = a[size-2:0] ;
	  mag_b = b[size-2:0] ;
	  sign_a =a[size-1] ; 
	  sign_b =b[size-1] ; 
	  if(mag_a > mag_b) begin
		max = mag_a;
		min = mag_b; 
		sign <= sign_a; 
	        end
	  else begin 
		max = mag_b; 
		min = mag_a; 
		sign <= sign_b;
		end
	  if(sign_a == sign_b) begin 
		out[size-2:0] = max + min; 
		end
	  else begin 
		out[size-2:0] = max - min; 
		end
	  out[size-1:0] = {sign, out[size-2:0]};
	end
endmodule