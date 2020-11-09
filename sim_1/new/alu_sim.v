`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/03 16:37:29
// Design Name: 
// Module Name: alu_sim
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
`define  ADD  4'b0000
`define  SUB  4'b0001
`define  AND  4'b0010
`define  OR   4'b0011
`define  XOR  4'b0100
`define  NOR  4'b0101
`define  SLL  4'b0110
`define  SRL  4'b0111  
`define  SRA  4'b1000
`define  LUI  4'b1001
`define  SLT  4'b1010
`define  SLTU 4'b1011
`define  BGTZ 4'b1100

module alu_sim(

    );
    
    reg [31:0]a,b;
    reg [3:0]aluop;
    wire [31:0] c;
    wire [1:0] zero;
    
    alu alu(.a(a),.b(b),.c(c),.aluop(aluop),.zero(zero));
    
    initial begin
    #0 begin a = 32'd5; b = 32'd4; aluop = `ADD; end //5+4
    #20 begin a = 32'd5; b = 32'd4; aluop = `SUB; end //5-4
    #40 begin a = 32'd5; b = 32'd5; aluop = `SUB; end //5-5
    #60 begin a = 32'hff000000; b = 32'd4; aluop = `SLL; end //ff00 0000 << 4
    #80 begin a = 32'hff000000; b = 32'd4; aluop = `SRA; end //ff00 0000 >>> 4
    #100 begin a = 32'hffffffff; b = 32'd0; aluop = `SLT; end //slt -1 0
    #100 begin a = 32'd5; aluop = `BGTZ; end //bgtz 5
    #120 begin a = 32'h0f0f0f0f; b = 32'h0c0c0c0c; aluop = `XOR; end //0f0f 0f0f xor 0c0c 0c0c;
    end


endmodule
