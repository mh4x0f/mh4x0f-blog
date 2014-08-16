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
