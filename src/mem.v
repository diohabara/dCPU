module mem(
    input clk,
    input [31:0] r_addr,
    output [31:0] ins
    );

    reg [31:0] addr_reg;
    reg [31:0] mem [0:`MAX_MEM];

    initial
        $readmemh("/home/denjo/Documents/process/dCPU/benchmarks/tests/ControlTransfer/code.hex", mem);

    always @(posedge clk) begin
        addr_reg <= r_addr;
    end
    assign ins = mem[addr_reg];
endmodule
