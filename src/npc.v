module npc(
    op, reg1, reg2, branch, nonbranch, addr, npc
);
    input [5:0] op;
    input [31:0] reg1, reg2, branch, nonbranch, addr;
    output npc;
    reg npc_tmp;

    always @(*) begin
        case (op)
            6'd32:
                npc_tmp <= (reg1 == reg2)? branch : nonbranch;
            6'd33:
                npc_tmp <= (reg1 != reg2)? branch : nonbranch;
            6'd34:
                npc_tmp <= (reg1 < reg2)? branch : nonbranch;
            6'd35:
                npc_tmp <= (reg1 <= reg2)? branch : nonbranch;
            6'd40:
                npc_tmp <= addr;
            6'd42:
                npc_tmp <= reg1;
            default:
                npc_tmp <= nonbranch;
        endcase
    end

    assign npc = npc_tmp;
endmodule // npc