module fetch(
    input [31:0] pc;
    output [31:0] ins;
    );

    reg [31:0] ins_mem[255:0];
    assign ins = ins_mem[pc];
endmodule
