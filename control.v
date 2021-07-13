module control(input wire [31:0] instruction, output reg[4:0] rs_add,rt_add,rd_add,shamt ,output reg [3:0]aluop, output reg WE_reg, IR , output reg [15:0] I_data,output reg WE_mem,result_address,load_enable,branch_i,output reg [25:0] jump_address , output reg j_enable , ra_enable , BRANCH_IT , is_lui); //add all outputs as we go along 
always @(instruction)
begin 
rs_add <= instruction[25:21] ; 
shamt <= instruction[10:6];
ra_enable <= 0 ;
is_lui <= 0 ; 
I_data <= instruction[15:0] ;
jump_address <= instruction[25:0] ; 
branch_i <= 0 ;
WE_mem <=0 ; 
load_enable <= 0 ; 
j_enable <= 0 ; 
ra_enable <= 0 ; 
WE_reg <= 0 ;
BRANCH_IT <= 0 ; 
result_address <= instruction[31] ; 
if (instruction[31:26] == 6'b0)//roperations
begin
if (instruction[5:0] == 8) 
begin
WE_reg <= 0 ; 
WE_mem <= 0 ;
load_enable <= 1 ; 
j_enable <= 0 ; 
end
else 
begin 
IR <= 1'b0 ; 
rd_add <= instruction[15:11];
rt_add <= instruction[20:16];
aluop <= instruction[3:0];
WE_reg <= 1; 
WE_mem <= 0 ;
end
end
else if (instruction[31:26] == 6'd4 || instruction[31:26] == 6'd5)//beq,bne
begin 
BRANCH_IT <= 1;
WE_reg <= 0 ;WE_mem <= 0; 
IR <= 0 ; 
rt_add <= instruction[20:16] ; 
aluop <= 2;
load_enable <= 0 ; 
branch_i <= instruction[26] ; 
end
else if (instruction[31:26] == 6'd2 || instruction[31:26] == 6'd3)//j / jal
begin 
WE_reg <= 0 ; 
WE_mem <= 0 ;
load_enable <= 1 ; 
j_enable <= 1 ;
if (instruction[31:26] == 6'd3)
begin 
WE_reg <= 1 ; 
ra_enable <= 1 ; 
end
end
else //any other i operation
begin
IR <= 1'b1 ;  
rd_add <= instruction[20:16] ;
aluop <= instruction[29:26] ; 
WE_reg <= 1 ; 
if (instruction[31:26] == 6'd15)
begin 
aluop <= 0 ; 
IR <= 0 ; 
shamt <= 5'd16 ;
is_lui <= 1 ;  
end
if (instruction[31] == 1'b1)//load_store operations
begin 
rt_add <= instruction[20:16];
WE_mem <= instruction[29] ; 
WE_reg <= ~(instruction[29]) ; 
aluop <= 3'b0 ; 
end
end
end
endmodule
