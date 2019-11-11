module ram(clk, wren, r_addr, r_data, w_addr, w_data);
    input clk, wren;
    input [4:0] r_addr, w_addr;
    input [31:0] w_data;
    output [31:0] r_data;
    reg [4:0] addr_reg;
    reg [31:0] mem [0:31];
    always @(posedge clk) begin
        if (wren) mem[w_addr] <= w_data; //書き込みのタイミングを同期
        addr_reg <= r_addr;           //読み出しアドレスを同期
    end
    assign r_data = mem[addr_reg];
endmodule
