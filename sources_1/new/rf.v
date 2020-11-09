`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/24 23:59:09
// Design Name: 
// Module Name: rf
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


module rf(
input [4:0]a1,a2,a3,
input [31:0]wd,
input rfwr,clk, //rfwr:写使能，高电平有效
output [31:0]rd1,rd2
    );
    reg [31:0]store[31:0];
    
    always@(posedge clk) begin //时钟上升沿写回
        if(rfwr==1) store[a3] <= wd;
    end
    assign rd1 = (a1==0)? 31'd0:store[a1];
    assign rd2 = (a2==0)? 31'd0:store[a2]; //读出的两个操作数
    //$0只能读出0
endmodule
