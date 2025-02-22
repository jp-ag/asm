Learning assembly x86 and x86_64 initially.

```
nasm -f elf64 -o hello_world.o hello_world.asm
ld  -o hello_world hello_world.o
./hello_world
```
for building, linking and executing x64.

```
nasm -f elf -o hello_elf32.o hello_elf32.asm
ld -m elf_i386 -o hello_elf32 hello_elf32.o
./hello_elf32
```
for building, linking and executing x86 x86
