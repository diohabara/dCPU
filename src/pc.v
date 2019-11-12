module pc (
    input clk;
    input rst;
    input br_taken;
    input [31:0] cpc;
    output [31:0] npc;
    );

    initial begin
        clk = !clk;
    end

    always @(posedge clk) begin
        if (rst)
            npc <= 0;
        else
            npc <= cpn + 4;
    end
endmodule
