module mem(
    input clk,
    input [31:0] r_addr,
    output [31:0] ins
    );

    reg [31:0] reg_addr;
    reg [31:0] mem [0:`MAX_MEM];

    initial begin
        reg_addr = 0;
        $readmemh("/home/denjo/Documents/process/dCPU/benchmarks/tests/IntRegImm/code.hex", mem);
    end

    always @(posedge clk) begin
        reg_addr <= r_addr;
    end
    assign ins = mem[reg_addr];
endmodule
