#!/bin/bash
read file
case $file in
    decoder)
        iverilog src/decoder.v test/decoder_tb.v
        ./a.out
        ;;
    alu)
        iverilog src/alu.v test/alu_tb.v
        ./a.out
        ;;
    *)
        echo "$file is not a correct option"
        echo "You have decoder and alu options"
        ;;
esac