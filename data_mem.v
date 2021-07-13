module data_memory(input wire [31:0] address , data_to_write , input wire trigger ,clk , WE_memory , output reg [31:0] data_read);
integer DATA_ARRAY [0:1024] ; 
always @(posedge trigger)
$readmemh("data_file_initial.txt",DATA_ARRAY) ; 
always @(address)
begin
data_read <= DATA_ARRAY[address] ; 
end
always @(posedge clk)
begin
if (WE_memory)
DATA_ARRAY[address] <= data_to_write ;
//$fseek the certain address(line) and write data to the file 
end
endmodule 
