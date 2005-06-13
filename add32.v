/*******************************************************
* 32 bit Adder
*
*******************************************************/


module add32 (
	     In0,
	     In1,
	     Out 
     );
 
input [31:0]  In0;
input [31:0]  In1;

output [31:0] Out;

wire [31:0]  Out;

assign Out[31:0] = In0 + In1;

endmodule
	    
