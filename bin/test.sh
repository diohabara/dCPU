#!/bin/bash
read test_name
case $test_name in
    decoder)
        iverilog src/decoder.v test/decoder_tb.v
        ./a.out
        ;;
    alu)
        iverilog src/alu.v test/alu_tb.v
        ./a.out
        ;;
    cpu)
        iverilog src/*.v test/cpu_tb.v
        ./a.out
        ;;
    *)
        echo "$test_name is not a correct option"
        echo "You have decoder & alu & cpu options"
        ;;
esac