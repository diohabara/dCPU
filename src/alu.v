`include "define.vh"

module alu(
    input wire [5:0] alucode,       // 演算種別
    input wire [31:0] rs1,          // 入力データ1
    input wire [31:0] rs2,          // 入力データ2
    output wire [31:0] alu_result,   // 演算結果
    output wire br_taken             // 分岐の有無
    );

    reg [31:0] op1_tmp;
    reg [31:0] op2_tmp;
    reg [31:0] res_tmp;
    reg isBranch;

    always @(*) begin
        op1_tmp <= rs1;
        op2_tmp <= rs2;
        case (alucode[5:0])
            `ALU_ADD: begin
                res_tmp <= op1_tmp + op2_tmp;
                isBranch <= `DISABLE;
                end
            `ALU_SUB: begin
                res_tmp <= op1_tmp - op2_tmp;
                isBranch <= `DISABLE;
                end
            `ALU_SLT: begin
                if (op1_tmp < op2_tmp)
                    op1_tmp <= 1;
                else
                    res_tmp <= 0;
                isBranch <= `DISABLE;
                end
            `ALU_SLTU: begin
                if (op1_tmp < op2_tmp)
                    res_tmp <= 1;
                else
                    res_tmp <= 0;
                isBranch <= `DISABLE;
                end
            `ALU_XOR: begin
                res_tmp <= op1_tmp ^ op2_tmp;
                isBranch <= `DISABLE;
                end
            `ALU_OR: begin
                res_tmp <= op1_tmp | op2_tmp;
                isBranch <= `DISABLE;
                end
            `ALU_AND: begin
                res_tmp <= op1_tmp & op2_tmp;
                isBranch <= `DISABLE;
                end
            `ALU_SLL: begin
                res_tmp <= $signed(op1_tmp) <<< op2_tmp[4:0];
                isBranch <= `DISABLE;
                end
            `ALU_SRL: begin
                res_tmp <= $signed(op1_tmp) >> op2_tmp[4:0];
                isBranch <= `DISABLE;
                end
            `ALU_SRA: begin
                res_tmp <= $signed(op1_tmp) >>> op2_tmp[4:0];
                isBranch <= `DISABLE;
                end
            `ALU_LUI: begin
                res_tmp <= op2_tmp;
                isBranch <= `DISABLE;
                end
            `ALU_JAL: begin
                res_tmp <= op2_tmp + 4;
                isBranch <= `ENABLE;
                end
            `ALU_JALR: begin
                res_tmp <= op2_tmp + 4;
                isBranch <= `ENABLE;
                end
            `ALU_BEQ: begin
                res_tmp = 0;
                if ($signed(op1_tmp) == $signed(op2_tmp))
                    isBranch <= `ENABLE;
                else
                    isBranch <= `DISABLE;
                end
            `ALU_BNE: begin
                res_tmp = 0;
                if ($signed(op1_tmp) != $signed(op2_tmp))
                    isBranch <= `ENABLE;
                else
                    isBranch <= `DISABLE;
                end
            `ALU_BLT: begin
                res_tmp = 0;
                if ($signed(op1_tmp) <  $signed(op2_tmp))
                    isBranch <= `ENABLE;
                else
                    isBranch <= `DISABLE;
                end
            `ALU_BGE: begin
                res_tmp = 0;
                if ($signed(op1_tmp) >= $signed(op2_tmp))
                    isBranch <= `ENABLE;
                else
                    isBranch <= `DISABLE;
                end
            `ALU_BLTU: begin
                res_tmp = 0;
                if ($unsigned(op1_tmp) < $unsigned(op2_tmp))
                    isBranch <= `ENABLE;
                else
                    isBranch <= `DISABLE;
                end
            `ALU_BGEU: begin
                res_tmp = 0;
                if ($unsigned(op1_tmp) >= $unsigned(op2_tmp))
                    isBranch <= `ENABLE;
                else
                    isBranch <= `DISABLE;
                end
            `ALU_SB: begin
                res_tmp <= op1_tmp + op2_tmp;
                isBranch <= `DISABLE;
                end
            `ALU_SH: begin
                res_tmp <= op1_tmp + op2_tmp;
                isBranch <= `DISABLE;
                end
            `ALU_SW: begin
                res_tmp <= op1_tmp + op2_tmp;
                isBranch <= `DISABLE;
                end
            `ALU_LB: begin
                res_tmp <= op1_tmp + op2_tmp;
                isBranch <= `DISABLE;
                end
            `ALU_LH: begin
                res_tmp <= op1_tmp + op2_tmp;
                isBranch <= `DISABLE;
                end
            `ALU_LW: begin
                res_tmp <= op1_tmp + op2_tmp;
                isBranch <= `DISABLE;
                end
            `ALU_LBU: begin
                res_tmp <= op1_tmp + op2_tmp;
                isBranch <= `DISABLE;
                end
            `ALU_LHU: begin
                res_tmp <= op1_tmp + op2_tmp;
                isBranch <= `DISABLE;
                end
            default:;
        endcase
    end
    assign alu_result = res_tmp;
    assign br_taken = isBranch;
endmodule
