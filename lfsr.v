`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.01.2023 17:32:18
// Design Name: 
// Module Name: lfsr
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

module lfsr (input clk, input reset, output reg [3:0] Q, input[3:0] load);
  reg flag;
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      Q <= 4'b0000;
      flag=0;
    end else begin
      if(flag==0)
      begin
        Q=load;
        flag=1;
      end
      Q <= {Q[0] ^ Q[1], Q[3], Q[2], Q[1]};
    end
  end
endmodule