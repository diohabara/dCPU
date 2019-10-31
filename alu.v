`include "define.vh"

module alu(
    input reg [5:0] code;
    input reg [31:0] op1;
    input reg [31:0] op2;
    output wire [31:0]  result;
    output wire br;
    );

    always @(*) begin
        case(code[5:0])
            `ALU_ADD:
            `ALU_SUB:
            `ALU_SLT:
            `ALU_SLTU:
            `ALU_XOR:
            `ALU_SLL:
            `ALU_SRL:
            `ALU_SRA:
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
            `ALU_LUI:
        endcase
    end

endmodule