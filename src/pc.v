module pc (
    input clk,
    input rst_n,
    input br_taken,
    input [31:0] alu_result,
    output reg [31:0] pc
    );

    always @(posedge clk) begin
        if (rst_n == `DISABLE)
            pc <= 32'h8000;
        else if (br_taken == `ENABLE)
            pc <= pc + alu_result;
        else
            pc <= pc + 32'd4;
    end
endmodule
