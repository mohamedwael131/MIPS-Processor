module DRIVER(output reg clk,trigger);
initial
begin  
clk <=0; 
trigger <= 1 ; 
end
always #1
clk <= ~clk ; 
body insta_body(clk,trigger);
endmodule
