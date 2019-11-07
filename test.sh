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
    memory)
        ;;
    *)
        echo $file is not a correct option
        ;;
esac