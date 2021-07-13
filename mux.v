module mux(input wire sel , input wire [31:0] data_1 , data_2 , output wire [31:0] result);
assign result = (sel == 0)?data_1:data_2 ; 
endmodule 