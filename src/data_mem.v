module data_mem(
    input clk,
    input wren,
    input is_store,
    input [4:0] r_addr,
    input [4:0] w_addr,
    input [31:0] w_data,
    output [31:0] r_data
    );

    reg [4:0] addr_reg;
    reg [`MAX_D_MEM:0] mem [0:31];

    always @(posedge clk) begin
        if (wren == 0)
            mem[addr_reg] <= w_data;
        addr_reg <= r_addr;
    end
    assign r_data = mem[addr_reg];
endmodule
