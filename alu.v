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

    always @(*) begin
        rs1 <= op1;
        rs2 <= op2;
        case (alucode[5:0])
            `ALU_ADD:
                rd <= rs1 + rs2;
            `ALU_SUB:
                rd <= rs1 + rs2;
            `ALU_SLT:
            `ALU_SLTU:
            `ALU_XOR:
            `ALU_OR:
            `ALU_AND:
            `ALU_SLL:
            `ALU_SRL:
            `ALU_SRA:
            `ALU_LUI:
            `ALU_JAL:
            `ALU_JALR:
            `ALU_BEQ:
            `ALU_BNE:
            `ALU_BGE:
            `ALU_BGEU:
            `ALU_LB:
            `ALU_LH:
            `ALU_LW:
            `ALU_LW:
            `ALU_LBU:
            `ALU_LHU:
            `ALU_SB:
            `ALU_SH:
            `ALU_SW:
            default:;
        endcase
    end

    assign alu_result = br_taken == 0 ? rd : br_taken;

endmodule