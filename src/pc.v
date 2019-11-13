module pc (
    input clk,
    input rst_n,
    input br_taken,
    input [31:0] alu_result,
    output reg [4:0] pc
    );

    always @(posedge clk) begin
        if (rst_n == `DISABLE)
            pc <= 0;
        else if (br_taken == `ENABLE)
            pc <= pc + alu_result;
        else
            pc <= pc + 4;
    end
endmodule
