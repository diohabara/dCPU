# テンプレートプロジェクト
これはRISC-V (RV32I) 向けにプログラムをコンパイルするためのテンプレートプロジェクトです．

## 使い方
```
$ make
```

## 生成物
- prog.elf
- prog.bin
- prog.hex
- code.hex
- data.hex

`make`すると上の3つのファイルが順に生成されます．
prog.elfはELF形式の実行ファイル、prog.binはそれを`objdump -D`したもの、prog.hexはメモリ上に展開されたprog.elfをテキスト形式にしてVerilogの`$readmemh`で読めるようにしたものです．
さらに，code.hex と data.hex は実験で使うためにprog.hexをコードとデータに分離したものです．

`objdump`したりその出力を加工するのには`../Tools`内のPythonスクリプトが使われます。