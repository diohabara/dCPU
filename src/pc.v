module pc (
    input clk,
    input rst,
    input [4:0] cpc,
    output [4:0] npc
    );

    initial begin
        clk = !clk;
    end

    always @(posedge clk) begin
        if (rst == 0)
            npc <= 0;
        else
            npc <= cpn + 2'b1;
    end
endmodule
