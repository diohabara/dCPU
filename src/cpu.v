module cpu(clk, rstd);
    input clk, rstd;
    wire [31:0] pc, ins, reg1, reg2, result, nextpc, imm, alu_result;
    wire [1:0] aluop1_type, aluop2_type;
    wire [3:0] wren;
    wire [4:0] wr_addr, rs1, rs2, rd;
    wire [5:0] alucode;
    wire br_taken;
    reg reg_wren, is_load, is_store, is_halt;

    rom rom_body(clk, r_addr, r_data);
    fetch fetch_body(pc[7:0], ins);
    adder adder_body(pc, 4, nextpc);
    reg_file rf_body(clk, rstd, wr_addr);
    decoder decoder_body(ins, rs1, rs2, rd, imm, alucode, aluop1_type, aluop2_type, reg_wren, is_load, is_store, is_halt);
endmodule