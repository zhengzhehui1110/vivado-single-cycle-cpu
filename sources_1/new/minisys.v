`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/11 19:24:31
// Design Name: 
// Module Name: minisys_top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module minisys(
input clk,rst,
output clock,
output [31:0] debug_wb_pc,
output debug_wb_rf_wen,
output [4:0] debug_wb_rf_wnum,
output [31:0] debug_wb_rf_wdata
    );
    
    wire clka; //23MHz时钟
    cpuclk clk0(.clk_in1(clk),.clk_out1(clka));
    wire clkb; //反向时钟，ram专用
    assign clkb = !clka;
    
    wire [31:0]im; //指令存储器取出的指令
    wire [31:0]pc_pc; //当前指令的地址
    wire [13:0]pc_pc1; //当前指令的【15:2】
    assign pc_pc1 = pc_pc[15:2];
    wire [31:0]npc_npc;
    reg [31:0]npc_pc4;
    
    
    //wire DMWr; //数据存储器写使能
    wire [13:0]dm_a; //输入数据存储器的地址
    wire [31:0]dm_rd; //取出数据存储器的数据
    
    wire [5:0]op; //指令的op部分
    wire [5:0]func; //指令的func部分
    wire [4:0]rs; //操作数1（寄存器编号）
    wire [4:0]rt; //操作数2（寄存器编号）
    wire [4:0]rd; //写回寄存器编号
    wire [15:0]imm; //指令中的立即数
    wire [25:0]address; //指令中的地址address
    assign op = im[31:26];
    assign func = im[5:0];
    assign rs = im[25:21];
    assign rt = im[20:16];
    assign imm = im[15:0];
    assign address = im[25:0];
    
    
    wire [1:0]zero; //alu输出的0标志位
    wire [1:0]npcop; //控制npc的生成方式
    wire [1:0]extop; //控制ext的立即数位扩展方式
    wire [1:0]wdsel; //控制寄存器写回值的选择方式
    wire [1:0]wrsel; //控制寄存器写回地址的选择方式
    wire rfwr; //寄存器堆写使能
    wire dmwr; //数据存储器写使能
    wire asel; //alua输入值的选择
    wire [1:0]bsel; //alub输入值的选择
    wire isjump; //条件跳转下判断是否可以跳转
    wire [3:0]aluop; //控制alu的功能
    
    wire [31:0]ext_ext; //立即数位扩展输出
    
    wire [31:0]rf_rd1; //寄存器堆读出1
    wire [31:0]rf_rd2; //寄存器堆读出2
    wire [31:0]rf_wd; //寄存器堆的写回值
    
    wire [31:0]alu_a; //alu 操作数
    wire [31:0]alu_b; 
    wire [31:0]alu_c; //alu结果
    assign alu_a = (asel==1'b1)? rf_rd2:rf_rd1; //alua的端口输入选择器
    assign alu_b = (bsel==2'b11)? ext_ext:(bsel==2'b10)? rf_rd2:rf_rd1; //alua的端口输入选择器
    
    assign rf_wd = (wdsel==2'b10)? npc_pc4:(wdsel==2'b01)? dm_rd:alu_c; //寄存器堆写回值的选择器
    
    assign rd = (wrsel==2'b10)? 5'd31:(wrsel==2'b01)? rt:im[15:11]; //寄存器堆写回寄存器地址选择
    
    assign dm_a = alu_c[13:0];
    
    ctrl ctrl(.op(op),.func(func),.zero(zero),.npcop(npcop),.extop(extop),.wdsel(wdsel),.wrsel(wrsel),
    .rfwr(rfwr),.dmwr(dmwr),.asel(asel),.bsel(bsel),.isjump(isjump),.aluop(aluop)); //控制器
    prgrom instmem(.clka(clka),.addra(pc_pc1),.douta(im)); //指令存储器
    ram dm(.clka(clkb),.wea(dmwr),.addra(dm_a),.dina(rf_rd2),.douta(dm_rd));//数据存储器
    npc npc(.pc(pc_pc),.imm(address),.ra(rf_rd1),.npcop(npcop),.isjump(isjump),.npc(npc_npc)); //npc
    pc pc(.reset(rst),.clk(clka),.pc_in(npc_npc),.pc_out(pc_pc));  //pc
    rf rf(.a1(rs),.a2(rt),.a3(rd),.wd(rf_wd),.rfwr(rfwr),.clk(clka),.rd1(rf_rd1),.rd2(rf_rd2)); //寄存器堆
    ext ext(.extin(imm),.extop(extop),.extout(ext_ext)); //立即数位扩展
    alu alu(.a(alu_a),.b(alu_b),.aluop(aluop),.c(alu_c),.zero(zero)); //alu
    
    always@(posedge clka) begin
        npc_pc4 <= pc_pc + 32'd4; //jal时给寄存器的返回地址
    end
        
    
       
    
    //debug信号
    //wire[31:0] debug_wb_pc; //查看PC 的值，连接PC
    //wire debug_wb_rf_wen; //查看寄存器堆的写使能，连接RFWr
    //wire[4:0] debug_wb_rf_wnum; //查看寄存器堆的目的寄存器号，连接目的寄存器A3
    //wire[31:0] debug_wb_rf_wdata; //查看寄存器堆的写数据，连接WD
    assign debug_wb_pc = pc_pc;
    assign debug_wb_rf_wen = (rst==1)? 1'b0:rfwr;
    assign debug_wb_rf_wnum = (rst==1)? 5'bxxxxx:rd;
    assign debug_wb_rf_wdata = rf_wd;
    
    //wire clock;
    assign clock = clka;
    
endmodule
