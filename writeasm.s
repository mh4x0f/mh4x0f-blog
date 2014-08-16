.global _start
 .text
_start:
        # chamada das syscall 
        mov     $4, %eax                # system call número 4 encontrada na tabela:  cat /usr/include/asm/unistd_32.h  
        mov     $1, %ebx                # file handle de saiada 
        mov     $messagem, %ecx          # endereço da DB message
        mov     $21, %edx               # número de bytes sizeof(messagem)
        int     $0x80                   # chama kernel interrupção 
        
        # exit(0) 
        mov     $1, %eax                # system call 1 é a exit
        xor     %ebx, %ebx              # argumento de retorno
        int     $0x80                   # chama a syscall :D 
messagem:
        .ascii  "Hello, World da vida \n" # nossa string 
