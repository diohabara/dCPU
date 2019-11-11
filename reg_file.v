module reg_file(
    clk, rstd, wr, ra1, ra2, wa, wren, rr1, rr2
    );
    input clk, rstd, wren
    input [31:0] wr;
    input [4:0] ra1, ra2, wa;
    output [31:0] rr1, rr2;
    reg [31:0] rf [31:0];

    assign rr1 = rf[ra1];
    assign rr2 = rf[ra2];
    always @(negedge rstd or posedge clk) begin
        if (rstd == 0)
            rf[0] <= 32'h0;
        else if (wren == 0)
            rf[wa] <= wr;
    end
endmodule // reg_file