module program_counter(input wire trigger,input wire clk , input wire [31:0] load , input wire LE , input wire [15:0] add_value , input wire reset , output reg [31:0] PC,input wire branch_modify) ; 
wire [31:0] added_value ; //to change any negative values to their respective 32 bit signed thingy
always @(posedge trigger)
PC <= 0 ; 
always @(posedge clk)
begin
if (LE)
PC <= load ;
else
PC <= PC + added_value + branch_modify ; 
end
sign_exten sign_exten_insta_2(add_value , added_value) ; 
endmodule
//needs modifications to make more flexable trigger,enable,clk wise
