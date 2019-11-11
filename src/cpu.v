module cpu(clk, rstd);
    input clk, rstd;
    wire [31:0] pc, ins, reg1, reg2, result, nextpc;,
    wire [4:0] wr_addr; // write address
    wire [3:0] wren;

    rom rom_body(clk, r_addr, r_data);
    fetch fetch_body(pc[7:0], ins);
    adder adder_body(pc, 4, nextpc);
    reg_file rf_body(clk, rstd, wr_addr);
endmodule