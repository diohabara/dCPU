module cpu(
    input clk;
    input rst;
    );
    wire [31:0] cpc, npc, ins, reg1, reg2, result, imm;
    wire [1:0] aluop1_type, aluop2_type;
    wire [4:0] rs_addr1, rs_addr2, rd_addr;
    wire [5:0] alucode;
    wire br_taken;
    reg wren, is_load, is_store, is_halt;

    pc pc_body(
        clk, rst, br_taken, input cpc, npc
    );
    mem mem_body(
        clk, r_addr, ins
    );
    decode decode_body(
        ins, rs_addr1, rs_addr2, rd_addr, imm, alucode, aluop1_type, aluop2_type, wren, is_load, is_store, is_halt
    );
    data_mem dm_body(
        clk, rst
    );
    alu alu_body(
        alucode, reg1, reg2, result, br_taken
    );
    reg_file rf_body(
        clk, wren, rst, rs_addr1, rs_addr2, rd_addr, reg1, reg2
    );
endmodule
