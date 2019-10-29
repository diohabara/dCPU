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
                    end
                    else if (ir[14:12] == 3'b010) begin
                        imm[11:0] <= ir[31:20];
                    end
                    else if (ir[14:12] == 3'b011) begin
                        imm[11:0] <= ir[31:20];
                    end
                    else if (ir[14:12] == 3'b100) begin
                        imm[11:0] <= ir[31:20];
                    end
                    else if (ir[14:12] == 3'b110) begin
                        imm[11:0] <= ir[31:20];
                    end
                    else if (ir[14:12] == 3'b111) begin
                        imm[11:0] <= ir[31:20];
                    end
                    else if (ir[14:12] == 3'b001) begin
                        imm[4:0] <= ir[24:20];
                    end
                    else if (ir[14:12] == 3'b101 && ir[31:25] == 7'b0)begin
                        imm[4:0] <= ir[24:20];
                    end
                    else if (ir[14:12] == 3'b101 && ir[31:25] == 7'b0100000)begin
                        imm[4:0] <= ir[24:20];
                    end
                0110111:
                    if (ir[14:12] == 3'b000 && ir[31:25] == 7'b0) begin
                    end
                    else if (ir[14:12] == 3'b000 && ir[31:25] == 7'b0100000) begin
                    end
                    else if (ir[14:12] == 3'b001) begin
                    end
                    else if (ir[14:12] == 3'b010) begin
                    end
                    else if (ir[14:12] == 3'b011) begin
                    end
                    else if (ir[14:12] == 3'b100) begin
                    end
                    else if (ir[14:12] == 3'b101 && ir[31:25] == 7'b0) begin
                    end
                    else if (ir[14:12] == 3'b101 && ir[31:25] == 7'b0100000) begin
                    end
                    else if (ir[14:12] == 3'b110) begin
                    end
                    else if (ir[14:12] == 3'b111) begin
                    end
                0110111:
                0010111:
                1101111:
                1100011:
                    if (ir[14:12] == 3'b000) begin
                    end
                    else if (ir[14:12] == 3'b001) begin
                    end
                    else if (ir[14:12] == 3'b100) begin
                    end
                    else if (ir[14:12] == 3'b101) begin
                    end
                    else if (ir[14:12] == 3'b110) begin
                    end
                    else if (ir[14:12] == 3'b111) begin
                    end
                0100011:
                    if (ir[14:12] == 3'b000) begin
                    end
                    else if (ir[14:12] == 3'b001) begin
                    end
                    else if (ir[14:12] == 3'b010) begin
                    end
                0000011:
                    if (ir[14:12] == 3'b000) begin
                    end
                    else if (ir[14:12] == 3'b001) begin
                    end
                    else if (ir[14:12] == 3'b010) begin
                    end
                    else if (ir[14:12] == 3'b100) begin
                    end
                    else if (ir[14:12] == 3'b101) begin
                    end
                default: begin
                end
            endcase
        end
    end
);
