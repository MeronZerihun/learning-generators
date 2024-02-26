# Learning Generators
To run the test bench with the XOR cipher generator:
```bash
$ verilator --Wall --cc xor_gen.sv tb_xor_gen.sv --timing --binary
$ ./obj_dir/Vxor_gen
```
