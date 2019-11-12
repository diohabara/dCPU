module reg_file(
    input clk;
    input wren;
    input rst;
    input [4:0] rs_addr1;
    input [4:0] rs_addr2;
    input [4:0] rd_addr;
    output [31:0] opr1;
    output [31:0] opr2;
    );

    reg [31:0] rf [0:31];

    assign opr1 = rf[rs_addr1];
    assign opr2 = rf[rs_addr2];
    always @(negedge rst or posedge clk) begin
        if (rst == 0)
            rf[0] <= 0;
        else if (wren == 0)
            rf[rd_addr] <= wr;
    end
endmodule