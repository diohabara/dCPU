`include "define.vh"

module data_mem(address, clk, wren, write_data, read_data);
        input [7:0] address;
        input clk, wren;
        input [7:0] write_data;
        output [7:0] read_data;
        reg[7:0] data_memory [255:0];
    always @(posedge clk) begin
        if (wren == 0)
            data_memory[address] <= write_data;
    end
    assign read_data = data_memory[address];
endmodule