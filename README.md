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
for building, linking and executing x86 x86.

Add `-g` in nasm for debug options. Start debugging with

```
gdb ./program
```
Use `lay next` to enter assembly view and set a break point like `b _start`. Start the program with `run` and go to the next instruction with `next/nexti`. Check the information on the registers with `info registers/info register rax/eax`.

# Do not forget to RTFM

`https://www.intel.com/content/www/us/en/developer/articles/technical/intel-sdm.html` 
