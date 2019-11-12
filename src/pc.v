module pc (
    input clk,
    input rst,
    input br_taken,
    input [31:0] result,
    input [4:0] cpc,
    output reg [4:0] npc
    );

    always @(posedge clk) begin
        if (rst == 0)
            npc <= 0;
        else
            npc <= cpc + 2'b1;
    end
endmodule
