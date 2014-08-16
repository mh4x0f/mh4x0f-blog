# 64 bit msg write syscall 
#http://chmodsecurity.com.br/artigo/22/shellcode-64-bits-assembly-linguage-developer-[asm].html
.global _start
.text
_start:
        # 
        mov     $1, %rax                # system call 1 é a de escrita em 64
        mov     $1, %rdi                # file handle de saida
        mov     $messagem, %rsi          # endereço da DB messagem
        mov     $21, %rdx               # números de bytes 
        syscall                         # kernel interrupção :D chama syscall

        # exit(0) vamos lá 
        mov     $60, %rax               # system call 60 corresponde a exit(0)
        xor     %rdi, %rdi              # zerando rdi, argumento de retorno :D 
        syscall                         # chama syscall novamente :D 
messagem:
        .ascii  "Hello, World da vida\n"
==========================
root@ChmoSec:~/Desktop/linux# gcc -c msg.s 
root@ChmoSec:~/Desktop/linux# ld msg.o
root@ChmoSec:~/Desktop/linux# ./a.out 
Hello, World da vida root@ChmoSec:~/Desktop/linux#
root@ChmoSec:~/Desktop/linux# objdump -d a.out 

a.out:     file format elf64-x86-64


Disassembly of section .text:

0000000000400078 <_start>:
  400078:	48 c7 c0 01 00 00 00 	mov    $0x1,%rax
  40007f:	48 c7 c7 01 00 00 00 	mov    $0x1,%rdi
  400086:	48 c7 c6 a2 00 40 00 	mov    $0x4000a2,%rsi
  40008d:	48 c7 c2 15 00 00 00 	mov    $0x15,%rdx
  400094:	0f 05                	syscall 
  400096:	48 c7 c0 3c 00 00 00 	mov    $0x3c,%rax
  40009d:	48 31 ff             	xor    %rdi,%rdi
  4000a0:	0f 05                	syscall 

00000000004000a2 :
  4000a2:	48                   	rex.W
  4000a3:	65                   	gs
  4000a4:	6c                   	insb   (%dx),%es:(%rdi)
  4000a5:	6c                   	insb   (%dx),%es:(%rdi)
  4000a6:	6f                   	outsl  %ds:(%rsi),(%dx)
  4000a7:	2c 20                	sub    $0x20,%al
  4000a9:	57                   	push   %rdi
  4000aa:	6f                   	outsl  %ds:(%rsi),(%dx)
  4000ab:	72 6c                	jb     400119 
  4000ad:	64 20 64 61 20       	and    %ah,%fs:0x20(%rcx,%riz,2)
  4000b2:	76 69                	jbe    40011d 
  4000b4:	64                   	fs
  4000b5:	61                   	(bad)  
  4000b6:	20 0a                	and    %cl,(%rdx)

root@ChmoSec:~/Desktop/linux# chmod +x shellcode.sh 
root@ChmoSec:~/Desktop/linux# ls
msg.o  msg.s  shell  shellcode.sh  shell.s
root@ChmoSec:~/Desktop/linux# ./shellcode.sh shell
"\x48\xc7\xc0\x01\x00\x00\x00\x48\xc7\xc7\x01\x00\x00\x00\x48\xc7\xc6\xa2\x00\x40\x00\x48\xc7\xc2\x15\
x00\x00\x00\x0f\x05\x48\xc7\xc0\x3c\x00\x00\x00\x48\x31\xff\x0f\x05\x48\x65\x6c\x6c\x6f\x2c\x20\x57\x6f\x72\
x6c\x64\x20\x64\x61\x20\x76\x69\x64\x61\x20\x0a"
len:  64

Shellcode de tamanho 64 bytes:
"\x48\xc7\xc0\x01\x00\x00\x00\x48\xc7\xc7\x01\x00\x00\x00\x48\xc7\xc6\xa2\x00\x40\x00\x48\xc7\xc2\x15\x00\
x00\x00\x0f\x05\x48\xc7\xc0\x3c\x00\x00\x00\x48\x31\xff\x0f\x05\x48\x65\x6c\x6c\x6f\x2c\x20\x57\x6f\x72\x6c\x64\
x20\x64\x61\x20\x76\x69\x64\x61\x20\x0a"
