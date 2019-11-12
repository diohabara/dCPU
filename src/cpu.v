module cpu(
    input clk,
    input rst
    );

    wire [31:0] ins, reg1, reg2, result, imm;
    wire [5:0] alucode;
    wire [4:0] cpc, npc, rs_addr1, rs_addr2, rd_addr;
    wire [1:0] aluop1_type, aluop2_type;
    wire br_taken, wren, is_load, is_store, is_halt;

    pc pc_body(
        // input
        clk,
        rst,
        bs_taken,
        result,
        cpc,
        // output
        npc
    );
    mem mem_body(
        // input
        clk,
        npc,
        // output
        ins
    );
    decoder decoder_body(
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
        wren,
        // TODO: ここにr_addr, w_addr, w_dataを書く
        // output
        // TODO: ここにr_dataを書く
    );
endmodule
