`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/03/2024 02:24:10 PM
// Design Name: 
// Module Name: Multiplexer
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


module Multiplexer(
    input [1:0] SELECT,
    input [3:0] IN1,
    input [3:0] IN2,
    input [3:0] IN3,
    input [3:0] IN4,
    output reg [3:0] OUT
    );
    
    always @(SELECT or IN1 or IN2 or IN3 or IN4) begin
        case(SELECT)
            2'b00 : OUT <= IN1;
            2'b01 : OUT <= IN2;
            2'b10 : OUT <= IN3;
            2'b11 : OUT <= IN4;
        endcase
    end
endmodule
