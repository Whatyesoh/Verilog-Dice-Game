`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/03/2024 02:10:40 PM
// Design Name: 
// Module Name: NumTo7Seg
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


module NumTo7Seg(
    input CLK,
    input [13:0] BIN,
    input [3:0] DOT,
    output [11:0] SEG_OUT
    );
    
    wire [15:0] num;
    wire TrigOut17;
    wire [1:0] SegSelect;
    wire [3:0] MuxOut;
    
    BinaryToBCD converter(
        .BIN(BIN),
        .BCD(num)
    );
    
    Generic_counter # (
        .COUNTER_WIDTH(17),
        .COUNTER_MAX(99999)
    ) Bit17Counter (
        .CLK(CLK),
        .RESET(1'b0),
        .ENABLE(1'b1),
        .TRIG_OUT(TrigOut17)
    );
    
    Generic_counter # (
        .COUNTER_WIDTH(2),
        .COUNTER_MAX(3)
    ) Bit2Counter (
        .CLK(CLK),
        .RESET(1'b0),
        .ENABLE(TrigOut17),
        .COUNT(SegSelect)
    );
    
    Multiplexer mux (
        .SELECT(SegSelect),
        .IN1(num[3:0]),
        .IN2(num[7:4]),
        .IN3(num[11:8]),
        .IN4(num[15:12]),
        .OUT(MuxOut)
    );
    
    Seg7Display seg7 (
        .SEG_SELECT_IN(SegSelect),
        .BIN_IN(MuxOut),
        .DOT_IN(DOT[SegSelect]),
        .SEG_SELECT_OUT(SEG_OUT[11:8]),
        .HEX_OUT(SEG_OUT[7:0])
    );
    
endmodule
