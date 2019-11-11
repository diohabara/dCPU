#!/bin/bash
read file
case $file in
    decoder)
        iverilog src/decoder.v src/decoder_tb.v
        src/a.out
        ;;
    alu)
        iverilog src/alu.v src/alu_tb.v
        src/a.out
        ;;
    *)
        echo $file is not a correct option
        echo You have decoder and alu options
        ;;
esac