`include "define.vh"

module alu(
    input wire [5:0] alucode,       // 演算種別
    input wire [31:0] op1,          // 入力データ1
    input wire [31:0] op2,          // 入力データ2
    output reg [31:0] alu_result,   // 演算結果
    output reg br_taken             // 分岐の有無
    );


    reg [31:0] op1_tmp;
    reg [31:0] op2_tmp;
    reg [31:0] res_tmp;
    reg isBranch;

    always @(*) begin
        op1_tmp <= op1;
        op2_tmp <= op2;
        case (alucode[5:0])
            `ALU_ADD:
                res_tmp <= op1_tmp + op2_tmp;
            `ALU_SUB:
                res_tmp <= op1_tmp - op2_tmp;
            `ALU_SLT: begin
                if (op1_tmp < op2_tmp)
                    res_tmp <= 1;
                else
                    res_tmp <= 0;
                end
            `ALU_SLTU: begin
                if (op1_tmp < op2_tmp)
                    res_tmp <= 1;
                else
                    res_tmp <= 0;
                end
            `ALU_XOR:
                res_tmp <= op1_tmp ^ op2_tmp;
            `ALU_OR:
                res_tmp <= op1_tmp | op2_tmp;
            `ALU_AND:
                res_tmp <= op1_tmp & op2_tmp;
            `ALU_SLL:
                res_tmp <= op1_tmp <<< op2_tmp;
            `ALU_SRL:
                res_tmp <= op1_tmp <<< op2_tmp;
            `ALU_SRA:
                res_tmp <= op1_tmp << op1_tmp;
            `ALU_LUI:
                res_tmp <= op2_tmp;
            `ALU_JAL:
                res_tmp <= op2_tmp + 4;
                isBranch <= `ENABLE;
            `ALU_JALR:
                res_tmp <= op2_tmp + 4;
                isBranch <= `ENABLE;
            `ALU_BEQ:
                if (op1_tmp == op2_tmp)
                    isBranch <= `ENABLE;
                else
                    isBranch <= `DISABLE;
            `ALU_BNE:
                if (op1_tmp != op2_tmp)
                    isBranch <= `ENABLE;
                else
                    isBranch <= `DISABLE;
            `ALU_BLT:
                if (op1_tmp < op2_tmp)
                    isBranch <= `ENABLE;
                else
                    isBranch <= `DISABLE;
            `ALU_BGE:
                if (op1_tmp >= op2_tmp)
                    isBranch <= `ENABLE;
                else
                    isBranch <= `DISABLE;
            `ALU_BLTU:
                if (op1_tmp < op2_tmp)
                    isBranch <= `ENABLE;
                else
                    isBranch <= `DISABLE;
            `ALU_BGEU:
                if (op1_tmp >= op2_tmp)
                    isBranch <= `ENABLE;
                else
                    isBranch <= `DISABLE;
            `ALU_SB:
                res_tmp = op1_tmp + op2_tmp;
            `ALU_SH:
                res_tmp = op1_tmp + op2_tmp;
            `ALU_SW:
                res_tmp = op1_tmp + op2_tmp;
            `ALU_LB:
            `ALU_LH:
            `ALU_LW:
            `ALU_LBU:
            `ALU_LHU:
            default:;
        endcase
    end

    assign alu_result = br_taken == 0 ? res_tmp : br_taken;

endmodule