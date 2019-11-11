module adder(inLeft, inRight, result);
    input [3:0] inLeft;
    input [3:0] inRight;
    output [4:0] result;

    assign result = inLeft + inRight;
endmodule