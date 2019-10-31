`include "define.vh"

module alu(
    input wire [5:0] alucode,       // 演算種別
    input wire [31:0] op1,          // 入力データ1
    input wire [31:0] op2,          // 入力データ2
    output reg [31:0] alu_result,   // 演算結果
    output reg br_taken             // 分岐の有無
    );


    reg [31:0] rs1;
    reg [31:0] rs2;
    reg [31:0] rd;
    reg isBranch;

    always @(*) begin
        rs1 <= op1;
        rs2 <= op2;
        case (alucode[5:0])
            `ALU_ADD:
                rd <= rs1 + rs2;
            `ALU_SUB:
                rd <= rs1 + rs2;
            `ALU_SLT: begin
                if (rs1 < rs2)
                    rd <= 1;
                else
                    rd <= 0;
                end
            `ALU_SLTU: begin
                if (rs1 < rs2)
                    rd <= 1;
                else
                    rd <= 0;
                end
            `ALU_XOR:
                rd <= rs1 ^ rs2;
            `ALU_OR:
                rd <= rs1 | rs2;
            `ALU_AND:
                rd <= rs1 & rs2;
            `ALU_SLL:
                rd <= rs1 <<< rs2;
            `ALU_SRL:
                rd <= rs1 <<< rs2;
            `ALU_SRA:
                rd <= rs1 << rs1;
            `ALU_LUI:
                rd <= rs2;
            `ALU_JAL:
                rd <= rs2 + 4;
                isBranch <= `ENABLE;
            `ALU_JALR:
                rd <= rs2 + 4;
                isBranch <= `ENABLE;
            `ALU_BEQ:
                if (rs1 == rs2)
                    isBranch <= `ENABLE;
                else
                    isBranch <= `DISABLE;
            `ALU_BNE:
                if (rs1 != rs2)
                    isBranch <= `ENABLE;
                else
                    isBranch <= `DISABLE;
            `ALU_BLT:
                if (rs1 < rs2)
                    isBranch <= `ENABLE;
                else
                    isBranch <= `DISABLE;
            `ALU_BGE:
                if (rs1 >= rs2)
                    isBranch <= `ENABLE;
                else
                    isBranch <= `DISABLE;
            `ALU_BLTU:
                if (rs1 < rs2)
                    isBranch <= `ENABLE;
                else
                    isBranch <= `DISABLE;
            `ALU_BGEU:
                if (rs1 >= rs2)
                    isBranch <= `ENABLE;
                else
                    isBranch <= `DISABLE;
            `ALU_SB:
            `ALU_SH:
            `ALU_SW:
            `ALU_LB:
            `ALU_LH:
            `ALU_LW:
            `ALU_LBU:
            `ALU_LHU:
            default:;
        endcase
    end

    assign alu_result = br_taken == 0 ? rd : br_taken;

endmodule