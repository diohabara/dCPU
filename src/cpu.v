module cpu(
    input clk,
    input rst_n
    );

    wire [31:0] pc, ins, rs1, rs2, alu_result, imm, reg_data;
    wire [5:0] alucode;
    wire [4:0] rs_addr1, rs_addr2, rd_addr, r_addr_reg, w_addr_reg, br_addr;
    wire [3:0] mask_buffer;
    wire [1:0] aluop1_type, aluop2_type;
    wire br_taken, wren, is_load, is_store, is_halt;

    assign r_addr_reg = (is_load == `ENABLE) ? rs1 + imm : 0;
    assign w_addr_reg = (is_store == `ENABLE) ? rs1 + imm : 0;
    assign mask_buffer = store_mask(alucode);

    function [3:0] store_mask;
        input alucode;
        case (alucode)
            `ALU_SB: begin
                store_mask[0] = 1'b1;
            end
            `ALU_SH: begin
                store_mask[0] = 1'b1;
                store_mask[1] = 1'b1;
            end
            `ALU_SW: begin
                store_mask[0] = 1'b1;
                store_mask[1] = 1'b1;
                store_mask[2] = 1'b1;
                store_mask[3] = 1'b1;
            end
        endcase
    endfunction

    pc pc_body(
        // input
        clk,
        rst_n,
        bs_taken,
        alu_result,
        // output
        pc
    );
    mem mem_body(
        // input
        clk,
        pc,
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
    alu alu_body(
        // input
        alucode,
        rs1,
        rs2,
        // output
        alu_result,
        br_taken
    );
    reg_file rf_body(
        // input
        clk,
        rst_n,
        wren,
        rs_addr1,
        rs_addr2,
        rd_addr,
        reg_data,
        // output
        rs1,
        rs2
    );
    data_mem dm_body(
        // input
        clk,
        wren,
        is_load,
        mask_buffer,
        r_addr_reg,
        w_addr_reg,
        rs2,
        // output
        reg_data
    );
endmodule
