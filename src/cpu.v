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
        // input
        clk,
        rst,
        cpc,
        // output
        npc
    );
    mem mem_body(
        // input
        clk,
        r_addr,
        // output
        ins
    );
    decode decode_body(
        // input
        ins,
        // output
        rs_addr1,
        rs_addr2,
        rd_addr,
        imm,
        alucode,
        aluop1_type,
        aluop2_type,
        wren,
        is_load,
        is_store,
        is_halt
    );
    reg_file rf_body(
        // input
        clk,
        rst,
        wren,
        rs_addr1,
        rs_addr2,
        rd_addr,
        // output
        reg1,
        reg2
    );
    alu alu_body(
        // input
        alucode,
        reg1,
        reg2,
        // output
        result,
        br_taken
    );
    data_mem dm_body(
        // input
        clk,
        rst,
        // output
        r_addr
    );
endmodule
