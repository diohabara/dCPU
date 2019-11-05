# dCPU

diohabara's CPU, or dCPU

## environment

- OS: `Ubuntu 18.04.3 LTS`
- Assembly: `RISC-V`
- FPGA: `NEXYS`
- Vivado:  `v2019.1.3 (64-bit)`

## Overview

![CPU](img/cpu.png) [^1]

[1]:from <https://slideplayer.com/slide/3942827/>

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
- `memory.v`
  - memory
- `memory_tb.v`
  - test bench for memory

<!--
- `register.v`
  - register
- `register_tb.v`
  - test bench for register
- `mutiplexer.v`
  - multiplexer
- `mutiplexer_tb.v`
  - test bench for multiplexer
- `dataMemory.v`
  - data memory
- `dataMemory_tb.v`
  - test bench for data memory
-->

## referrences

- For RISC-Vp
  - <https://riscv.org/>
- For CPU
  - JPN
    - <https://toshiba.semicon-storage.com/jp/design-support/e-learning/micro_intro/>
  - ENG
    - <https://wwang.github.io/teaching/CS5513_Spr19/lectures/Base_CPU_Implementation.pdf>

## note

- [note in JPN](https://hackmd.io/_mzHwoncRbicxOlpW_OqbQ)
