module data_mem(
    input clk,
    input wren,
    input is_load,
    input [3:0] mask_buffer,
    input [4:0] r_addr,
    input [4:0] w_addr,
    input [31:0] w_data,
    output reg [31:0] r_data
    );

    reg [31:0] mem [0:`MAX_D_MEM];
    integer i;

    initial begin
        for (i = 0; i <= 31; i = i + 1) begin
            mem[i] = 0;
        end
    end

    always @(posedge clk) begin
        if (wren == `ENABLE)
            if (w_addr/4 == 0) begin
                if (mask_buffer[0])
                    mem[w_addr/4][7:0] <= w_data[7:0];
                if (mask_buffer[1])
                    mem[w_addr/4][15:8] <= w_data[15:8];
                if (mask_buffer[2])
                    mem[w_addr/4][23:16] <= w_data[23:16];
                if (mask_buffer[3])
                    mem[w_addr/4][31:24] <= w_data[31:24];
            else if (w_addr/4 == 1) begin
                if (mask_buffer[0])
                    mem[w_addr/4][15:8] <= w_data[7:0];
                if (mask_buffer[1])
                    mem[w_addr/4][23:16] <= w_data[15:8];
                if (mask_buffer[2])
                    mem[w_addr/4][31:24] <= w_data[23:16];
                if (mask_buffer[3])
                    mem[w_addr/4 + 1][7:0] <= w_data[31:24];
            end
            else if (w_addr/4 == 2) begin
            end
                if (mask_buffer[0])
                    mem[w_addr/4][23:16] <= w_data[7:0];
                if (mask_buffer[1])
                    mem[w_addr/4][31:24] <= w_data[15:8];
                if (mask_buffer[2])
                    mem[w_addr/4 + 1][7:0] <= w_data[23:16];
                if (mask_buffer[3])
                    mem[w_addr/4 + 1][15:8] <= w_data[31:24];
            else if (w_addr/4 == 3) begin
            end
                if (mask_buffer[0])
                    mem[w_addr/4][31:24] <= w_data[7:0];
                if (mask_buffer[1])
                    mem[w_addr/4 + 1][7:0] <= w_data[15:8];
                if (mask_buffer[2])
                    mem[w_addr/4 + 1][15:8] <= w_data[23:16];
                if (mask_buffer[3])
                    mem[w_addr/4 + 1][23:16] <= w_data[31:24];
        else if (is_load == `ENABLE)
            r_data <= mem[r_addr];
        end
    end
endmodule
