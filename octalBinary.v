`timescale 1ns / 1ps

module octalBinary(
    input zero,one,two,three,four,five,six,seven,
    output Y3,
    output Y2,
    output Y1
    );
    
    assign Y3 = four | five | six | seven;
    assign Y2 = two | three | six | seven;
    assign Y1 = one | three | five | seven;    
    
endmodule
