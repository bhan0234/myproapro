 `timescale 1ps / 1ps
	
 //Test Bench : 32 Bit CLA
 module Test_DADDA_8bit_All_Input; 

  // Inputs
 reg [7:0] A;
 reg [7:0] B;
 //reg app;
 reg clk = 0;
 
 integer RepFile;
 
 real error = 0;
 real error_distance = 0;
 real med = 0 ; 
 real mred = 0;
 real ned = 0;
 real sum_ed = 0;
 real sum_mred = 0;
 real sum_ned = 0;
 real max = 0;
 real aoc = 0;
 real i = 0,j = 0;
 
 // Outputs
 wire [15:0] O;
 reg [15:0] apprx,exact;
 
 // Instantiate the Unit Under Test (UUT)
dadda_8b  uut1 (
  .A(A),  
  .B(B), 
  .P(O)
 );

 
	always begin
	#5
	clk=~clk;
	end

initial begin
   
	RepFile =  $fopen("Test_Dadda_8.rep", "w");
	
	// Initialize Inputs
     A = 0; B = 0;
     
    // Wait 100 ns for global reset to finish
    #100;
	
	   	// testing all possible input combinations of A and B
		for (j = 0;j <= 255; j = j + 1) begin
		  for( i = 0;i<=255;i=i+1) begin
        
				#10 A = i; B = j;
				#1 apprx = O ; exact = A*B;
				
				if(exact != apprx) begin
				error = error + 1;
				end
				
				if(exact > apprx ) begin
				error_distance = exact - apprx;
				end else
				error_distance = apprx - exact;
			    
			    if(error_distance > max) begin 
			    max = error_distance;
			    end	
			    
			    sum_ed = sum_ed + error_distance ;
			    if(~(exact == 0)) begin
			    sum_mred = sum_mred + (error_distance/exact) ;
                end
                sum_ned = sum_ned + (error_distance/720);
                
                $fdisplay(RepFile,"A=%d B=%d exact=%d apprx=%d error distance=%d ", A,B,exact,apprx,error_distance);
			end
	     end  
	   // for loop ends
	   
	   med = sum_ed / 65536 ;
       mred = sum_mred / 65536;
	   ned = sum_ned / 65536;
	   aoc = 65536 - error ; 
	   $fdisplay(RepFile,"FINAL : number of error values=%d max=%d MED=%f MRED=%f NED=%f AOC=%d",error,max,med,mred,ned,aoc);
	   $fclose(RepFile);
	   $finish;
	end
    // initial begin end
    
endmodule
