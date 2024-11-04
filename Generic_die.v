`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/02/2024 07:32:00 AM
// Design Name: 
// Module Name: Generic_die
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


module Generic_die(
    CLK,
    ENABLE,
    GET_NUM,
    TRIG_OUT,
    COUNT,
    RESET
    );
    
    parameter DIE_WIDTH = 4;
    parameter DIE_MAX = 9;
    
    input CLK;
    input ENABLE;
    input GET_NUM;
    input RESET;
    output TRIG_OUT;
    output reg [DIE_WIDTH-1:0] COUNT;
    
    reg [DIE_WIDTH-1:0] count_value = 0;
    reg Trigger_out;
    
    always@(posedge CLK) begin
        if (ENABLE) begin
            if (count_value == DIE_MAX)
                count_value <= 1;
            else
                count_value <= count_value + 1;
        end
    end
    
    always@(posedge CLK) begin
        if (ENABLE && (count_value == DIE_MAX))
            Trigger_out <= 1;
        else
            Trigger_out <= 0;
    end
    
    always @(posedge CLK) begin
        if(RESET)
            COUNT <= 0;
        else begin
            if (GET_NUM)
                COUNT <= count_value;
        end
    end
    
    assign TRIG_OUT = Trigger_out;
endmodule
