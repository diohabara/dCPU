module fetch(
    pc, ins
);
    input [7:0] pc;
    output [31:0] ins;
    reg [31:0] ins_mem[255:0];
    // somehow load program into ins_mem
    assign ins = ins_mem[pc];
endmodule // fetch