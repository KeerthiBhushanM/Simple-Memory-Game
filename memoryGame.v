`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.01.2023 11:40:10
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

// module instantiation
module memoryGame(input clk, input [7:0]x, input submit, input reset,input [7:0]load, 
                  output reg [7:0]display, output reg [1:0]result, output qn, output temp, output inp, output ps);
    // port declarations
    reg [7:0]temp,inp;              // temp=the value of LFSR @ state S1, inp= the value of input(x) at state S2 before submit 
    reg [7:0]qn;                    // output of LFSR
    parameter s0=0,s1=1,s2=2,s3=3;  // state assignments (decimal)
    reg [1:0]ps, ns;                // present and next state
    reg flag;                       // to load the LFSR
    
    //I want the machine to initially start with state s0 with the value of LFSR output as 9
    initial begin
    ps=s0;                         
    qn=9;
    end
    
    // LFSR and State Transition with reset functionality  
    always @(posedge clk or posedge reset) begin
        if (reset) begin
          qn <= 0;
          flag=0;
          ps<=s0;
        end else begin
          if(flag==0)
          begin
            qn=load;
            flag=1;
          end
          qn <= {qn[7] ^ qn[0], qn[7], qn[6], qn[5],qn[4],qn[3],qn[2],qn[1]};
          ps<=ns;
        end
        
    end
    
    // Next State Logic according to our FSM
    always@(posedge clk, ps) begin
        case(ps)
        s0: begin          // Reset the reading of previous states
            result<=0;
            display<=0;
            ns<=s1;
            inp<=0;
        end
        s1: begin         // Display the LFSR sequence and store it in temp
            result<=0;
            display <= qn;
            temp<=qn;
            ns<=s2;
        end
        s2: begin        // Wait until user inputs sequence and turns submit turns 1, store it in a inp variable 
        if(submit) begin
            result<=0;
            display <= 0;
            ns=s3;
            inp<=x;
        end
        else begin
            result<=0;
            display <= 0;
            ns<=s2;
        end
        end
        s3: begin       // Evaluate the result and display it 
            display <= 0;
            ns<=s0;
            if(inp=={temp[0],temp[1],temp[2],temp[3],temp[4],temp[5],temp[6],temp[7]})   // reversing the sequence logic
            result=2;       //correct
            else
            result=1;       //incorrect
        end
        endcase
    end
endmodule