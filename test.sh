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
        echo $file is not a correct option
        echo You have decoder and alu options
        ;;
esac