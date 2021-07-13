module alu(input wire [31:0] data_1 , data_2 , input wire [3:0] aluop , output reg [31:0] result ,output reg Zeroflag , output reg Negflag);
always @(data_1,data_2,aluop)
begin
case (aluop[2:0])
 0 : result <= data_1 + data_2 ;//add
 4 : result <= data_1 & data_2 ;// and
 7 : result <= ~(data_1 | data_2);//nor
 5 : result <= data_1|data_2 ;  // or
 2 : if (aluop[3] == 1'b1) result <=(data_1 < data_2)?'b1:'b0; else result <= data_1 - data_2 ;
endcase 
end
always @(result)
begin
Zeroflag = (result == 0)?1:0 ; 
Negflag = (result < 0)?1:0 ; 
end
endmodule 
