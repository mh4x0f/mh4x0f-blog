#!/bin/bash
# article: http://chmodsecurity.com.br/artigo/22/shellcode-64-bits-assembly-linguage-developer-[asm].html
code=$(objdump -d $1|grep '[0-9a-f]:'|grep -v 'file'|cut -f2 -d:|tr -s ' '|tr '\t' '!'|cut -d \! -f 2|sed s/^/\ /g|sed 's/ $//g'|sed 's/ /\\x/g'|paste -d '' -s |sed 's/^/"/'|sed 's/$/"/g')
len=$(echo $code|grep -o \\\\|wc -l)
echo $code
echo "len: " $len

