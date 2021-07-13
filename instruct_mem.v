module instruction_memory(input wire trigger, input wire [31:0] pc ,output reg [31:0] instruction);
integer instruction_array[0:100] ; 
always @(posedge trigger)
begin 
$readmemh("program_file.txt",instruction_array) ; 
end
always @(pc)
instruction <= instruction_array[pc] ; 
endmodule
