# dCPU

diohabara's CPU, or dCPU

## Environment

- OS: `Ubuntu 18.04.3 LTS`
- Assembly: `RISC-V`
- FPGA: `NEXYS`
- Vivado:  `v2019.1.3 (64-bit)`

## Overview

![CPU](img/cpu.png)

from <https://slideplayer.com/slide/3942827/>

## Test

Type this command

```sh
./test.sh
```

and type the component you would like to test

## Files description

- `define.vh`
  - header file
- `alu.v`
  - arithmetic logic unit
- `alu_tb.v`
  - test bench for arithmetic logic unit
- `decoder.v`
  - decoder
- `decoder_tb.v`
  - test bench for decoder
- `mem.v`
  - memory
- `reg.v`
  - register
- `fetch.v`
  - fetch instructions
- `adder.v`
  - adder

## referrences

- For RISC-V
  - <https://riscv.org/>
- For CPU
  - JPN
    - <https://toshiba.semicon-storage.com/jp/design-support/e-learning/micro_intro/>
  - ENG
    - <https://wwang.github.io/teaching/CS5513_Spr19/lectures/Base_CPU_Implementation.pdf>

## note

- [note in JPN](https://hackmd.io/_mzHwoncRbicxOlpW_OqbQ)
