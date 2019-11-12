module cpu(
    input clk;
    input rstd;
    );
    wire [31:0] cpc, npc, ins, reg1, reg2, result, imm, alu_result;
    wire [1:0] aluop1_type, aluop2_type;
    wire [3:0] wren;
    wire [4:0] wr_addr, rs1, rs2, rd;
    wire [5:0] alucode;
    wire br_taken;
    reg reg_wren, is_load, is_store, is_halt;

    pc pc_body();
    mem mem_body();
    fetch fetch_body();
    decode decode_body();
    data_mem dm_body();
    alu alu_body();
    reg_file rf_body();
endmodule
