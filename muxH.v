module muxH(input wire sel , input wire [15:0] data_1 , data_2 , output wire [15:0] result);
assign result = (sel == 0)?data_1:data_2 ; 
endmodule 
