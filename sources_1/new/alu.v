`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/24 21:18:55
// Design Name: 
// Module Name: alu
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

module alu(
input [31:0]a,b,
input [3:0]aluop,
output [31:0] c,
output [1:0] zero
    );
    
    assign zero = (c==31'd0)? 2'b01:(c[31]==0)?2'b00:2'b10; //����0:00������0��01��С��0��10
    
    reg [31:0] c1;
    assign c = c1;
    
    always@(*) begin
        case(aluop)
            `ADD:c1 <= a + b;
            `SUB:c1 <= a - b;
            `AND:c1 <= a & b;
            `OR:c1 <= a | b;
            `XOR:c1 <= a ^ b;
            `NOR:c1 <= ~(a | b);
            `SLL:c1 <= a << b;
            `SRL:c1 <= a >> b;
            `SRA:c1 <= ($signed(a)) >>> b;
            `LUI:c1 <= {b[16:0],16'h0000};
            `SLTU:c1 <= (a<b)? 31'd1:31'd0;
            `SLT:begin
                    if({a[31],b[31]}==2'b00) c1 <= (a<b)? 31'd1:31'd0; //��������
                    else if({a[31],b[31]}==2'b01) c1 <= 31'd0; //a��b��
                    else if({a[31],b[31]}==2'b10) c1 <= 31'd1; //a��b��
                    else c1 <= (a<b)? 31'd1:31'd0; //���Ǹ���
                end
            `BGTZ:c1 <= a; //rd1��0�Ƚ�
        endcase
    end
    
    
endmodule
