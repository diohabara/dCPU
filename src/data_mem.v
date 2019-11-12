module data_mem(
    input clk, wren;
    input [4:0] r_addr;
    input [4:0] wr_addr;
    input [31:0] wr_data;
    output [31:0] r_data;
    );

    reg [4:0] addr_reg;
    reg [31:0] mem [0:31];
    always @(posedge clk) begin
        if (wren) mem[wr_addr] <= wr_data;
        addr_reg <= r_addr;
    end
    assign r_data = mem[addr_reg];
endmodule
