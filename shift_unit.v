module shift_unit(input wire [31:0] data , input wire [4:0] shamt , input wire [1:0] shamtop  , output reg [31:0] result); 
always @(shamt , data , shamtop)
case (shamtop)
0 : result <= (data << shamt) ; 
2 : result <= (data >> shamt) ; 
3 : result <= (data >> shamt) ; //has yet to do 
endcase 
endmodule 
