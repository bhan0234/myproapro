`timescale 1ps / 1ps

module APPCOMP4to2 (X1, X2, X3, X4, Sum, Carry);

 input X1, X2, X3, X4; 
 output Carry, Sum; 
 assign Sum =(~(X3^X4) & (X1 | X2)) | (X1 & X2);
 assign Carry = (X3 | X4) ;

endmodule
