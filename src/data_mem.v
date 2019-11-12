module data_mem(
    input clk, rst;
    input  [4:0] r_addr;
    output [31:0] r_data;
    );

    reg [4:0] addr_reg;
    reg [31:0] mem [0:31]

    always @(negedge rst or posedge clk) begin
        if (rst == 0)
            mem[]
        addr_reg <= r_addr;
    end
    assign r_data = mem[addr_reg];
endmodule
