`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/03/2024 02:04:55 PM
// Design Name: 
// Module Name: BinaryToBCD
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


module BinaryToBCD(
    input [13:0] BIN,
    output reg [15:0] BCD
    );
    
    integer i;
    
    always @(BIN) begin
        BCD=0;             
        for (i=0;i<14;i=i+1) begin                    //Iterate once for each bit in input number
            if (BCD[3:0] >= 5) BCD[3:0] = BCD[3:0] + 3;        //If any BCD digit is >= 5, add three
            if (BCD[7:4] >= 5) BCD[7:4] = BCD[7:4] + 3;
            if (BCD[11:8] >= 5) BCD[11:8] = BCD[11:8] + 3;
            if (BCD[15:12] >= 5) BCD[15:12] = BCD[15:12] + 3;
            BCD = {BCD[14:0],BIN[13-i]};                //Shift one bit, and shift in proper bit from input 
        end
    end
endmodule
