`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/25 00:13:07
// Design Name: 
// Module Name: ext
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


module ext(
input [15:0] extin,
input [1:0]extop,
output [31:0] extout
    );
    //extop: 00,[10:6]zero extend;10,[15:0]zero extend;11,[15:0]sign extend
    wire [31:0]extout00;
    wire [31:0]extout10;
    wire [31:0]extout11;
    assign extout00 = {27'd0,extin[10:6]};
    assign extout10 = {16'd0,extin[15:0]};
    assign extout11 = (extin[15]==1)? {16'h0ffff,extin[15:0]}:{16'h0000,extin[15:0]};
    assign extout = (extop==2'b00)? extout00:(extop==2'b10)? extout10:extout11;
    
endmodule
