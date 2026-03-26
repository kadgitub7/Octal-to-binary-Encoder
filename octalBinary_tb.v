`timescale 1ns / 1ps

module octalBinary_tb();
    reg zero,one,two,three,four,five,six,seven;
    wire Y3,Y2,Y1;
    
    octalBinary uut(zero,one,two,three,four,five,six,seven,Y3,Y2,Y1);
    
    task clear_inputs;
    begin
        zero = 0; one = 0; two = 0; three = 0; four = 0;
        five = 0; six = 0; seven = 0;
    end
    endtask
    
    initial begin
       clear_inputs; zero = 1;
       #10 $display("0 -> %b%b%b", Y3,Y2,Y1);

        clear_inputs; one = 1;
        #10 $display("1 -> %b%b%b", Y3,Y2,Y1);

        clear_inputs; two = 1;
        #10 $display("2 -> %b%b%b", Y3,Y2,Y1);

        clear_inputs; three = 1;
        #10 $display("3 -> %b%b%b", Y3,Y2,Y1);

        clear_inputs; four = 1;
        #10 $display("4 -> %b%b%b", Y3,Y2,Y1);

        clear_inputs; five = 1;
        #10 $display("5 -> %b%b%b", Y3,Y2,Y1);

        clear_inputs; six = 1;
        #10 $display("6 -> %b%b%b", Y3,Y2,Y1);

        clear_inputs; seven = 1;
        #10 $display("7 -> %b%b%b", Y3,Y2,Y1);
    end
endmodule
