module cpu(clk, rstd);
    input clk, rstd;
    wire [31:0] pc, ins, reg1, reg2, result, nextpc, imm, alu_result;
    wire [1:0] aluop1_type, aluop2_type;
    wire [3:0] wren;
    wire [4:0] wr_addr, rs1, rs2, rd;
    wire [5:0] alucode;
    wire br_taken;
    reg reg_wren, is_load, is_store, is_halt;

    pc;
    inst_mem;
    fetch;
    decode;
    reg_file;
    alu;
    data_mem;
endmodule