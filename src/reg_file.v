module reg_file(
    input clk,
    input rst_n,
    input wren,
    input [4:0] rs_addr1,
    input [4:0] rs_addr2,
    input [4:0] rd_addr,
    input [31:0] reg_data,
    output [31:0] rs1,
    output [31:0] rs2
    );

    reg [31:0] rf [0:31];
    reg i;

    initial begin
        for (i = 0; i < 32; i = i + 1) begin
            rf[i] = 0;
        end
    end

    always @(negedge rst_n or posedge clk) begin
        if (rst_n == `DISABLE) begin
            rf[0] <= 0;
        end
        else if (wren == `ENABLE && rd_addr != 0) begin
            rf[rd_addr] <= reg_data;
        end
    end
    assign rs1 = rf[rs_addr1];
    assign rs2 = rf[rs_addr2];

endmodule
