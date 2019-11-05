`include "define.vh"

module memory(
        input [7:0] address;
        input clk, writeEn;
        input [7:0] write_data;
        output [7:0] read_data;
        reg[7:0] data_memory;
    )
    always @(posedge clk) begin
        if (writeEn == 0)
            data_memory[address] <= write_data;
    end
    assign read_data = data_memory[address];
endmodule