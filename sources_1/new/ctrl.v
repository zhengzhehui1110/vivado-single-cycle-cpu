`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/25 16:56:51
// Design Name: 
// Module Name: ctrl
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
`include "para.v"

module ctrl(
input [5:0]op,func,
input [1:0]zero,
output [1:0]npcop,extop,wdsel,wrsel,bsel,
output rfwr,dmwr,asel,isjump,
output [3:0]aluop
    );
    //11：无条件直接跳转 10：无条件寄存器跳转 01：条件跳转 00：PC+4
    assign npcop = (op==`OP_J||op==`OP_JAL)? 2'b11:(func==`FUNC_JR&&op==6'h00)? 2'b10:(op==`OP_BEQ||op==`OP_BNE||op==`OP_BGTZ)? 2'b01:2'b00;
    
    //beq:等于0则转移 bne:不等于0则转移 bgtz:大于0则转移
    assign isjump = ((op==`OP_BEQ&&zero==2'b01)||(op==`OP_BNE&&zero!=2'b01)||(op==`OP_BGTZ&&zero==2'b00))? 1'b1:1'b0;
    
    //00：【10:6】零扩展 10：【15:0】零扩展 11：【15:0】符号扩展
    assign extop = (op==6'h00&&(func==`FUNC_SLL||func==`FUNC_SRL||func==`FUNC_SRA))? 2'b00:(op==`OP_ANDI||op==`OP_ORI||op==`OP_XORI||op==`OP_LUI)? 2'b10:2'b11;
    
    //10: 0x1F 01:IM.D[20:16] 00:IM.D[15:11]
    assign wrsel = (op==`OP_JAL)? 2'b10:(op==`OP_ADDI||op==`OP_ADDIU||op==`OP_ANDI||op==`OP_ORI||op==`OP_XORI||op==`OP_SLTIU||op==`OP_LUI||op==`OP_LW)? 2'b01:2'b00;
    
    //10:NPC.PC4 01:DM.RD 00:ALU.C
    assign wdsel = (op==`OP_JAL)? 2'b10:(op==`OP_LW)? 2'b01:2'b00;
    
    //寄存器写使能，高电平有效
    assign rfwr = (op==`OP_J||op==`OP_SW||op==`OP_BEQ||op==`OP_BNE||op==`OP_BGTZ||(op==6'h00&&func==`FUNC_JR))? 1'b0:1'b1;
    
    //数据存储器写使能，高电平有效
    assign dmwr = (op==`OP_SW)? 1'b1:1'b0;
    
    //alu.a输入选择器，1：RF.RD2; 0:RF.RD1
    assign asel = (op==6'h00&&(func==`FUNC_SLL||func==`FUNC_SRL||func==`FUNC_SRA||func==`FUNC_SLLV||func==`FUNC_SRLV||func==`FUNC_SRAV))? 1'b1:1'b0;
    
    //alu.b输入选择器，11：ext； 10：RF.RD2 00:RF.RD1
    assign bsel = ((op==6'h00&&(func==`FUNC_SLL||func==`FUNC_SRL||func==`FUNC_SRA))||(op==`OP_ADDI||op==`OP_ADDIU||op==`OP_ANDI||op==`OP_ORI||op==`OP_XORI||op==`OP_SLTIU||op==`OP_LUI||op==`OP_LW||op==`OP_SW))? 
    2'b11:(op==6'h00&&(func==`FUNC_SLLV||func==`FUNC_SRLV||func==`FUNC_SRAV))? 2'b00:2'b10;
    
    reg [3:0]aluop1;
    assign aluop = aluop1;
    always@(*) begin
        if(op==6'h00) begin
            if(func==`FUNC_ADD||func==`FUNC_ADDU) aluop1 <= `ADD;
            else if(func==`FUNC_SUB||func==`FUNC_SUBU) aluop1 <= `SUB;
            else if(func==`FUNC_AND) aluop1 <= `AND;
            else if(func==`FUNC_OR) aluop1 <= `OR;
            else if(func==`FUNC_XOR) aluop1 <= `XOR;
            else if(func==`FUNC_NOR) aluop1 <= `NOR;
            else if(func==`FUNC_SLL||func==`FUNC_SLLV) aluop1 <= `SLL;
            else if(func==`FUNC_SRL||func==`FUNC_SRLV) aluop1 <= `SRL;
            else if(func==`FUNC_SRA||func==`FUNC_SRAV) aluop1 <= `SRA;
            else if(func==`FUNC_SLT) aluop1 <= `SLT;
            else if(func==`FUNC_SLTU) aluop1 <= `SLTU;
        end
        else begin
            if(op==`OP_ADDI||op==`OP_ADDIU||op==`OP_LW||op==`OP_SW) aluop1 <= `ADD;
            else if(op==`OP_BEQ||op==`OP_BNE) aluop1 <= `SUB;
            else if(op==`OP_ANDI) aluop1 <= `AND;
            else if(op==`OP_ORI) aluop1 <= `OR;
            else if(op==`OP_XORI) aluop1 <= `XOR;
            else if(op==`OP_LUI) aluop1 <= `LUI;
            else if(op==`OP_SLTIU) aluop1 <= `SLTU;
            else if(op==`OP_BGTZ) aluop1 <= `BGTZ;
        end
    end
endmodule
