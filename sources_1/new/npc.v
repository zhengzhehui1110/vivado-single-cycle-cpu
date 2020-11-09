`timescale 1ns / 1ps
`define PC+4  2'b00
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/22 21:54:16
// Design Name: 
// Module Name: npc
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


module npc(
input [31:0] pc,
input [25:0] imm,
input [31:0] ra,
input [1:0] npcop,
input isjump, //0:跳转条件不成立 1：跳转条件成立
output [31:0] npc
//output [31:0] pc4
    );
    wire [31:0]pc4;
    assign pc4 = pc + 32'd4;
    
    // (Sign-Extend) offset<<2
    wire [31:0] offset; //条件跳转需要的32位偏移量
    assign offset = {imm[15],imm[15],imm[15],imm[15],imm[15],imm[15],imm[15],imm[15],imm[15],imm[15],imm[15],imm[15],imm[15],imm[15],imm[15:0],2'b00};
    //(Zero-Extend) address<<2
    wire [31:0] address; //无条件跳转需要的直接下地址
    assign address = {4'b00,imm[25:0],2'b00};
    
    reg [31:0]npc1;
    assign npc = npc1;
    always@(*) begin
        case(npcop)
            2'b00:npc1 <= pc4; //顺序执行下一条
            2'b01:npc1 <= (isjump==1)? pc4 + offset:pc4; //条件跳转，如果isjump为1则符合跳转条件
            2'b10:npc1 <= ra; //无条件寄存器跳转
            2'b11:npc1 <= address ; //无条件跳转
        endcase
    end
    
endmodule
