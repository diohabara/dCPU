module npc(
    op, reg1, reg2, branch, nonbranch, addr;
);
    input [5:0] op;
    input [31:0] reg1, reg2, branch, nonbranch, addr;
    case (op)
        6'd32:
            4npc = (reg1 == reg2)? branch : nonbranch;
        6'd33:
            npc = (reg1 != reg2)? branch : nonbranch;
        6'd34:
            npc = (reg1 < reg2)? branch : nonbranch;
        6'd35:
            npc = (reg1 <= reg2)? branch : nonbranch;
        6'd40:
            npc = addr;
        6'd42:
            npc = reg1;
        default:
            npc = nonbranch
    endcase
endmodule // npc