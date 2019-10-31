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

    reg [4:0] r1;
    reg [4:0] r2;
    reg [4:0] rd;
    reg [4:0] imm5;
    reg [11:0] imm12;
    reg [12:0] imm13;
    reg [20:0] imm21;
    reg [32:0] imm32;
    reg [32:0] imm_reg;

    always @(*) begin
        case (ir[6:0])
            `OPIMM: begin
                aluop1_type <= `OP_TYPE_REG;
                aluop2_type <= `OP_TYPE_IMM;
                reg_we <= `ENABLE;
                is_load <= `DISABLE;
                is_store <= `DISABLE;
                is_halt <= `DISABLE;
                r1[4:0] <= ir[19:15];
                r2[4:0] <= 5'b0;
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
                r1[4:0] <= ir[19:15];
                r2[4:0] <= ir[24:20];
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
                aluop1_type <= `OP_TYPE_REG;
                aluop2_type <= `OP_TYPE_PC;
                reg_we <= `DISABLE;
                is_load <= `DISABLE;
                is_store <= `DISABLE;
                is_halt <= `DISABLE;
                imm32[31:12] <= ir[31:12];
                r1[4:0] <= ir[19:15];
                r2[4:0] <= 5'b0;
                rd[4:0] <= ir[11:7];
            end
            `AUIPC: begin
                reg_we <= `DISABLE;
                is_load <= `DISABLE;
                is_store <= `DISABLE;
                is_halt <= `DISABLE;
                aluop1_type <= `OP_TYPE_PC;
                aluop2_type <= `OP_TYPE_IMM;
                imm32[31:12] <= ir[31:12];
                r1[4:0] <= ir[19:15];
                r2[4:0] <= 5'b0;
                rd[4:0] <= ir[11:7];
            end
            `JAL: begin
                aluop1_type <= `OP_TYPE_PC;
                aluop2_type <= `OP_TYPE_IMM;
                reg_we <= `DISABLE;
                is_load <= `DISABLE;
                is_store <= `DISABLE;
                is_halt <= `DISABLE;
                imm21[20] <= ir[31];
                imm21[10:1] <= ir[30:21];
                imm21[11] <= ir[20];
                imm21[19:12] <= ir[19:12];
                r1[4:0] <= ir[19:15];
                r2[4:0] <= 5'b0;
                rd[4:0] <= ir[11:7];
            end
            `JALR: begin
                aluop1_type <= `OP_TYPE_REG;
                aluop2_type <= `OP_TYPE_IMM;
                reg_we <= `DISABLE;
                is_load <= `DISABLE;
                is_store <= `DISABLE;
                is_halt <= `DISABLE;
                imm12[11:0] <= ir[31:20];
                r1[4:0] <= ir[19:15];
                r2[4:0] <= 5'b0;
                rd[4:0] <= ir[11:7];
            end
            `BRANCH: begin
                aluop1_type <= `OP_TYPE_PC;
                aluop2_type <= `OP_TYPE_IMM;
                reg_we <= `DISABLE;
                is_load <= `DISABLE;
                is_store <= `DISABLE;
                is_halt <= `DISABLE;
                imm13[12] <= ir[31];
                imm13[10:5] <= ir[30:25];
                imm13[4:1] <= ir[25:21];
                imm13[11] <= ir[20];
                r1[4:0] <= ir[19:15];
                r2[4:0] <= ir[24:20];
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
                aluop2_type <= `OP_TYPE_REG;
                reg_we <= `DISABLE;
                is_load <= `DISABLE;
                is_store <= `ENABLE;
                is_halt <= `DISABLE;
                imm12[11:5] <= ir[31:25];
                imm12[4:0] <= ir[11:7];
                r1[4:0] <= ir[19:15];
                r2[4:0] <= ir[24:20];
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
                r1[4:0] <= ir[19:15];
                r2[4:0] <= 5'b0;
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
            if (imm12 != 12'b0)
                assign imm_reg <= {{12{imm12[11]}}, imm12};
            else
                assign imm_reg <= {{5{imm5[4]}}, imm5};
        end
        else if (ir[6:0] == `OP)
            assign imm_reg <= 32'b0;
        else if (ir[6:0] == `LUI)
            assign imm_reg <= imm32;
        else if (ir[6:0] == `AUIPC)
            assign imm_reg <= {{21{imm21[20]}}, imm21};
        else if (ir[6:0] == `JAL)
            assign imm_reg <= {{12{imm12[11]}}, imm12};
        else if (ir[6:0] == `JALR)
            assign imm_reg <= {{13{imm13[12]}}, imm13};
        else if (ir[6:0] == `BRANCH)
            assign imm_reg <= {{13{imm13[12]}}, imm13};
        else if (ir[6:0] == `STORE)
            assign imm_reg <= {{12{imm12[11]}}, imm12};
        else if (ir[6:0] == `LOAD)
            assign imm_reg <= {{12{imm12[11]}}, imm12};
        else;
        end
    end
    assign srcreg1_num = r1;
    assign srcreg2_num = r2;
    assign dstreg_num = rd;
    assign imm = imm_reg;
endmodule
