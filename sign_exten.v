module sign_exten(input wire [15:0] in , output reg [31:0] out);
always @(in)
if (in[15])
out <= {{16{1'b1}}, in}; 
else 
out <= {{16{1'b0}}, in}; 
endmodule
