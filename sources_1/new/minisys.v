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
    
    wire clka; //23MHzʱ��
    cpuclk clk0(.clk_in1(clk),.clk_out1(clka));
    wire clkb; //����ʱ�ӣ�ramר��
    assign clkb = !clka;
    
    wire [31:0]im; //ָ��洢��ȡ����ָ��
    wire [31:0]pc_pc; //��ǰָ��ĵ�ַ
    wire [13:0]pc_pc1; //��ǰָ��ġ�15:2��
    assign pc_pc1 = pc_pc[15:2];
    wire [31:0]npc_npc;
    reg [31:0]npc_pc4;
    
    
    //wire DMWr; //���ݴ洢��дʹ��
    wire [13:0]dm_a; //�������ݴ洢���ĵ�ַ
    wire [31:0]dm_rd; //ȡ�����ݴ洢��������
    
    wire [5:0]op; //ָ���op����
    wire [5:0]func; //ָ���func����
    wire [4:0]rs; //������1���Ĵ�����ţ�
    wire [4:0]rt; //������2���Ĵ�����ţ�
    wire [4:0]rd; //д�ؼĴ������
    wire [15:0]imm; //ָ���е�������
    wire [25:0]address; //ָ���еĵ�ַaddress
    assign op = im[31:26];
    assign func = im[5:0];
    assign rs = im[25:21];
    assign rt = im[20:16];
    assign imm = im[15:0];
    assign address = im[25:0];
    
    
    wire [1:0]zero; //alu�����0��־λ
    wire [1:0]npcop; //����npc�����ɷ�ʽ
    wire [1:0]extop; //����ext��������λ��չ��ʽ
    wire [1:0]wdsel; //���ƼĴ���д��ֵ��ѡ��ʽ
    wire [1:0]wrsel; //���ƼĴ���д�ص�ַ��ѡ��ʽ
    wire rfwr; //�Ĵ�����дʹ��
    wire dmwr; //���ݴ洢��дʹ��
    wire asel; //alua����ֵ��ѡ��
    wire [1:0]bsel; //alub����ֵ��ѡ��
    wire isjump; //������ת���ж��Ƿ������ת
    wire [3:0]aluop; //����alu�Ĺ���
    
    wire [31:0]ext_ext; //������λ��չ���
    
    wire [31:0]rf_rd1; //�Ĵ����Ѷ���1
    wire [31:0]rf_rd2; //�Ĵ����Ѷ���2
    wire [31:0]rf_wd; //�Ĵ����ѵ�д��ֵ
    
    wire [31:0]alu_a; //alu ������
    wire [31:0]alu_b; 
    wire [31:0]alu_c; //alu���
    assign alu_a = (asel==1'b1)? rf_rd2:rf_rd1; //alua�Ķ˿�����ѡ����
    assign alu_b = (bsel==2'b11)? ext_ext:(bsel==2'b10)? rf_rd2:rf_rd1; //alua�Ķ˿�����ѡ����
    
    assign rf_wd = (wdsel==2'b10)? npc_pc4:(wdsel==2'b01)? dm_rd:alu_c; //�Ĵ�����д��ֵ��ѡ����
    
    assign rd = (wrsel==2'b10)? 5'd31:(wrsel==2'b01)? rt:im[15:11]; //�Ĵ�����д�ؼĴ�����ַѡ��
    
    assign dm_a = alu_c[13:0];
    
    ctrl ctrl(.op(op),.func(func),.zero(zero),.npcop(npcop),.extop(extop),.wdsel(wdsel),.wrsel(wrsel),
    .rfwr(rfwr),.dmwr(dmwr),.asel(asel),.bsel(bsel),.isjump(isjump),.aluop(aluop)); //������
    prgrom instmem(.clka(clka),.addra(pc_pc1),.douta(im)); //ָ��洢��
    ram dm(.clka(clkb),.wea(dmwr),.addra(dm_a),.dina(rf_rd2),.douta(dm_rd));//���ݴ洢��
    npc npc(.pc(pc_pc),.imm(address),.ra(rf_rd1),.npcop(npcop),.isjump(isjump),.npc(npc_npc)); //npc
    pc pc(.reset(rst),.clk(clka),.pc_in(npc_npc),.pc_out(pc_pc));  //pc
    rf rf(.a1(rs),.a2(rt),.a3(rd),.wd(rf_wd),.rfwr(rfwr),.clk(clka),.rd1(rf_rd1),.rd2(rf_rd2)); //�Ĵ�����
    ext ext(.extin(imm),.extop(extop),.extout(ext_ext)); //������λ��չ
    alu alu(.a(alu_a),.b(alu_b),.aluop(aluop),.c(alu_c),.zero(zero)); //alu
    
    always@(posedge clka) begin
        npc_pc4 <= pc_pc + 32'd4; //jalʱ���Ĵ����ķ��ص�ַ
    end
        
    
       
    
    //debug�ź�
    //wire[31:0] debug_wb_pc; //�鿴PC ��ֵ������PC
    //wire debug_wb_rf_wen; //�鿴�Ĵ����ѵ�дʹ�ܣ�����RFWr
    //wire[4:0] debug_wb_rf_wnum; //�鿴�Ĵ����ѵ�Ŀ�ļĴ����ţ�����Ŀ�ļĴ���A3
    //wire[31:0] debug_wb_rf_wdata; //�鿴�Ĵ����ѵ�д���ݣ�����WD
    assign debug_wb_pc = pc_pc;
    assign debug_wb_rf_wen = (rst==1)? 1'b0:rfwr;
    assign debug_wb_rf_wnum = (rst==1)? 5'bxxxxx:rd;
    assign debug_wb_rf_wdata = rf_wd;
    
    //wire clock;
    assign clock = clka;
    
endmodule
