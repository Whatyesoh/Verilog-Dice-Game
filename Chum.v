`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/01/2024 04:00:04 PM
// Design Name: 
// Module Name: Chum
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

module Chum(
    input CLK,
    input Rb,
    input RESET,
    input NEXT,
    output [4:0] OUT,
    output [11:0] SEG_OUT
    );
    wire rollButton;
    
    wire goNext;
    
    wire [2:0] selected;
    
    reg [13:0] displayNum;
    
    wire [7:0] d100;
    wire [7:0] d20;
    wire [7:0] d12;
    wire [7:0] d10;
    wire [7:0] d8;
    wire [7:0] d6;
    wire [7:0] d4;
    
    wire trig20;
    wire trig12;
    wire trig100;
    wire trig10;
    wire trig8;
    wire trig6;
    
    always @(posedge CLK) begin
        case(selected)
            3'b000 : displayNum <= 14'd2000 + d20;
            3'b001 : displayNum <= 14'd1200 + d12;
            3'b010 : displayNum <= 14'd1000 + d100;
            3'b011 : displayNum <= 14'd1000 + d10;
            3'b100 : displayNum <= 14'd0800 + d8;
            3'b101 : displayNum <= 14'd0600 + d6;
            3'b110 : displayNum <= 14'd0400 + d4;
            3'b111 : displayNum <= 0;
        endcase
    end
    
    //Get positive edge for goNext
    Button_handle buttonNext (
        .CLK(CLK),
        .IN(NEXT),
        .OUT(goNext)
    );
    
    //Limit button press
    Button_handle buttonRoll (
        .CLK(CLK),
        .IN(Rb),
        .OUT(rollButton)
    );
    
    //Dice
    Generic_die # (
        .DIE_WIDTH(8),
        .DIE_MAX(20)
    ) D20 (
        .CLK(CLK),
        .ENABLE(1'b1),
        .GET_NUM(rollButton),
        .COUNT(d20),
        .RESET(RESET),
        .TRIG_OUT(trig20)
    );
    
    Generic_die # (
        .DIE_WIDTH(8),
        .DIE_MAX(12)
    ) D12 (
        .CLK(CLK),
        .ENABLE(trig20),
        .GET_NUM(rollButton),
        .COUNT(d12),
        .RESET(RESET),
        .TRIG_OUT(trig12)
    );
    
    Generic_die # (
        .DIE_WIDTH(8),
        .DIE_MAX(10)
    ) D100 (
        .CLK(CLK),
        .ENABLE(trig12),
        .GET_NUM(rollButton),
        .COUNT(d100),
        .RESET(RESET),
        .TRIG_OUT(trig100)
    );
    
    Generic_die # (
        .DIE_WIDTH(8),
        .DIE_MAX(10)
    ) D10 (
        .CLK(CLK),
        .ENABLE(trig100),
        .GET_NUM(rollButton),
        .COUNT(d10),
        .RESET(RESET),
        .TRIG_OUT(trig10)
    );
    
    Generic_die # (
        .DIE_WIDTH(8),
        .DIE_MAX(8)
    ) D8 (
        .CLK(CLK),
        .ENABLE(trig10),
        .GET_NUM(rollButton),
        .COUNT(d8),
        .RESET(RESET),
        .TRIG_OUT(trig8)
    );
    
    Generic_die # (
        .DIE_WIDTH(8),
        .DIE_MAX(6)
    ) D6 (
        .CLK(CLK),
        .ENABLE(trig8),
        .GET_NUM(rollButton),
        .COUNT(d6),
        .RESET(RESET),
        .TRIG_OUT(trig6)
    );
    
    Generic_die # (
        .DIE_WIDTH(8),
        .DIE_MAX(4)
    ) D4 (
        .CLK(CLK),
        .ENABLE(trig6),
        .GET_NUM(rollButton),
        .COUNT(d4),
        .RESET(RESET)
    );
    
    //Count when NEXT is pressed
    Generic_counter # (
        .COUNTER_WIDTH(3),
        .COUNTER_MAX(6)
    ) DieSelect (
        .CLK(CLK),
        .ENABLE(goNext),
        .RESET(1'b0),
        .COUNT(selected)
    );

    //Display dice
    NumTo7Seg display(
        .CLK(CLK),
        .BIN(displayNum),
        .SEG_OUT(SEG_OUT),
        .DOT(4'b1011)
    );
endmodule
