module pc (
    input clk,
    input rst_n,
    input br_taken,
    input [31:0] result,
    output reg [4:0] pc
    );

    always @(posedge clk) begin
        if (rst_n == `DISABLE)
            pc <= 0;
        else
            pc <= pc + 4;
    end
endmodule
