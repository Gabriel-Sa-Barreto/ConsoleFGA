module testLFSR;
 
 // Inputs
 reg clk;
 reg reset;
 
 // Outputs
 wire [9:0] value;
 
 // Instantiate the Unit Under Test (UUT)
 LFSR lfsr (
  .clk(clk), 
  .reset(reset), 
  .value(value)
 );
  
 initial begin
  clk = 0;
  forever
   #20 clk = ~clk;
  end
   
 initial begin
  // Initialize Inputs
  reset = 0;
  // Wait 100 ns for global reset to finish
  #100;
  reset = 1;
  #200;
  reset = 0;
  // Add stimulus here
 
 end
  
 initial begin
    $display("clock value-random:");
    $monitor("%b,%b", clk, value);
 end     
endmodule
