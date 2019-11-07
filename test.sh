#!/bin/bash
read file
case $file in
    decoder)
        iverilog ./decoder.v ./decoder_tb.v
        ./a.out
        ;;
    alu)
        iverilog ./alu.v ./alu_tb.v
        ./a.out
        ;;
    *)
esac