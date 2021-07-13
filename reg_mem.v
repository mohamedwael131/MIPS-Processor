module registery_memory(input wire trigger , input wire [4:0] rs_add , rt_add , rd_add ,input wire [31:0] rd_data,ra_data, input wire clk , WE_reg , ra_enable, output reg [31:0] rs_data , rt_data) ; 
integer registery_array[0:31] ;
always @(posedge trigger)
begin 
$readmemh("registery_memory_initial.txt",registery_array);
end
always @(posedge clk)
registery_array[0] <= 0 ; 
always @(negedge clk,rs_add,rt_add)
begin 
rs_data <= registery_array[rs_add];
rt_data <= registery_array[rt_add];
end
always @(posedge clk)
if (WE_reg && ~ra_enable)
registery_array[rd_add] <= rd_data ; 
else if (WE_reg && ra_enable)
registery_array[31] <= ra_data ; 
else
begin 
end
endmodule  
