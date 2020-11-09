`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/22 20:20:42
// Design Name: 
// Module Name: pc
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


module pc(
input reset,clk,
input[31:0] pc_in,
output reg [31:0] pc_out
    );
    reg flag;
    always@(negedge clk) begin
        pc_out <= (reset==1||flag==0)?31'd0:pc_in;
        flag <= (reset==1)? 1'b0:(flag==0)? 1'b1:flag;
    end
    
endmodule
