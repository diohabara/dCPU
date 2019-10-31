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

    reg [4:0] rs1;
    reg [4:0] rs2;
    reg [4:0] rd;
    reg [4:0] imm5;
    reg [11:0] imm12;
    reg [12:0] imm13;
    reg [20:0] imm21;
    reg [31:0] imm32;
    reg [31:0] imm_tmp;

    always @(*) begin
        case (ir[6:0])
            `OPIMM: begin
                aluop1_type <= `OP_TYPE_REG;
                aluop2_type <= `OP_TYPE_IMM;
                reg_we <= `ENABLE;
                is_load <= `DISABLE;
                is_store <= `DISABLE;
                is_halt <= `DISABLE;
                rs1[4:0] <= ir[19:15];
                rs2[4:0] <= 5'b0;
                rd[4:0] <= ir[11:7];
                imm12[11:0] <= ir[31:20];
                if (ir[14:12] == 3'b000) begin
                    alucode <= `ALU_ADD;
                end
                else if (ir[14:12] == 3'b010) begin
                    alucode <= `ALU_SLT;
                end
                else if (ir[14:12] == 3'b011) begin
                    alucode <= `ALU_SLTU;
                end
                else if (ir[14:12] == 3'b100) begin
                    alucode <= `ALU_XOR;
                end
                else if (ir[14:12] == 3'b110) begin
                    alucode <= `ALU_OR;
                end
                else if (ir[14:12] == 3'b111) begin
                    alucode <= `ALU_AND;
                end
                else begin
                    imm5[4:0] <= ir[24:20];
                    if (ir[14:12] == 3'b001) begin
                        alucode <= `ALU_SLL;
                    end
                    else if (ir[14:12] == 3'b101 && ir[31:25] == 7'b0)begin
                        alucode <= `ALU_SRL;
                    end
                    else if (ir[14:12] == 3'b101 && ir[31:25] == 7'b0100000)begin
                        alucode <= `ALU_SRA;
                    end
                end
            end
            `OP: begin
                aluop1_type <= `OP_TYPE_REG;
                aluop2_type <= `OP_TYPE_REG;
                reg_we <= `ENABLE;
                is_load <= `DISABLE;
                is_store <= `DISABLE;
                is_halt <= `DISABLE;
                imm32[31:0] <= 32'b0;
                rs1[4:0] <= ir[19:15];
                rs2[4:0] <= ir[24:20];
                rd[4:0] <= ir[11:7];
                if (ir[31:25] == 7'b0000001) begin
                    ; // TODO: aditional codes
                    // if (ir[14:12] == 3'b000) begin
                    //     alucode <= ALU_MUL;
                    // end
                    // else if (ir[14:12] == 3'b001) begin
                    //     alucode <= ALU_MLUH;
                    // end
                    // else if (ir[14:12] == 3'b010) begin
                    //     alucode <= ALU_MULHSU;
                    // end
                    // else if (ir[14:12] == 3'b011) begin
                    //     alucode <= ALU_MULHU;
                    // end
                    // else if (ir[14:12] == 3'b100) begin
                    //     alucode <= ALU_DIV;
                    // end
                    // else if (ir[14:12] == 3'b101) begin
                    //     alucode <= ALU_DIVU;
                    // end
                    // else if (ir[14:12] == 3'b110) begin
                    //     alucode <= ALU_REM;
                    // end
                    // else if (ir[14:12] == 3'b111) begin
                    //     alucode <= ALU_REMU;
                    // end
                    // else;
                end
                else begin
                    if (ir[14:12] == 3'b000 && ir[31:25] == 7'b0) begin
                        alucode <= `ALU_ADD;
                    end
                    else if (ir[14:12] == 3'b000 && ir[31:25] == 7'b0100000) begin
                        alucode <= `ALU_SUB;
                    end
                    else if (ir[14:12] == 3'b001) begin
                        alucode <= `ALU_SLL;
                    end
                    else if (ir[14:12] == 3'b010) begin
                        alucode <= `ALU_SLT;
                    end
                    else if (ir[14:12] == 3'b011) begin
                        alucode <= `ALU_SLTU;
                    end
                    else if (ir[14:12] == 3'b100) begin
                        alucode <= `ALU_XOR;
                    end
                    else if (ir[14:12] == 3'b101 && ir[31:25] == 7'b0) begin
                        alucode <= `ALU_SRL;
                    end
                    else if (ir[14:12] == 3'b101 && ir[31:25] == 7'b0100000) begin
                        alucode <= `ALU_SRA;
                    end
                    else if (ir[14:12] == 3'b110) begin
                        alucode <= `ALU_OR;
                    end
                    else if (ir[14:12] == 3'b111) begin
                        alucode <= `ALU_AND;
                    end
                    else;
                end
            end
            `LUI: begin
                alucode <= 0;
                aluop1_type <= `OP_TYPE_NONE;
                aluop2_type <= `OP_TYPE_IMM;
                reg_we <= `ENABLE;
                is_load <= `DISABLE;
                is_store <= `DISABLE;
                is_halt <= `DISABLE;
                imm32[31:12] <= ir[31:12];
                rs1[4:0] <= 0;
                rs2[4:0] <= 5'b0;
                rd[4:0] <= ir[11:7];
            end
            `AUIPC: begin
                alucode <= `ALU_ADD;
                reg_we <= `ENABLE;
                is_load <= `DISABLE;
                is_store <= `DISABLE;
                is_halt <= `DISABLE;
                aluop1_type <= `OP_TYPE_IMM;
                aluop2_type <= `OP_TYPE_PC;
                imm32[31:12] <= ir[31:12];
                rs1[4:0] <= 0;
                rs2[4:0] <= 5'b0;
                rd[4:0] <= ir[11:7];
            end
            `JAL: begin
                alucode <= `ALU_JAL;
                aluop1_type <= `OP_TYPE_NONE;
                aluop2_type <= `OP_TYPE_PC;
                is_load <= `DISABLE;
                is_store <= `DISABLE;
                is_halt <= `DISABLE;
                imm21[20] <= ir[31];
                imm21[10:1] <= ir[30:21];
                imm21[11] <= ir[20];
                imm21[19:12] <= ir[19:12];
                imm21[0] <= 1'b0;
                rs1[4:0] <= 5'b0;
                rs2[4:0] <= 5'b0;
                rd[4:0] <= ir[11:7];
                reg_we <= rd[4:0] == 0? `DISABLE : `ENABLE;
            end
            `JALR: begin
                alucode <= `ALU_JALR;
                aluop1_type <= `OP_TYPE_REG;
                aluop2_type <= `OP_TYPE_IMM;
                reg_we <= `ENABLE;
                is_load <= `DISABLE;
                is_store <= `DISABLE;
                is_halt <= `DISABLE;
                imm12[11:0] <= ir[31:20];
                rs1[4:0] <= ir[19:15];
                rs2[4:0] <= 5'b0;
                rd[4:0] <= ir[11:7];
            end
            `BRANCH: begin
                aluop1_type <= `OP_TYPE_REG;
                aluop2_type <= `OP_TYPE_REG;
                reg_we <= `DISABLE;
                is_load <= `DISABLE;
                is_store <= `DISABLE;
                is_halt <= `DISABLE;
                imm13[12] <= ir[31];
                imm13[10:5] <= ir[30:25];
                imm13[4:1] <= ir[11:8];
                imm13[11] <= ir[7];
                imm13[0] <= 1'b0;
                rs1[4:0] <= ir[19:15];
                rs2[4:0] <= ir[24:20];
                rd[4:0] <= 5'b0;
                if (ir[14:12] == 3'b000) begin
                    alucode <= `ALU_BEQ;
                end
                else if (ir[14:12] == 3'b001) begin
                    alucode <= `ALU_BNE;
                end
                else if (ir[14:12] == 3'b100) begin
                    alucode <= `ALU_BLT;
                end
                else if (ir[14:12] == 3'b101) begin
                    alucode <= `ALU_BGE;
                end
                else if (ir[14:12] == 3'b110) begin
                    alucode <= `ALU_BLTU;
                end
                else if (ir[14:12] == 3'b111) begin
                    alucode <= `ALU_BGEU;
                end
                else;
            end
            `STORE: begin
                aluop1_type <= `OP_TYPE_REG;
                aluop2_type <= `OP_TYPE_IMM;
                reg_we <= `DISABLE;
                is_load <= `DISABLE;
                is_store <= `ENABLE;
                is_halt <= `DISABLE;
                imm12[11:5] <= ir[31:25];
                imm12[4:0] <= ir[11:7];
                rs1[4:0] <= ir[19:15];
                rs2[4:0] <= ir[24:20];
                rd[4:0] <= 5'b0;
                if (ir[14:12] == 3'b000) begin
                    alucode <= `ALU_SB;
                end
                else if (ir[14:12] == 3'b001) begin
                    alucode <= `ALU_SH;
                end
                else if (ir[14:12] == 3'b010) begin
                    alucode <= `ALU_SW;
                end
                else;
            end
            `LOAD: begin
                aluop1_type <= `OP_TYPE_REG;
                aluop2_type <= `OP_TYPE_IMM;
                reg_we <= `ENABLE;
                is_load <= `ENABLE;
                is_store <= `DISABLE;
                is_halt <= `DISABLE;
                imm12[11:0] <= ir[31:20];
                rs1[4:0] <= ir[19:15];
                rs2[4:0] <= 5'b0;
                rd[4:0] <= ir[11:7];
                if (ir[14:12] == 3'b000) begin
                    alucode <= `ALU_LB;
                end
                else if (ir[14:12] == 3'b001) begin
                    alucode <= `ALU_LH;
                end
                else if (ir[14:12] == 3'b010) begin
                    alucode <= `ALU_LW;
                end
                else if (ir[14:12] == 3'b100) begin
                    alucode <= `ALU_LBU;
                end
                else if (ir[14:12] == 3'b101) begin
                    alucode <= `ALU_LHU;
                end
                else;
            end
            default: ;
        endcase

        if (ir[6:0] == `OPIMM) begin
            if (alucode == `ALU_SLL || alucode == `ALU_SRL)
                imm_tmp = {{27{imm5[4]}}, imm5[4:0]};
            else if (alucode == `ALU_SRA)
                imm_tmp = {{27{imm5[4]}}, imm5[4:0]};
            else
                imm_tmp = {{20{imm12[11]}}, imm12[11:0]};
            end
        else if (ir[6:0] == `OP)
            imm_tmp = 32'b0;
        else if (ir[6:0] == `LUI)
            imm_tmp = {imm32[31:12], 12'b0};
        else if (ir[6:0] == `AUIPC)
            imm_tmp = {imm32[31:12], 12'b0};
        else if (ir[6:0] == `JAL)
            imm_tmp = {{20{imm21[11]}}, imm21[11:0]};
        else if (ir[6:0] == `JALR)
            imm_tmp = {{19{imm13[12]}}, imm13[12:0]};
        else if (ir[6:0] == `BRANCH)
            imm_tmp = {{19{imm13[12]}}, imm13[12:0]};
        else if (ir[6:0] == `STORE)
            imm_tmp = {{20{imm12[11]}}, imm12[11:0]};
        else if (ir[6:0] == `LOAD)
            imm_tmp = {{20{imm12[11]}}, imm12[11:0]};
        else;
    end
    assign srcreg1_num = rs1;
    assign srcreg2_num = rs2;
    assign dstreg_num = rd;
    assign imm = imm_tmp;
endmodule
