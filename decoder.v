`include "define.vh"

module decoder(
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

    always @(*) begin
        case (ir[6:0])
            `OPTIMM:
                reg_we <= `ENABLE;
                is_store <= `DISABLE;
                is_load <= `DISABLE;
                is_halt <= `DISABLE;
                aluop1_type <= `OP_TYPE_REG;
                aluop2_type <= `OP_TYPE_IMM;
                if (ir[14:12] == 3'b000) begin
                    alucode <= `ALU_ADD;
                    imm[11:0] <= ir[31:20];
                    dstreg_num[4:0] <= ir[11:7];
                    srcreg1_num[4:0] <= ir[19:5];
                end
                else if (ir[14:12] == 3'b010) begin
                    alucode <= `ALU_SLT;
                    imm[11:0] <= ir[31:20];
                    dstreg_num[4:0] <= ir[11:7];
                    srcreg1_num[4:0] <= ir[19:5];
                end
                else if (ir[14:12] == 3'b011) begin
                    alucode <= `ALU_SLTU;
                    imm[11:0] <= ir[31:20];
                    dstreg_num[4:0] <= ir[11:7];
                    srcreg1_num[4:0] <= ir[19:5];
                end
                else if (ir[14:12] == 3'b100) begin
                    alucode <= `ALU_XOR;
                    imm[11:0] <= ir[31:20];
                    dstreg_num[4:0] <= ir[11:7];
                    srcreg1_num[4:0] <= ir[19:5];
                end
                else if (ir[14:12] == 3'b110) begin
                    alucode <= `ALU_OR;
                    imm[11:0] <= ir[31:20];
                    dstreg_num[4:0] <= ir[11:7];
                    srcreg1_num[4:0] <= ir[19:5];
                end
                else if (ir[14:12] == 3'b111) begin
                    alucode <= `ALU_AND;
                    imm[11:0] <= ir[31:20];
                    dstreg_num[4:0] <= ir[11:7];
                    srcreg1_num[4:0] <= ir[19:5];
                end
                else if (ir[14:12] == 3'b001) begin
                    alucode <= `ALU_SLL;
                    imm[4:0] <= ir[24:20];
                    dstreg_num[4:0] <= ir[11:7];
                    srcreg1_num[4:0] <= ir[19:5];
                end
                else if (ir[14:12] == 3'b101 && ir[31:25] == 7'b0)begin
                    alucode <= `ALU_SRL;
                    imm[4:0] <= ir[24:20];
                    dstreg_num[4:0] <= ir[11:7];
                    srcreg1_num[4:0] <= ir[19:5];
                end
                else if (ir[14:12] == 3'b101 && ir[31:25] == 7'b0100000)begin
                    alucode <= `ALU_SRA;
                    imm[4:0] <= ir[24:20];
                    dstreg_num[4:0] <= ir[11:7];
                    srcreg1_num[4:0] <= ir[19:5];
                end
            end
            `OP:
                reg_we <= `ENABLE;
                is_store <= `DISABLE;
                is_load <= `DISABLE;
                is_halt <= `DISABLE;
                aluop1_type <= `OP_TYPE_REG;
                aluop2_type <= `OP_TYPE_REG;
                if (ir[31:25] == 7'b0000001) begin
                    if (ir[14:12] == 3'b000) begin
                        // alucode <= ALU_MUL;
                        dstreg_num[4:0] <= ir[11:7];
                        srcreg1_num[4:0] <= ir[19:5];
                        srcreg2_num[4:0] <= ir[24:20];
                    end
                    else if (ir[14:12] == 3'b001) begin
                        // alucode <= ALU_MLUH;
                        dstreg_num[4:0] <= ir[11:7];
                        srcreg1_num[4:0] <= ir[19:5];
                        srcreg1_num[4:0] <= ir[19:5];
                        srcreg2_num[4:0] <= ir[24:20];
                    end
                    else if (ir[14:12] == 3'b010) begin
                        // alucode <= ALU_MULHSU;
                        dstreg_num[4:0] <= ir[11:7];
                        srcreg1_num[4:0] <= ir[19:5];
                        srcreg2_num[4:0] <= ir[24:20];
                    end
                    else if (ir[14:12] == 3'b011) begin
                        // alucode <= ALU_MULHU;
                        dstreg_num[4:0] <= ir[11:7];
                        srcreg1_num[4:0] <= ir[19:5];
                        srcreg2_num[4:0] <= ir[24:20];
                    end
                    else if (ir[14:12] == 3'b100) begin
                        // alucode <= ALU_DIV;
                        dstreg_num[4:0] <= ir[11:7];
                        srcreg1_num[4:0] <= ir[19:5];
                        srcreg2_num[4:0] <= ir[24:20];
                    end
                    else if (ir[14:12] == ;3'b101) begin
                        // alucode <= ALU_DIVU;
                        dstreg_num[4:0] <= ir[11:7];
                        srcreg1_num[4:0] <= ir[19:5];
                        srcreg2_num[4:0] <= ir[24:20];
                    end
                    else if (ir[14:12] == 3'b110) begin
                        // alucode <= ALU_REM;
                        dstreg_num[4:0] <= ir[11:7];
                        srcreg1_num[4:0] <= ir[19:5];
                        srcreg2_num[4:0] <= ir[24:20];
                    end
                    else if (ir[14:12] == 3'b111) begin
                        // alucode <= ALU_REMU;
                        dstreg_num[4:0] <= ir[11:7];
                        srcreg1_num[4:0] <= ir[19:5];
                        srcreg2_num[4:0] <= ir[24:20];
                    end
                end
                else begin
                    if (ir[14:12] == 3'b000 && ir[31:25] == 7'b0) begin
                        alucode <= `ALU_ADD;
                        dstreg_num[4:0] <= ir[11:7];
                        srcreg1_num[4:0] <= ir[19:5];
                        srcreg2_num[4:0] <= ir[24:20];
                    end
                    else if (ir[14:12] == 3'b000 && ir[31:25] == 7'b0100000) begin
                        alucode <= `ALU_SUB;
                        dstreg_num[4:0] <= ir[11:7];
                        srcreg1_num[4:0] <= ir[19:5];
                        srcreg2_num[4:0] <= ir[24:20];
                    end
                    else if (ir[14:12] == 3'b001) begin
                        alucode <= `ALU_SLL;
                        dstreg_num[4:0] <= ir[11:7];
                        srcreg1_num[4:0] <= ir[19:5];
                        srcreg2_num[4:0] <= ir[24:20];
                    end
                    else if (ir[14:12] == 3'b010) begin
                        alucode <= `ALU_SLT;
                        dstreg_num[4:0] <= ir[11:7];
                        srcreg1_num[4:0] <= ir[19:5];
                        srcreg2_num[4:0] <= ir[24:20];
                    end
                    else if (ir[14:12] == 3'b011) begin
                        alucode <= `ALU_SLTU;
                        dstreg_num[4:0] <= ir[11:7];
                        srcreg1_num[4:0] <= ir[19:5];
                        srcreg2_num[4:0] <= ir[24:20];
                    end
                    else if (ir[14:12] == 3'b100) begin
                        alucode <= `ALU_XOR;
                        dstreg_num[4:0] <= ir[11:7];
                        srcreg1_num[4:0] <= ir[19:5];
                        srcreg2_num[4:0] <= ir[24:20];
                    end
                    else if (ir[14:12] == 3'b101 && ir[31:25] == 7'b0) begin
                        alucode <= `ALU_SRL;
                        dstreg_num[4:0] <= ir[11:7];
                        srcreg1_num[4:0] <= ir[19:5];
                        srcreg2_num[4:0] <= ir[24:20];
                    end
                    else if (ir[14:12] == 3'b101 && ir[31:25] == 7'b0100000) begin
                        alucode <= `ALU_SRA;
                        dstreg_num[4:0] <= ir[11:7];
                        srcreg1_num[4:0] <= ir[19:5];
                        srcreg2_num[4:0] <= ir[24:20];
                    end
                    else if (ir[14:12] == 3'b110) begin
                        alucode <= `ALU_OR;
                        dstreg_num[4:0] <= ir[11:7];
                        srcreg1_num[4:0] <= ir[19:5];
                        srcreg2_num[4:0] <= ir[24:20];
                    end
                    else if (ir[14:12] == 3'b111) begin
                        alucode <= `ALU_AND;
                        dstreg_num[4:0] <= ir[11:7];
                        srcreg1_num[4:0] <= ir[19:5];
                        srcreg2_num[4:0] <= ir[24:20];
                    end
                end
            `end
            `LUI:
                reg_we <= `DISABLE;
                is_store <= `DISABLE;
                is_load <= `DISABLE;
                is_halt <= `DISABLE;
                aluop1_type <= `OP_TYPE_REG;
                aluop2_type <= `OP_TYPE_PC;
                dstreg_num[4:0] <= ir[11:7];
                imm[31:12] <= ir[31:12];
                srcreg1_num[4:0] <= ir[19:5];
            end
            `AUIPC:
                reg_we <= `DISABLE;
                is_store <= `DISABLE;
                is_load <= `DISABLE;
                is_halt <= `DISABLE;
                aluop1_type <= `OP_TYPE_PC;
                aluop2_type <= `OP_TYPE_IMM;
                dstreg_num[4:0] <= ir[11:7];
                imm[31:12] <= ir[31:12];
                srcreg1_num[4:0] <= ir[19:5];
            end
            `JAL:
                reg_we <= `DISABLE;
                is_store <= `DISABLE;
                is_load <= `DISABLE;
                is_halt <= `DISABLE;
                aluop1_type <= `OP_TYPE_PC;
                aluop2_type <= `OP_TYPE_IMM;
                dstreg_num[4:0] <= ir[11:7];
                imm[20] <= ir[31];
                imm[10:1] <= ir[30:21];
                imm[11] <= ir[20];
                imm[19:12] <= ir[19:12];
                srcreg1_num[4:0] <= ir[19:5];
            end
            `JALR:
                reg_we <= `DISABLE;
                is_store <= `DISABLE;
                is_load <= `DISABLE;
                is_halt <= `DISABLE;
                aluop1_type <= `OP_TYPE_REG;
                aluop2_type <= `OP_TYPE_IMM;
                dstreg_num[4:0] <= ir[11:7];
                imm[11:0] <= ir[31:20];
                srcreg1_num[4:0] <= ir[19:5];
            end;
            `BRANCH:
                reg_we <= `DISABLE;
                is_store <= `DISABLE;
                is_load <= `DISABLE;
                is_halt <= `DISABLE;
                aluop1_type <= `OP_TYPE_PC;
                aluop2_type <= `OP_TYPE_IMM;
                if (ir[14:12] == 3'b000) begin
                    alucode <= `ALU_BEQ;
                    imm[12] <= ir[31];
                    imm[10:5] <= ir[30:25];
                    imm[4:1] <= ir[25:21];
                    imm[11] <= ir[20];
                    srcreg1_num[4:0] <= ir[19:5];
                    srcreg2_num[4:0] <= ir[24:20];
                end
                else if (ir[14:12] == 3'b001) begin
                    alucode <= `ALU_BNE;
                    imm[12] <= ir[31];
                    imm[10:5] <= ir[30:25];
                    imm[4:1] <= ir[25:21];
                    imm[11] <= ir[20];
                    srcreg1_num[4:0] <= ir[19:5];
                    srcreg2_num[4:0] <= ir[24:20];
                end
                else if (ir[14:12] == 3'b100) begin
                    alucode <= `ALU_BLT;
                    imm[12] <= ir[31];
                    imm[10:5] <= ir[30:25];
                    imm[4:1] <= ir[25:21];
                    imm[11] <= ir[20];
                    srcreg1_num[4:0] <= ir[19:5];
                    srcreg2_num[4:0] <= ir[24:20];
                end
                else if (ir[14:12] == 3'b101) begin
                    alucode <= `ALU_BGE;
                    imm[12] <= ir[31];
                    imm[10:5] <= ir[30:25];
                    imm[4:1] <= ir[25:21];
                    imm[11] <= ir[20];
                    srcreg1_num[4:0] <= ir[19:5];
                    srcreg2_num[4:0] <= ir[24:20];
                end
                else if (ir[14:12] == 3'b110) begin
                    alucode <= `ALU_BLTU;
                    imm[12] <= ir[31];
                    imm[10:5] <= ir[30:25];
                    imm[4:1] <= ir[25:21];
                    imm[11] <= ir[20];
                    srcreg1_num[4:0] <= ir[19:5];
                    srcreg2_num[4:0] <= ir[24:20];
                end
                else if (ir[14:12] == 3'b111) begin
                    alucode <= `ALU_BGEU;
                    imm[12] <= ir[31];
                    imm[10:5] <= ir[30:25];
                    imm[4:1] <= ir[25:21];
                    imm[11] <= ir[20];
                    srcreg1_num[4:0] <= ir[19:5];
                    srcreg2_num[4:0] <= ir[24:20];
                end
            end
            `STORE:
                reg_we <= `DISABLE;
                is_load <= `DISABLE;
                is_store <= `ENABLE;
                is_halt <= `DISABLE;
                aluop1_type <= `OP_TYPE_REG;
                aluop2_type <= `OP_TYPE_REG;
                if (ir[14:12] == 3'b000) begin
                    alucode <= `ALU_SB;
                    imm[11:5] <= ir[31:25];
                    imm[4:0] <= ir[11:7];
                    srcreg1_num[4:0] <= ir[19:5];
                    srcreg2_num[4:0] <= ir[24:20];
                end
                else if (ir[14:12] == 3'b001) begin
                    alucode <= `ALU_SH;
                    imm[11:5] <= ir[31:25];
                    imm[4:0] <= ir[11:7];
                    srcreg1_num[4:0] <= ir[19:5];
                    srcreg2_num[4:0] <= ir[24:20];
                end
                else if (ir[14:12] == 3'b010) begin
                    alucode <= `ALU_SW;
                    imm[11:5] <= ir[31:25];
                    imm[4:0] <= ir[11:7];
                    srcreg1_num[4:0] <= ir[19:5];
                    srcreg2_num[4:0] <= ir[24:20];
                end
            end
            `LOAD:
                reg_we <= `ENABLE;
                is_load <= `ENABLE;
                is_store <= `DISABLE;
                is_halt <= `DISABLE;
                aluop1_type <= `OP_TYPE_REG;
                aluop2_type <= `OP_TYPE_IMM;
                if (ir[14:12] == 3'b000) begin
                    alucode <= `ALU_LB;
                    imm[11:0] <= ir[31:20];
                    dstreg_num[4:0] <= ir[11:7];
                    srcreg1_num[4:0] <= ir[19:5];
                end
                else if (ir[14:12] == 3'b001) begin
                    alucode <= `ALU_LH;
                    imm[11:0] <= ir[31:20];
                    dstreg_num[4:0] <= ir[11:7];
                    srcreg1_num[4:0] <= ir[19:5];
                end
                else if (ir[14:12] == 3'b010) begin
                    alucode <= `ALU_LW;
                    imm[11:0] <= ir[31:20];
                    dstreg_num[4:0] <= ir[11:7];
                    srcreg1_num[4:0] <= ir[19:5];
                end
                else if (ir[14:12] == 3'b100) begin
                    alucode <= `ALU_LBU;
                    imm[11:0] <= ir[31:20];
                    dstreg_num[4:0] <= ir[11:7];
                    srcreg1_num[4:0] <= ir[19:5];
                end
                else if (ir[14:12] == 3'b101) begin
                    alucode <= `ALU_LHU;
                    imm[11:0] <= ir[31:20];
                    dstreg_num[4:0] <= ir[11:7];
                    srcreg1_num[4:0] <= ir[19:5];
                end
            default: begin
                ;
            end
        endcase
    end
);
