`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/03 16:14:05
// Design Name: 
// Module Name: rf_sim
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


module rf_sim(

    );
    
    reg [4:0]a1,a2,a3;
    reg [31:0]wd;
    reg rfwr;
    reg clk = 1'b0;
    wire [31:0]rd1,rd2;
    
    rf rf(.a1(a1),.a2(a2),.a3(a3),.wd(wd),.rfwr(rfwr),.clk(clk),.rd1(rd1),.rd2(rd2));
    
    always #10 clk = ~clk;
    
    initial begin
    #0 begin rfwr = 1'b1; a3 = 5'd1; wd = 32'd1; end
    #20 begin a3 = 5'd2; wd = 32'd2; end
    #40 begin a3 = 5'd3; wd = 32'd3; end
    #60 begin a3 = 5'd4; wd = 32'd4; end
    #80 begin a3 = 5'd5; wd = 32'd5; end
    #100 begin a3 = 5'd6; wd = 32'd6; end
    #120 begin a3 = 5'd7; wd = 32'd7; end
    #140 begin a3 = 5'd8; wd = 32'd8; end
    #160 begin a3 = 5'd9; wd = 32'd9; end
    #200 begin rfwr = 1'b0; a1 = 5'd0; a2 = 5'd1;end
    #220 begin a1 = 5'd2; a2 = 5'd3;end
    #240 begin a1 = 5'd4; a2 = 5'd5;end
    #260 begin a1 = 5'd6; a2 = 5'd7;end
    #280 begin a1 = 5'd8; a2 = 5'd9;end
    end
    
    
endmodule
