`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/04/2024 09:07:21 AM
// Design Name: 
// Module Name: Button_handle
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


module Button_handle(
    input CLK,
    input IN,
    output reg OUT
    );
    
    reg held = 0;
    reg ready = 1;
    wire timerReady;
    
    Generic_counter # (
        .COUNTER_WIDTH(25),
        .COUNTER_MAX(29999999)
    ) Timer (
        .CLK(CLK),
        .ENABLE(1'b1),
        .RESET(1'b0),
        .TRIG_OUT(timerReady)
    );
    
    always@(posedge CLK) begin
        if (timerReady)
              ready = 1;
        if (IN) begin
            if (held == 0 && ready == 1) begin
                ready = 0;
                OUT = 1;
            end else
                OUT = 0;
            held = 1;
        end else begin
            OUT = 0;
            held = 0;
        end
    end
    
endmodule
