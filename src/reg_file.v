module reg_file(
    clk, rstd, wr_reg, r_addr1, r_addr2, wr_addr, wren, r_reg1, r_reg2, reg_file
);
    input clk, rstd, wren;
    input [31:0] wr_reg;
    input [4:0] r_addr1, r_addr2, wr_addr;
    output [31:0] r_reg1, r_reg2;
    output [31:0] reg_file;
    reg [31:0] rf [31:0];

    assign r_reg1 = rf[r_addr1];
    assign r_reg2 = rf[r_addr2];
    always @(negedge rstd or posedge clk) begin
        if (rstd == 0)
            rf[0] <= 32'h0;
        else if (wren == 0)
            rf[wr_addr] <= wr;
    end
    assign reg_file = rf[wr_addr];
endmodule // reg_file