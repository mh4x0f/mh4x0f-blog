.global _start
.text
_start:
        # 
	xor 	%rax,%rax                # zera o registrador evitar bad char
        movb     $1, %al                # move 1 para parte baixa do registrador 
        movb     $1, %dl                # file handle de saida para pate baixa 
        mov     $messagem, %rsi          # endereço da DB messagem // aqui onde tá o mal bad char endereço da msg :( 
        movb     $21, %dl               # números de bytes 
        syscall                         # kernel interrupção :D chama syscall

        # exit(0) vamos lá 
        movb     $60, %al               # system call 60 corresponde a exit(0)
        xor     %rdi, %rdi              # zerando rdi, argumento de retorno :D 
        syscall                         # chama syscall novamente :D 
messagem:
        .ascii  "Hello, World da vida\n"
-------------------------------------------------------------
root@ChmoSec:~/Desktop/linux# gcc -c msg.s && ld msg.o 
root@ChmoSec:~/Desktop/linux# ./a.out 
Hello, World da vida
root@ChmoSec:~/Desktop/linux# objdump -d a.out 

a.out:     file format elf64-x86-64


Disassembly of section .text:

0000000000400078 <_start>:
  400078:	48 31 c0             	xor    %rax,%rax
  40007b:	b0 01                	mov    $0x1,%al
  40007d:	b2 01                	mov    $0x1,%dl
  40007f:	48 c7 c6 91 00 40 00 	mov    $0x400091,%rsi
  400086:	b2 15                	mov    $0x15,%dl
  400088:	0f 05                	syscall 
  40008a:	b0 3c                	mov    $0x3c,%al
  40008c:	48 31 ff             	xor    %rdi,%rdi
  40008f:	0f 05                	syscall 

0000000000400091 :
  400091:	48                   	rex.W
  400092:	65                   	gs
  400093:	6c                   	insb   (%dx),%es:(%rdi)
  400094:	6c                   	insb   (%dx),%es:(%rdi)
  400095:	6f                   	outsl  %ds:(%rsi),(%dx)
  400096:	2c 20                	sub    $0x20,%al
  400098:	57                   	push   %rdi
  400099:	6f                   	outsl  %ds:(%rsi),(%dx)
  40009a:	72 6c                	jb     400108 
  40009c:	64 20 64 61 20       	and    %ah,%fs:0x20(%rcx,%riz,2)
  4000a1:	76 69                	jbe    40010c 
  4000a3:	64                   	fs
  4000a4:	61                   	(bad)  
  4000a5:	0a                   	.byte 0xa
root@ChmoSec:~/Desktop/linux# ./shellcode.sh a.out
"\x48\x31\xc0\xb0\x01\xb2\x01\x48\xc7\xc6\x91\x00\x40\x00\xb2\x15\x0f\x05\xb0\x3c\x48\x31\xff\x0f\x05\
x48\x65\x6c\x6c\x6f\x2c\x20\x57\x6f\x72\x6c\x64\x20\x64\x61\x20\x76\x69\x64\x61\x0a"
len:  46
root@ChmoSec:~/Desktop/linux#  :D mais ou menos 
