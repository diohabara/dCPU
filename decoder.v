`include "define.vh"

module decoder (
    input  wire [31:0]  ir,           // 機械語命令列
    output wire  [4:0]	srcreg1_num,  // ソースレジスタ1番号
    output wire  [4:0]	srcreg2_num,  // ソースレジスタ2番号
    output wire  [4:0]	dstreg_num,   // デスティネーションレジスタ番号
    output wire [31:0]	imm,          // 即値
    output reg   [5:0]	alucode,      // ALUの演算種別
    output reg   [1:0]	aluop1_type,  // ALUの入力タイプ
    output reg   [1:0]	aluop2_type,  // ALUの入力タイプ
    output reg	    reg_we,       // レジスタ書き込みの有無
    output reg		is_load,      // ロード命令判定フラグ
    output reg		is_store,     // ストア命令判定フラグ
    output reg      is_halt  // flag to halt
    );

    reg[4:0] r1;
    reg[4:0] r2;
    reg[4:0] rd;
    reg[31:0] imm_reg;

    always @(*) begin
        case (ir[6:0])
            `OPIMM: begin
                reg_we <= `ENABLE;
                is_load <= `DISABLE;
                is_store <= `DISABLE;
                is_halt <= `DISABLE;
                aluop1_type <= `OP_TYPE_REG;
                aluop2_type <= `OP_TYPE_IMM;
                if (ir[14:12] == 3'b000) begin
                    alucode <= `ALU_ADD;
                    imm_reg[11:0] <= ir[31:20];
                    rd[4:0] <= ir[11:7];
                    r1[4:0] <= ir[19:15];
                    r2[4:0] <= 5'b0;
                end
                else if (ir[14:12] == 3'b010) begin
                    alucode <= `ALU_SLT;
                    imm_reg[11:0] <= ir[31:20];
                    rd[4:0] <= ir[11:7];
                    r1[4:0] <= ir[19:15];
                end
                else if (ir[14:12] == 3'b011) begin
                    alucode <= `ALU_SLTU;
                    imm_reg[11:0] <= ir[31:20];
                    rd[4:0] <= ir[11:7];
                    r1[4:0] <= ir[19:15];
                end
                else if (ir[14:12] == 3'b100) begin
                    alucode <= `ALU_XOR;
                    imm_reg[11:0] <= ir[31:20];
                    rd[4:0] <= ir[11:7];
                    r1[4:0] <= ir[19:15];
                end
                else if (ir[14:12] == 3'b110) begin
                    alucode <= `ALU_OR;
                    imm_reg[11:0] <= ir[31:20];
                    rd[4:0] <= ir[11:7];
                    r1[4:0] <= ir[19:15];
                end
                else if (ir[14:12] == 3'b111) begin
                    alucode <= `ALU_AND;
                    imm_reg[11:0] <= ir[31:20];
                    rd[4:0] <= ir[11:7];
                    r1[4:0] <= ir[19:15];
                end
                else if (ir[14:12] == 3'b001) begin
                    alucode <= `ALU_SLL;
                    imm_reg[4:0] <= ir[24:20];
                    rd[4:0] <= ir[11:7];
                    r1[4:0] <= ir[19:15];
                end
                else if (ir[14:12] == 3'b101 && ir[31:25] == 7'b0)begin
                    alucode <= `ALU_SRL;
                    imm_reg[4:0] <= ir[24:20];
                    rd[4:0] <= ir[11:7];
                    r1[4:0] <= ir[19:15];
                end
                else if (ir[14:12] == 3'b101 && ir[31:25] == 7'b0100000)begin
                    alucode <= `ALU_SRA;
                    imm_reg[4:0] <= ir[24:20];
                    rd[4:0] <= ir[11:7];
                    r1[4:0] <= ir[19:15];
                end
            end
            `OP: begin
                reg_we <= `ENABLE;
                is_load <= `DISABLE;
                is_store <= `DISABLE;
                is_halt <= `DISABLE;
                aluop1_type <= `OP_TYPE_REG;
                aluop2_type <= `OP_TYPE_REG;
                if (ir[31:25] == 7'b0000001) begin
                    if (ir[14:12] == 3'b000) begin
                        // alucode <= ALU_MUL;
                        rd[4:0] <= ir[11:7];
                        r1[4:0] <= ir[19:15];
                        r2[4:0] <= ir[24:20];
                    end
                    else if (ir[14:12] == 3'b001) begin
                        // alucode <= ALU_MLUH;
                        rd[4:0] <= ir[11:7];
                        r1[4:0] <= ir[19:15];
                        r2[4:0] <= ir[24:20];
                    end
                    else if (ir[14:12] == 3'b010) begin
                        // alucode <= ALU_MULHSU;
                        rd[4:0] <= ir[11:7];
                        r1[4:0] <= ir[19:15];
                        r2[4:0] <= ir[24:20];
                    end
                    else if (ir[14:12] == 3'b011) begin
                        // alucode <= ALU_MULHU;
                        rd[4:0] <= ir[11:7];
                        r1[4:0] <= ir[19:15];
                        r2[4:0] <= ir[24:20];
                    end
                    else if (ir[14:12] == 3'b100) begin
                        // alucode <= ALU_DIV;
                        rd[4:0] <= ir[11:7];
                        r1[4:0] <= ir[19:15];
                        r2[4:0] <= ir[24:20];
                    end
                    else if (ir[14:12] == 3'b101) begin
                        // alucode <= ALU_DIVU;
                        rd[4:0] <= ir[11:7];
                        r1[4:0] <= ir[19:15];
                        r2[4:0] <= ir[24:20];
                    end
                    else if (ir[14:12] == 3'b110) begin
                        // alucode <= ALU_REM;
                        rd[4:0] <= ir[11:7];
                        r1[4:0] <= ir[19:15];
                        r2[4:0] <= ir[24:20];
                    end
                    else if (ir[14:12] == 3'b111) begin
                        // alucode <= ALU_REMU;
                        rd[4:0] <= ir[11:7];
                        r1[4:0] <= ir[19:15];
                        r2[4:0] <= ir[24:20];
                    end
                end
                else begin
                    if (ir[14:12] == 3'b000 && ir[31:25] == 7'b0) begin
                        alucode <= `ALU_ADD;
                        rd[4:0] <= ir[11:7];
                        r1[4:0] <= ir[19:15];
                        r2[4:0] <= ir[24:20];
                    end
                    else if (ir[14:12] == 3'b000 && ir[31:25] == 7'b0100000) begin
                        alucode <= `ALU_SUB;
                        rd[4:0] <= ir[11:7];
                        r1[4:0] <= ir[19:15];
                        r2[4:0] <= ir[24:20];
                    end
                    else if (ir[14:12] == 3'b001) begin
                        alucode <= `ALU_SLL;
                        rd[4:0] <= ir[11:7];
                        r1[4:0] <= ir[19:15];
                        r2[4:0] <= ir[24:20];
                    end
                    else if (ir[14:12] == 3'b010) begin
                        alucode <= `ALU_SLT;
                        rd[4:0] <= ir[11:7];
                        r1[4:0] <= ir[19:15];
                        r2[4:0] <= ir[24:20];
                    end
                    else if (ir[14:12] == 3'b011) begin
                        alucode <= `ALU_SLTU;
                        rd[4:0] <= ir[11:7];
                        r1[4:0] <= ir[19:15];
                        r2[4:0] <= ir[24:20];
                    end
                    else if (ir[14:12] == 3'b100) begin
                        alucode <= `ALU_XOR;
                        rd[4:0] <= ir[11:7];
                        r1[4:0] <= ir[19:15];
                        r2[4:0] <= ir[24:20];
                    end
                    else if (ir[14:12] == 3'b101 && ir[31:25] == 7'b0) begin
                        alucode <= `ALU_SRL;
                        rd[4:0] <= ir[11:7];
                        r1[4:0] <= ir[19:15];
                        r2[4:0] <= ir[24:20];
                    end
                    else if (ir[14:12] == 3'b101 && ir[31:25] == 7'b0100000) begin
                        alucode <= `ALU_SRA;
                        rd[4:0] <= ir[11:7];
                        r1[4:0] <= ir[19:15];
                        r2[4:0] <= ir[24:20];
                    end
                    else if (ir[14:12] == 3'b110) begin
                        alucode <= `ALU_OR;
                        rd[4:0] <= ir[11:7];
                        r1[4:0] <= ir[19:15];
                        r2[4:0] <= ir[24:20];
                    end
                    else if (ir[14:12] == 3'b111) begin
                        alucode <= `ALU_AND;
                        rd[4:0] <= ir[11:7];
                        r1[4:0] <= ir[19:15];
                        r2[4:0] <= ir[24:20];
                    end
                end
            end
            `LUI: begin
                reg_we <= `DISABLE;
                is_load <= `DISABLE;
                is_store <= `DISABLE;
                is_halt <= `DISABLE;
                aluop1_type <= `OP_TYPE_REG;
                aluop2_type <= `OP_TYPE_PC;
                rd[4:0] <= ir[11:7];
                imm_reg[31:12] <= ir[31:12];
                r1[4:0] <= ir[19:15];
            end
            `AUIPC: begin
                reg_we <= `DISABLE;
                is_load <= `DISABLE;
                is_store <= `DISABLE;
                is_halt <= `DISABLE;
                aluop1_type <= `OP_TYPE_PC;
                aluop2_type <= `OP_TYPE_IMM;
                rd[4:0] <= ir[11:7];
                imm_reg[31:12] <= ir[31:12];
                r1[4:0] <= ir[19:15];
            end
            `JAL: begin
                reg_we <= `DISABLE;
                is_load <= `DISABLE;
                is_store <= `DISABLE;
                is_halt <= `DISABLE;
                aluop1_type <= `OP_TYPE_PC;
                aluop2_type <= `OP_TYPE_IMM;
                rd[4:0] <= ir[11:7];
                imm_reg[20] <= ir[31];
                imm_reg[10:1] <= ir[30:21];
                imm_reg[11] <= ir[20];
                imm_reg[19:12] <= ir[19:12];
                r1[4:0] <= ir[19:15];
            end
            `JALR: begin
                reg_we <= `DISABLE;
                is_load <= `DISABLE;
                is_store <= `DISABLE;
                is_halt <= `DISABLE;
                aluop1_type <= `OP_TYPE_REG;
                aluop2_type <= `OP_TYPE_IMM;
                rd[4:0] <= ir[11:7];
                imm_reg[11:0] <= ir[31:20];
                r1[4:0] <= ir[19:15];
            end
            `BRANCH: begin
                reg_we <= `DISABLE;
                is_load <= `DISABLE;
                is_store <= `DISABLE;
                is_halt <= `DISABLE;
                aluop1_type <= `OP_TYPE_PC;
                aluop2_type <= `OP_TYPE_IMM;
                if (ir[14:12] == 3'b000) begin
                    alucode <= `ALU_BEQ;
                    imm_reg[12] <= ir[31];
                    imm_reg[10:5] <= ir[30:25];
                    imm_reg[4:1] <= ir[25:21];
                    imm_reg[11] <= ir[20];
                    r1[4:0] <= ir[19:15];
                    r2[4:0] <= ir[24:20];
                end
                else if (ir[14:12] == 3'b001) begin
                    alucode <= `ALU_BNE;
                    imm_reg[12] <= ir[31];
                    imm_reg[10:5] <= ir[30:25];
                    imm_reg[4:1] <= ir[25:21];
                    imm_reg[11] <= ir[20];
                    r1[4:0] <= ir[19:15];
                    r2[4:0] <= ir[24:20];
                end
                else if (ir[14:12] == 3'b100) begin
                    alucode <= `ALU_BLT;
                    imm_reg[12] <= ir[31];
                    imm_reg[10:5] <= ir[30:25];
                    imm_reg[4:1] <= ir[25:21];
                    imm_reg[11] <= ir[20];
                    r1[4:0] <= ir[19:15];
                    r2[4:0] <= ir[24:20];
                end
                else if (ir[14:12] == 3'b101) begin
                    alucode <= `ALU_BGE;
                    imm_reg[12] <= ir[31];
                    imm_reg[10:5] <= ir[30:25];
                    imm_reg[4:1] <= ir[25:21];
                    imm_reg[11] <= ir[20];
                    r1[4:0] <= ir[19:15];
                    r2[4:0] <= ir[24:20];
                end
                else if (ir[14:12] == 3'b110) begin
                    alucode <= `ALU_BLTU;
                    imm_reg[12] <= ir[31];
                    imm_reg[10:5] <= ir[30:25];
                    imm_reg[4:1] <= ir[25:21];
                    imm_reg[11] <= ir[20];
                    r1[4:0] <= ir[19:15];
                    r2[4:0] <= ir[24:20];
                end
                else if (ir[14:12] == 3'b111) begin
                    alucode <= `ALU_BGEU;
                    imm_reg[12] <= ir[31];
                    imm_reg[10:5] <= ir[30:25];
                    imm_reg[4:1] <= ir[25:21];
                    imm_reg[11] <= ir[20];
                    r1[4:0] <= ir[19:15];
                    r2[4:0] <= ir[24:20];
                end
            end
            `STORE: begin
                reg_we <= `DISABLE;
                is_load <= `DISABLE;
                is_store <= `ENABLE;
                is_halt <= `DISABLE;
                aluop1_type <= `OP_TYPE_REG;
                aluop2_type <= `OP_TYPE_REG;
                if (ir[14:12] == 3'b000) begin
                    alucode <= `ALU_SB;
                    imm_reg[11:5] <= ir[31:25];
                    imm_reg[4:0] <= ir[11:7];
                    r1[4:0] <= ir[19:15];
                    r2[4:0] <= ir[24:20];
                end
                else if (ir[14:12] == 3'b001) begin
                    alucode <= `ALU_SH;
                    imm_reg[11:5] <= ir[31:25];
                    imm_reg[4:0] <= ir[11:7];
                    r1[4:0] <= ir[19:15];
                    r2[4:0] <= ir[24:20];
                end
                else if (ir[14:12] == 3'b010) begin
                    alucode <= `ALU_SW;
                    imm_reg[11:5] <= ir[31:25];
                    imm_reg[4:0] <= ir[11:7];
                    r1[4:0] <= ir[19:15];
                    r2[4:0] <= ir[24:20];
                end
            end
            `LOAD: begin
                reg_we <= `ENABLE;
                is_load <= `ENABLE;
                is_store <= `DISABLE;
                is_halt <= `DISABLE;
                aluop1_type <= `OP_TYPE_REG;
                aluop2_type <= `OP_TYPE_IMM;
                if (ir[14:12] == 3'b000) begin
                    alucode <= `ALU_LB;
                    imm_reg[11:0] <= ir[31:20];
                    rd[4:0] <= ir[11:7];
                    r1[4:0] <= ir[19:15];
                end
                else if (ir[14:12] == 3'b001) begin
                    alucode <= `ALU_LH;
                    imm_reg[11:0] <= ir[31:20];
                    rd[4:0] <= ir[11:7];
                    r1[4:0] <= ir[19:15];
                end
                else if (ir[14:12] == 3'b010) begin
                    alucode <= `ALU_LW;
                    imm_reg[11:0] <= ir[31:20];
                    rd[4:0] <= ir[11:7];
                    r1[4:0] <= ir[19:15];
                end
                else if (ir[14:12] == 3'b100) begin
                    alucode <= `ALU_LBU;
                    imm_reg[11:0] <= ir[31:20];
                    rd[4:0] <= ir[11:7];
                    r1[4:0] <= ir[19:15];
                end
                else if (ir[14:12] == 3'b101) begin
                    alucode <= `ALU_LHU;
                    imm_reg[11:0] <= ir[31:20];
                    rd[4:0] <= ir[11:7];
                    r1[4:0] <= ir[19:15];
                end
            end
            default: ;
        endcase
    end
    assign srcreg1_num = r1;
    assign srcreg2_num = r2;
    assign dstreg_num = rd;
    assign imm = imm_reg;
endmodule
