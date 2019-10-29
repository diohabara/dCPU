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
    output reg	     	reg_we,       // レジスタ書き込みの有無
    output reg		is_load,      // ロード命令判定フラグ
    output reg		is_store,     // ストア命令判定フラグ
    output reg      is_halt  // flag to halt

    initial begin
        is_halt <= 1'b0;
    end

    always * begin
        if (is_halt) begin
            $finish
        end else begin
            case (ir[6:0])
                0010011:
                    if (ir[14:12] == 3'b000) begin
                        imm[11:0] <= ir[31:20];
                        dstreg_num[4:0] <= ir[11:7];
                        srcreg1_num[4:0] <= ir[19:5];
                    end
                    else if (ir[14:12] == 3'b010) begin
                        imm[11:0] <= ir[31:20];
                        dstreg_num[4:0] <= ir[11:7];
                        srcreg1_num[4:0] <= ir[19:5];
                    end
                    else if (ir[14:12] == 3'b011) begin
                        imm[11:0] <= ir[31:20];
                        dstreg_num[4:0] <= ir[11:7];
                        srcreg1_num[4:0] <= ir[19:5];
                    end
                    else if (ir[14:12] == 3'b100) begin
                        imm[11:0] <= ir[31:20];
                        dstreg_num[4:0] <= ir[11:7];
                        srcreg1_num[4:0] <= ir[19:5];
                    end
                    else if (ir[14:12] == 3'b110) begin
                        imm[11:0] <= ir[31:20];
                        dstreg_num[4:0] <= ir[11:7];
                        srcreg1_num[4:0] <= ir[19:5];
                    end
                    else if (ir[14:12] == 3'b111) begin
                        imm[11:0] <= ir[31:20];
                        dstreg_num[4:0] <= ir[11:7];
                        srcreg1_num[4:0] <= ir[19:5];
                    end
                    else if (ir[14:12] == 3'b001) begin
                        imm[4:0] <= ir[24:20];
                        dstreg_num[4:0] <= ir[11:7];
                        srcreg1_num[4:0] <= ir[19:5];
                    end
                    else if (ir[14:12] == 3'b101 && ir[31:25] == 7'b0)begin
                        imm[4:0] <= ir[24:20];
                        dstreg_num[4:0] <= ir[11:7];
                        srcreg1_num[4:0] <= ir[19:5];
                    end
                    else if (ir[14:12] == 3'b101 && ir[31:25] == 7'b0100000)begin
                        imm[4:0] <= ir[24:20];
                        dstreg_num[4:0] <= ir[11:7];
                        srcreg1_num[4:0] <= ir[19:5];
                    end
                0110011:
                    if (ir[31:25] == 7b'0000001) begin
                        if (ir[14:12] == 3'b000) begin
                        dstreg_num[4:0] <= ir[11:7];
                        srcreg1_num[4:0] <= ir[19:5];
                        srcreg2_num[4:0] <= ir[24:20];
                        end
                        else if (ir[14:12] == 3'b001) begin
                        dstreg_num[4:0] <= ir[11:7];
                        srcreg1_num[4:0] <= ir[19:5];
                        srcreg1_num[4:0] <= ir[19:5];
                        srcreg2_num[4:0] <= ir[24:20];
                        end
                        else if (ir[14:12] == 3'b010) begin
                        dstreg_num[4:0] <= ir[11:7];
                        srcreg1_num[4:0] <= ir[19:5];
                        srcreg2_num[4:0] <= ir[24:20];
                        end
                        else if (ir[14:12] == 3'b011) begin
                        dstreg_num[4:0] <= ir[11:7];
                        srcreg1_num[4:0] <= ir[19:5];
                        srcreg2_num[4:0] <= ir[24:20];
                        end
                        else if (ir[14:12] == 3'b100) begin
                        dstreg_num[4:0] <= ir[11:7];
                        srcreg1_num[4:0] <= ir[19:5];
                        srcreg2_num[4:0] <= ir[24:20];
                        end
                        else if (ir[14:12] == 3'b101) begin
                        dstreg_num[4:0] <= ir[11:7];
                        srcreg1_num[4:0] <= ir[19:5];
                        srcreg2_num[4:0] <= ir[24:20];
                        end
                        else if (ir[14:12] == 3'b110) begin
                        dstreg_num[4:0] <= ir[11:7];
                        srcreg1_num[4:0] <= ir[19:5];
                        srcreg2_num[4:0] <= ir[24:20];
                        end
                        else if (ir[14:12] == 3'b111) begin
                        dstreg_num[4:0] <= ir[11:7];
                        srcreg1_num[4:0] <= ir[19:5];
                        srcreg2_num[4:0] <= ir[24:20];
                        end
                    end
                    else begin
                        if (ir[14:12] == 3'b000 && ir[31:25] == 7'b0) begin
                        dstreg_num[4:0] <= ir[11:7];
                        srcreg1_num[4:0] <= ir[19:5];
                        srcreg2_num[4:0] <= ir[24:20];
                        end
                        else if (ir[14:12] == 3'b000 && ir[31:25] == 7'b0100000) begin
                        dstreg_num[4:0] <= ir[11:7];
                        srcreg1_num[4:0] <= ir[19:5];
                        srcreg2_num[4:0] <= ir[24:20];
                        end
                        else if (ir[14:12] == 3'b001) begin
                        dstreg_num[4:0] <= ir[11:7];
                        srcreg1_num[4:0] <= ir[19:5];
                        srcreg2_num[4:0] <= ir[24:20];
                        end
                        else if (ir[14:12] == 3'b010) begin
                        dstreg_num[4:0] <= ir[11:7];
                        srcreg1_num[4:0] <= ir[19:5];
                        srcreg2_num[4:0] <= ir[24:20];
                        end
                        else if (ir[14:12] == 3'b011) begin
                        dstreg_num[4:0] <= ir[11:7];
                        srcreg1_num[4:0] <= ir[19:5];
                        srcreg2_num[4:0] <= ir[24:20];
                        end
                        else if (ir[14:12] == 3'b100) begin
                        dstreg_num[4:0] <= ir[11:7];
                        srcreg1_num[4:0] <= ir[19:5];
                        srcreg2_num[4:0] <= ir[24:20];
                        end
                        else if (ir[14:12] == 3'b101 && ir[31:25] == 7'b0) begin
                        dstreg_num[4:0] <= ir[11:7];
                        srcreg1_num[4:0] <= ir[19:5];
                        srcreg2_num[4:0] <= ir[24:20];
                        end
                        else if (ir[14:12] == 3'b101 && ir[31:25] == 7'b0100000) begin
                        dstreg_num[4:0] <= ir[11:7];
                        srcreg1_num[4:0] <= ir[19:5];
                        srcreg2_num[4:0] <= ir[24:20];
                        end
                        else if (ir[14:12] == 3'b110) begin
                        dstreg_num[4:0] <= ir[11:7];
                        srcreg1_num[4:0] <= ir[19:5];
                        srcreg2_num[4:0] <= ir[24:20];
                        end
                        else if (ir[14:12] == 3'b111) begin
                        dstreg_num[4:0] <= ir[11:7];
                        srcreg1_num[4:0] <= ir[19:5];
                        srcreg2_num[4:0] <= ir[24:20];
                        end
                    end
                0110111:
                    dstreg_num[4:0] <= ir[11:7];
                    imm[31:12] <= ir[31:12];
                    srcreg1_num[4:0] <= ir[19:5];
                0010111:
                    dstreg_num[4:0] <= ir[11:7];
                    imm[31:12] <= ir[31:12];
                    srcreg1_num[4:0] <= ir[19:5];
                1101111:
                    dstreg_num[4:0] <= ir[11:7];
                    imm[20] <= ir[31];
                    imm[10:1] <= ir[30:21];
                    imm[11] <= ir[20];
                    imm[19:12] <= ir[19:12];
                    srcreg1_num[4:0] <= ir[19:5];
                1100111:
                    dstreg_num[4:0] <= ir[11:7];
                    imm[11:0] <= ir[31:20];
                    srcreg1_num[4:0] <= ir[19:5];
                1100011:
                    if (ir[14:12] == 3'b000) begin
                        imm[12] <= ir[31];
                        imm[10:5] <= ir[30:25];
                        imm[4:1] <= ir[25:21];
                        imm[11] <= ir[20];
                        srcreg1_num[4:0] <= ir[19:5];
                        srcreg2_num[4:0] <= ir[24:20];
                    end
                    else if (ir[14:12] == 3'b001) begin
                        imm[12] <= ir[31];
                        imm[10:5] <= ir[30:25];
                        imm[4:1] <= ir[25:21];
                        imm[11] <= ir[20];
                        srcreg1_num[4:0] <= ir[19:5];
                        srcreg2_num[4:0] <= ir[24:20];
                    end
                    else if (ir[14:12] == 3'b100) begin
                        imm[12] <= ir[31];
                        imm[10:5] <= ir[30:25];
                        imm[4:1] <= ir[25:21];
                        imm[11] <= ir[20];
                        srcreg1_num[4:0] <= ir[19:5];
                        srcreg2_num[4:0] <= ir[24:20];
                    end
                    else if (ir[14:12] == 3'b101) begin
                        imm[12] <= ir[31];
                        imm[10:5] <= ir[30:25];
                        imm[4:1] <= ir[25:21];
                        imm[11] <= ir[20];
                        srcreg1_num[4:0] <= ir[19:5];
                        srcreg2_num[4:0] <= ir[24:20];
                    end
                    else if (ir[14:12] == 3'b110) begin
                        imm[12] <= ir[31];
                        imm[10:5] <= ir[30:25];
                        imm[4:1] <= ir[25:21];
                        imm[11] <= ir[20];
                        srcreg1_num[4:0] <= ir[19:5];
                        srcreg2_num[4:0] <= ir[24:20];
                    end
                    else if (ir[14:12] == 3'b111) begin
                        imm[12] <= ir[31];
                        imm[10:5] <= ir[30:25];
                        imm[4:1] <= ir[25:21];
                        imm[11] <= ir[20];
                        srcreg1_num[4:0] <= ir[19:5];
                        srcreg2_num[4:0] <= ir[24:20];
                    end
                0100011:
                    if (ir[14:12] == 3'b000) begin
                        imm[11:5] <= ir[31:25];
                        imm[4:0] <= ir[11:7];
                        srcreg1_num[4:0] <= ir[19:5];
                        srcreg2_num[4:0] <= ir[24:20];
                    end
                    else if (ir[14:12] == 3'b001) begin
                        imm[11:5] <= ir[31:25];
                        imm[4:0] <= ir[11:7];
                        srcreg1_num[4:0] <= ir[19:5];
                        srcreg2_num[4:0] <= ir[24:20];
                    end
                    else if (ir[14:12] == 3'b010) begin
                        imm[11:5] <= ir[31:25];
                        imm[4:0] <= ir[11:7];
                        srcreg1_num[4:0] <= ir[19:5];
                        srcreg2_num[4:0] <= ir[24:20];
                    end
                0000011:
                    if (ir[14:12] == 3'b000) begin
                        imm[11:0] <= ir[31:20];
                        dstreg_num[4:0] <= ir[11:7];
                        srcreg1_num[4:0] <= ir[19:5];
                    end
                    else if (ir[14:12] == 3'b001) begin
                        imm[11:0] <= ir[31:20];
                        dstreg_num[4:0] <= ir[11:7];
                        srcreg1_num[4:0] <= ir[19:5];
                    end
                    else if (ir[14:12] == 3'b010) begin
                        imm[11:0] <= ir[31:20];
                        dstreg_num[4:0] <= ir[11:7];
                        srcreg1_num[4:0] <= ir[19:5];
                    end
                    else if (ir[14:12] == 3'b100) begin
                        imm[11:0] <= ir[31:20];
                        dstreg_num[4:0] <= ir[11:7];
                        srcreg1_num[4:0] <= ir[19:5];
                    end
                    else if (ir[14:12] == 3'b101) begin
                        imm[11:0] <= ir[31:20];
                        dstreg_num[4:0] <= ir[11:7];
                        srcreg1_num[4:0] <= ir[19:5];
                    end
                default: begin
                    ;
                end
                end
            endcase
        end
    end
);
