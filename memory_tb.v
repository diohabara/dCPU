//
// memory test bench
//

`include "define.vh"

`define assert()

`define assert(name, signal, value) \
        if (signal !== value) begin \
            $display("ASSERTION FAILED in %s : signal is '%d' but expected '%d'", name, signal, value); \
            $finish; \
        end else begin \
            $display("\t%m: signal == value"); \
        end

`define test(name, ir, ex_srcreg1_num, ex_srcreg2_num, ex_dstreg_num, ex_imm, ex_alucode, ex_aluop1_type, ex_aluop2_type, ex_reg_we, ex_is_load, ex_is_store, ex_is_halt) \
        $display("%s:", name); \
        $display("\tcodeword: %b", ir); \
        `assert("srcreg1_num", srcreg1_num, ex_srcreg1_num) \
        `assert("srcreg2_num", srcreg2_num, ex_srcreg2_num) \
        `assert("dstreg_num", dstreg_num, ex_dstreg_num) \
        `assert("imm", imm, ex_imm) \
        `assert("alucode", alucode, ex_alucode) \
        `assert("aluop1_type", aluop1_type, ex_aluop1_type) \
        `assert("aluop2_type", aluop2_type, ex_aluop2_type) \
        `assert("reg_we", reg_we, ex_reg_we) \
        `assert("is_load", is_load, ex_is_load) \
        `assert("is_store", is_store, ex_is_store) \
        $display("%s test ...ok\n", name); \