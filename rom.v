module rom(clk, r_addr, r_data);
    input clk;
    input  [4:0] r_addr;
    output [31:0] r_data;
    reg [4:0] addr_reg;
    reg [31:0] mem [0:31]
    always @(posedge clk) begin
        addr_reg <= r_addr;           //読み出しアドレスを同期
    end
    assign r_data = mem[addr_reg];
endmodule