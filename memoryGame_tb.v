`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.01.2023 11:43:35
// Design Name: 
// Module Name: memoryGame
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

module memoryGame_tb;
    reg clk, reset, submit;
    reg [7:0] x,load;
    wire [7:0]display,qn,temp,inp;
    wire [1:0]result;
    wire [1:0]state;
    memoryGame hiw(clk, x, submit, reset, load, display, result,qn,temp,inp,state);
    
    initial
    clk=1;
    
    
    always begin
    clk=~clk;
    #5;
    end
    
    initial begin
    reset=1;
    load=15;
    reset=0; x=8'b00101110; submit=0; #10;
    reset=0; x=8'b10010101; submit=0; #10;
    reset=0; x=8'b00101110; submit=0; #10;
    reset=0; x=8'b01000011; submit=1; #20;
    reset=0; x=8'b11100110; submit=0; #10;
    reset=0; x=8'b10101110; submit=0; #10;
    reset=0; x=8'b00101111; submit=0; #10;
    reset=0; x=8'b00000111; submit=1; #10;
    reset=0; x=8'b10110110; submit=1; #10;
    reset=1; x=8'b01101011; submit=0; #10;
    reset=0; x=8'b10101100; submit=1; #10;
    reset=0; x=8'b01100101; submit=0; #10;
    reset=0; x=8'b11101110; submit=0; #10;
    $finish;
    end
endmodule
