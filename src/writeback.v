module writeback(clk, rstd, nextpc, pc);
    input clk, rstd;
    input [31:0] nextpc;
    output [31:0] pc;
    reg [31:0] pc;

    always @(negedge rstd or posedge clk) begin
        if (rstd == 0)
            pc <= 32'h0;
        else if (clk == 1)
            pc <= nextpc;
    end
endmodule