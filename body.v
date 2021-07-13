module body(input wire clk , trigger);
wire IR  , zeroflag , negflag,WE_reg;
wire [4:0] rs_add,rt_add,rd_add,shamt ; 
wire [3:0] aluop ; 
wire [15:0] I_data ; 
wire [31:0] rd,rs,rt,inter,I_data_exten,aluresult,shamtresult,result,data_from_mem;
wire [31:0] instruction ;
wire [31:0] pc  , load;
wire [15:0] added_value;
wire LE ,ra_enable ; 
wire [25:0] jump_address ; 
reg [31:0] add_value_pc; 
wire pc_sel ,branch_i , BRANCH_IT ; 
wire WE_mem,result_address ;
wire j_enable ; 
wire is_lui ;
wire [31:0] shamt_what ;  
assign pc_sel = (zeroflag ^ branch_i)& BRANCH_IT ; 
program_counter insta_program_counter(trigger,clk,load,LE,added_value,trigger,pc,pc_sel) ; 
mux insta_muxPC_2(j_enable,rs,{{6{1'b0}},jump_address},load) ; 
muxH insta_muxPC(pc_sel,16'b1,I_data,added_value) ; 
instruction_memory insta_instruction_memory(trigger,pc,instruction) ; 
control insta_control(instruction ,rs_add,rt_add,rd_add,shamt,aluop,WE_reg,IR,I_data,WE_mem,result_address,LE,branch_i,jump_address,j_enable,ra_enable,BRANCH_IT,is_lui) ; 
registery_memory insta_registery_memory(trigger,rs_add,rt_add,rd_add,rd,pc+1,clk,WE_reg,ra_enable,rs,inter);
mux insta_mux1(IR,inter,I_data_exten,rt);
sign_exten insta_sign_exten(I_data,I_data_exten);
shift_unit insta_shift_unit(shamt_what,shamt,aluop[1:0],shamtresult); // shamt_what->inter
mux insta_mux2((|shamt)&(~IR),aluresult,shamtresult,result);
data_memory insta_data_memory(result,inter,trigger,clk,WE_mem,data_from_mem) ; 
mux insta_mux3(result_address,result,data_from_mem,rd);
mux insta_lui(is_lui , inter , I_data_exten , shamt_what) ; //delete to remove support 
alu insta_alu(rs,rt,aluop,aluresult,zeroflag,negflag);
endmodule 
